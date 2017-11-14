//
//  addressCell.m
//  Puzzle
//
//  Created by 王武 on 2017/10/26.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "addressCell.h"

@interface addressCell ()

@property (nonatomic,strong) UILabel* nameLabel;

@property (nonatomic,strong) UILabel* phoneLabel;

@property (nonatomic,strong) UILabel* addressLabel;

@end


@implementation addressCell



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
   // _addressLabel = [[UILabel alloc]init];
    _addressLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width-20;
    _addressLabel.numberOfLines = 0;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.bottom.mas_equalTo(0);
    }];
    
}

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
