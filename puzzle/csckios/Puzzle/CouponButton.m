//
//  CouponButton.m
//  Puzzle
//
//  Created by yiliu on 16/10/10.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "CouponButton.h"

@implementation CouponButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
        
    }
    return self;
}

- (void)loadView {
    
    UIImageView *couponIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 10, 10)];
    couponIconImageView.image = [UIImage imageNamed:@"biaoqian"];
    [self addSubview:couponIconImageView];
    
    UILabel *couponLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 100, 22)];
    couponLabel.text = @"我的打印券";
    couponLabel.font = [UIFont systemFontOfSize:12];
    couponLabel.textColor = RGBACOLOR(160, 160, 160, 1);
    [self addSubview:couponLabel];
    
    _couponNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDE-125, 10, 100, 22)];
    _couponNumLabel.text = @"无";
    _couponNumLabel.textAlignment = NSTextAlignmentRight;
    _couponNumLabel.font = [UIFont systemFontOfSize:12];
    _couponNumLabel.textColor = RGBACOLOR(160, 160, 160, 1);
    [self addSubview:_couponNumLabel];
    
    UIImageView *couponRetunImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDE-25, 10, 22, 22)];
    couponRetunImageView.image = [UIImage imageNamed:@"qianjin"];
    [self addSubview:couponRetunImageView];
    
}
@end
