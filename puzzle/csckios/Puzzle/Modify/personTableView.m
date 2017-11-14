//
//  personTableView.m
//  Puzzle
//
//  Created by 王飞 on 2017/10/12.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "personTableView.h"
#import "orderBT.h"
#import "orderView.h"
#import "myAddressVC.h" // 地址
#import "myDisCountVC.h"  // 优惠券

#define USER_TABLEVIEWOFFSET 8

@interface personTableView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView* tableView;


@property (nonatomic,strong) NSMutableArray* dataArary;

@property (nonatomic,strong) UIImageView* headImageV;  // 头像

@property (nonatomic,strong) UILabel* nameLabel;

@property (nonatomic,strong) orderView* orderView;

// 所有cell的imageV
@property (nonatomic,strong) UIImageView* allCellBackImageV;

@property (nonatomic,strong) NSArray* titleArray;

@end

@implementation personTableView

-(NSArray*)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"我的地址",@"我的优惠券"];
    }
    return _titleArray;
}


-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake((WIDE-rate(359))/2.0+ USER_TABLEVIEWOFFSET/2.0, 0, rate(359-USER_TABLEVIEWOFFSET), HIGH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView =[UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 14, rate(359), rate(314))];
      
        UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake(-USER_TABLEVIEWOFFSET/2.0, rate(39)+54, headView.frame.size.width, rate(214))];
        imageV.image = [UIImage imageNamed:@"userBackHead"];
        [headView addSubview:imageV];
        
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = [UIImage imageNamed:@"tempHead"];
        _headImageV.layer.borderWidth = 1;
        _headImageV.layer.borderColor = [UIColor whiteColor].CGColor;
        _headImageV.layer.cornerRadius = rate(39);
        _headImageV.layer.masksToBounds = YES;
        [headView addSubview:_headImageV];
        [_headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(rate(78), rate(78)));
            make.top.mas_equalTo(58);
            make.centerX.mas_equalTo(headView);
        }];

        _nameLabel = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:1 font:[UIFont systemFontOfSize:17] textColor:USER_ORDER_COLOR text:@"宝宝～"];
        [headView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rate(42));
            make.centerX.mas_equalTo(headView);
            make.top.mas_equalTo(_headImageV.mas_bottom);
        }];
     
        _tableView.tableHeaderView = headView;
        
        UIButton* orderBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(lookOrder:) titleColor:nil font:nil image:nil backGroundImage:nil title:nil];
        [headView addSubview:orderBt];
        [orderBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rate(55));
            make.width.mas_equalTo(headView);
            make.top.mas_equalTo(_nameLabel.mas_bottom);
        }];
        UILabel* orderLabel = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:0 font:[UIFont systemFontOfSize:15] textColor:USER_ORDER_COLOR text:@"我的订单"];
        orderLabel.userInteractionEnabled = NO;
        [orderBt addSubview:orderLabel];
        [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(orderBt);
            make.left.mas_equalTo(rate(10));
            make.top.mas_equalTo(orderBt.mas_top);
        }];
        
      
        UIImageView* enterImageV = [WWUI creatImageView:CGRectZero backGroundImageV:@"qianjin"];
        [orderBt addSubview:enterImageV];
        [enterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(orderLabel);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.right.mas_equalTo(orderBt.mas_right).offset(-10);
        }];
        
        
        UILabel* orderLabelRight = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:2 font:[UIFont systemFontOfSize:15] textColor:[UIColor colorWithRed:211.0/255 green:212.0/255 blue:213.0/255 alpha:1.0] text:@"查看全部订单"];
        [orderBt addSubview:orderLabelRight];
        orderLabelRight.userInteractionEnabled = NO;
        [orderLabelRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(orderLabel);
            make.centerY.mas_equalTo(orderLabel);
            make.right.mas_equalTo(enterImageV.mas_left).offset(-4);
        }];
        
        UIView* lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithRed:211.0/255 green:212.0/255 blue:213.0/255 alpha:1.0];
        [headView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(orderLabel.mas_left);
            make.right.mas_equalTo(enterImageV.mas_right);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(orderBt.mas_bottom);
        }];
        
        // 订单试图
        _orderView = [[orderView alloc]init];
        [headView addSubview:_orderView];
        [_orderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(imageV);
            make.top.mas_equalTo(lineView.mas_bottom);
            make.bottom.mas_equalTo(imageV.mas_bottom);
            make.left.mas_equalTo(imageV.mas_left);
            
        }];
             
        _tableView.backgroundColor = [UIColor clearColor];
           }
    
    
    return _tableView;
}


-(void)fun1{
   
    
    NSLog(@"按钮触发");
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
        
        _allCellBackImageV = [WWUI creatImageView:CGRectZero backGroundImageV:@"userBackBottom"];
        [self addSubview:_allCellBackImageV];
        _allCellBackImageV.frame = CGRectMake((WIDE-rate(359))/2.0, rate(314),rate(359), rate(264));

        [self bringSubviewToFront:self.tableView];

    }
    return self;
}

#pragma mark -- 代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.textLabel.textColor = USER_ORDER_COLOR;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(rate(10), rate(56), rate(339), 1)];
        lineView.backgroundColor = [UIColor colorWithRed:211.0/255 green:212.0/255 blue:213.0/255 alpha:1.0];;
        [cell addSubview:lineView];
        
        UIImageView* enterImageV = [WWUI creatImageView:CGRectZero backGroundImageV:@"qianjin"];
        [cell addSubview:enterImageV];
        [enterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.textLabel);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.right.mas_equalTo(cell.mas_right).offset(-8);
        }];

        
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rate(57);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController* superVC =  [self viewController];
    if (!indexPath.row) { // 地址
        myAddressVC* vc  = [[myAddressVC alloc]init];
        
        if (superVC) {
            [superVC.navigationController pushViewController:vc animated:YES];
        }
    }
    else{
        myDisCountVC* vc = [[myDisCountVC alloc]init];
        [superVC.navigationController pushViewController:vc animated:YES];
    }
}

//获取VC
- (UIViewController*)viewController {
    for (UIView* nextVC = [self superview]; nextVC; nextVC = nextVC.superview) {
        UIResponder* nextResponder = [nextVC nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark --action
// look orderList
-(void)lookOrder:(UIButton*)bt{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"1");
    
    _allCellBackImageV.frame = CGRectMake((WIDE-rate(359))/2.0, -scrollView.contentOffset.y+rate(314), rate(359), rate(264));
    /*
    [_allCellBackImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.tableHeaderView.mas_bottom);
        make.centerX.mas_equalTo(self.tableView.tableHeaderView);
        make.size.mas_equalTo(CGSizeMake(rate(359), rate(264)));
    }];
     */

}
//tableViewDelegate


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
