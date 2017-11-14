//
//  orderView.m
//  Puzzle
//
//  Created by 王武 on 2017/10/21.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "orderView.h"


@implementation orderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




-(instancetype)init{
    if (self = [super init]) {
        [self creatUI];
    }
    return self;
}

-(void)setTipsWithWaitPayCount:(NSInteger)payCount
                  andSendCount:(NSInteger)sendCount
               andReceiveCount:(NSInteger)receiveCount
              andAppraiseCount:(NSInteger) appraiseCount{
    
}



-(void)creatUI{
    
    orderBT* payBt = [orderBT creatBtWithImage:@"user_waitToPay"
                                  andImageSize:CGSizeMake(19, 17)
                             andDispatchHeight:5
                            andlabelLineHeight:30
                                andButtonFrame:CGRectZero
                               andPicDirection:ImageTop
                                     andTarget:self
                                           sel:@selector(funPay)
                             andLabelTextColor:USER_ORDER_COLOR
                                   andTextFont:[UIFont systemFontOfSize:13]
                                  andLabelText:@"待付款"
                                   andTipCount:0
                             andTipCenterPoint:CGPointMake(8, -18)];
    [self addSubview: payBt];
    
    [payBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(100);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    
    orderBT* sendBt = [orderBT creatBtWithImage:@"user_waitToSend"
                                   andImageSize:CGSizeMake(19, 18)
                              andDispatchHeight:5
                             andlabelLineHeight:30
                                 andButtonFrame:CGRectMake(0, 80, 60, 160)
                                andPicDirection:ImageTop
                                      andTarget:self
                                            sel:@selector(funSend)
                              andLabelTextColor:USER_ORDER_COLOR
                                    andTextFont:[UIFont systemFontOfSize:13]
                                   andLabelText:@"待发货"
                                    andTipCount:0
                              andTipCenterPoint:CGPointMake(8, -18)];
    [self addSubview: sendBt];
    [sendBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(payBt);
        make.centerY.mas_equalTo(payBt);
        make.left.mas_equalTo(payBt.mas_right);
    }];
    [sendBt setTipCount:3];
    
    orderBT* receiveBt = [orderBT creatBtWithImage:@"user_waitToReceive"
                                      andImageSize:CGSizeMake(18, 18)
                                 andDispatchHeight:5
                                andlabelLineHeight:30
                                    andButtonFrame:CGRectMake(0, 260, 160, 60)
                                   andPicDirection:ImageTop
                                         andTarget:self
                                               sel:@selector(funReceive)
                                 andLabelTextColor:USER_ORDER_COLOR
                                       andTextFont:[UIFont systemFontOfSize:13]
                                      andLabelText:@"待收货"
                                       andTipCount:0
                                 andTipCenterPoint:CGPointMake(8, -18)];
    [self addSubview: receiveBt];
    [receiveBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(payBt);
        make.centerY.mas_equalTo(payBt);
        make.left.mas_equalTo(sendBt.mas_right);
    }];
    [receiveBt setTipCount:10];
    
    orderBT* appAppraiseBt = [orderBT creatBtWithImage:@"User_waitToAppraise"
                                          andImageSize:CGSizeMake(18, 18)
                                     andDispatchHeight:5
                                    andlabelLineHeight:30
                                        andButtonFrame:CGRectMake(0, 340, 60, 160)
                                       andPicDirection:ImageTop
                                             andTarget:self
                                                   sel:@selector(funAppraise)
                                     andLabelTextColor:USER_ORDER_COLOR
                                           andTextFont:[UIFont systemFontOfSize:13]
                                          andLabelText:@"待评价"
                                           andTipCount:0
                                     andTipCenterPoint:CGPointMake(8, -18)];
    [self addSubview: appAppraiseBt];
    [appAppraiseBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(payBt);
        make.centerY.mas_equalTo(payBt);
        make.left.mas_equalTo(receiveBt.mas_right);
        make.right.mas_equalTo(self.mas_right);
    }];
    [appAppraiseBt setTipCount:0];
    
}


- (UIViewController*)viewController {
    for (UIView* nextVC = [self superview]; nextVC; nextVC = nextVC.superview) {
        UIResponder* nextResponder = [nextVC nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
//    代付款
-(void)funPay{
    
}
// 代发货
-(void)funSend{
    
}
// 待收货
-(void)funReceive{
    
}
//待评价
-(void)funAppraise{
    
}

@end
