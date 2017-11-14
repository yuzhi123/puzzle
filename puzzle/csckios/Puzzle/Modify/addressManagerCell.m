//
//  addressManagerCell.m
//  Puzzle
//
//  Created by 王飞 on 2017/11/6.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "addressManagerCell.h"
#import "addressModel.h"
#import "addressAddVC.h"

@interface addressManagerCell ()

@property (nonatomic,strong) UILabel* nameLabel;

@property (nonatomic,strong) UILabel* phoneLabel;

@property (nonatomic,strong) UILabel* addressLabel;

@property (nonatomic,strong) orderBT* chooseBt;

@property (nonatomic,strong) orderBT* editingBt;

@property (nonatomic,strong) orderBT* deleteBt;

@end

@implementation addressManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    _nameLabel = [WWUI creatLabel:CGRectZero backGroundColor:[UIColor clearColor] textAligment:1 font:[UIFont systemFontOfSize:13] textColor:USER_ORDER_COLOR text:@"王武"];
    [self.contentView addSubview:_nameLabel];
    _nameLabel.extraWidth = 16;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(20);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(0);
    }];
    
    _phoneLabel = [WWUI creatLabel:CGRectZero backGroundColor:[UIColor clearColor] textAligment:1 font:[UIFont systemFontOfSize:13] textColor:USER_ORDER_COLOR text:@"13387564806"];
    [self.contentView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(_nameLabel);
        make.centerY.mas_equalTo(_nameLabel);
    }];
    _phoneLabel.extraWidth = 16;
    
    _addressLabel = [WWUI creatLabel:CGRectZero backGroundColor:[UIColor clearColor] textAligment:0 font:[UIFont systemFontOfSize:13] textColor:USER_ORDER_COLOR text:@"湖北省孝感市应城市陈河镇仁和乡张咀村张咀湾《中华人民共和国道路交通安全法实施条例》第一百零九条第一款：对道路交通安全违法行为人处以罚款或者暂扣驾驶证处罚的，由违法行为发生地的县级以上人民政府公安机关交通管理部门或者相当于同级的公安机关交通管理部门作出决定；对处以吊销机动车驾驶证处罚的，由设区的市人民政府公安机关交通管理部门或者相当于同级的公安机关交通管理部门作出决定"];
    _addressLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width-20;
    _addressLabel.numberOfLines = 0;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
      
    }];
    
    UIView* lineView = [[UIView alloc]init];
    lineView.backgroundColor = USER_BACK_COLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.mas_equalTo(_addressLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(0.5);
    }];
   
    // 设置默认地址
    _chooseBt = [orderBT creatBtWithImage:@"user_unChoose" andImageSize:CGSizeMake(15, 15) andDispatchHeight:5 andlabelLineHeight:20 andButtonFrame:CGRectZero andPicDirection:ImageLeft andTarget:self sel:@selector(settingDefault) andLabelTextColor:USER_ORDER_COLOR andTextFont:[UIFont systemFontOfSize:12] andLabelText:@"设置默认地址" andTipCount:0 andTipCenterPoint:CGPointZero];
    [self.contentView addSubview:_chooseBt];
    [_chooseBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(8);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.width.mas_equalTo(110);
        make.bottom.mas_equalTo(0);
    }];
    
    // 删除地址
    _deleteBt = [orderBT creatBtWithImage:@"user_delete" andImageSize:CGSizeMake(15, 20) andDispatchHeight:5 andlabelLineHeight:20 andButtonFrame:CGRectZero andPicDirection:ImageLeft andTarget:self sel:@selector(deleteAddress) andLabelTextColor:USER_ORDER_COLOR andTextFont:[UIFont systemFontOfSize:12] andLabelText:@"删除" andTipCount:0 andTipCenterPoint:CGPointZero];
     [self.contentView addSubview:_deleteBt];
    [_deleteBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(_chooseBt);
        make.right.offset(-8);
        make.centerY.mas_equalTo(_chooseBt);
    }];
   
    
    //修改地址
    _editingBt = [orderBT creatBtWithImage:@"user_editing" andImageSize:CGSizeMake(15, 16) andDispatchHeight:5 andlabelLineHeight:20 andButtonFrame:CGRectZero andPicDirection:ImageLeft andTarget:self sel:@selector(changeAddress) andLabelTextColor:USER_ORDER_COLOR andTextFont:[UIFont systemFontOfSize:12] andLabelText:@"编辑" andTipCount:0 andTipCenterPoint:CGPointZero];
    [self.contentView addSubview:_editingBt];
    [_editingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(_chooseBt);
        make.right.mas_equalTo(_deleteBt.mas_left).offset(-8);
        make.centerY.mas_equalTo(_chooseBt);
    }];

}

#pragma mark -- 获取vc
- (UIViewController*)viewController {
    for (UIView* nextVC = [self superview]; nextVC; nextVC = nextVC.superview) {
        UIResponder* nextResponder = [nextVC nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma  mark -- action
// 设置默认地址
-(void)settingDefault{
    
    NSLog(@"设置默认地址");
    
}

// 删除地址操作
-(void)deleteAddress{
    
    NSLog(@"删除操作");
}

//修改地址操作
-(void)changeAddress{
    
     NSLog(@"修改操作");
    UIViewController* vc = [self viewController];
    if (vc) {
        addressAddVC* nextVC = [[addressAddVC alloc]init];
        [vc.navigationController pushViewController:nextVC animated:YES];
    }
    
}

#pragma mark -- config

// 负值

-(void)configModel:(addressModel*)model{
    
    
    _nameLabel.text = model.name;
    _addressLabel.text = model.address;
}

-(CGFloat)getHeightWithModel:(addressModel*)model{
    
    [self configModel:model];
    
    [self layoutIfNeeded];
    
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:
                          UILayoutFittingCompressedSize].height+1;
    return cellHeight;
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
