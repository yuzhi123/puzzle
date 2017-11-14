//
//  PriceView.m
//  Puzzle
//
//  Created by yiliu on 16/10/10.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "PriceView.h"

@implementation PriceView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadView];
        
    }
    return self;
}

- (void)loadView {
    
    UIImageView *bkImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bkImageView.image = [UIImage imageNamed:@"dayinbaoyou"];
    [self addSubview:bkImageView];
    
//    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-45, 40, 40)];
//    _priceLabel.layer.cornerRadius = 20;
//    _priceLabel.layer.masksToBounds = YES;
//    _priceLabel.textAlignment = NSTextAlignmentCenter;
//    _priceLabel.textColor = [UIColor whiteColor];
//    _priceLabel.font = [UIFont systemFontOfSize:13];
//    _priceLabel.backgroundColor = [UIColor orangeColor];
//    _priceLabel.alpha = 0.9;
//    _priceLabel.numberOfLines = 2;
//    [self addSubview:_priceLabel];
    
}


@end
