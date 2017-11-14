//
//  LockView.m
//  Puzzle
//
//  Created by yiliu on 16/10/17.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "LockView.h"

@implementation LockView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
    
}

- (void)loadView {
    
    self.backgroundColor = RGBACOLOR(1, 1, 1, 0.5);
    
    UIImageView *suoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-16, self.bounds.size.height/2-38, 32, 32)];
    suoImageView.image = [UIImage imageNamed:@"suo"];
    [self addSubview:suoImageView];
    
    _lockTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2-6, self.bounds.size.width, 20)];
    _lockTitleLabel.font = [UIFont systemFontOfSize:10];
    _lockTitleLabel.textColor = [UIColor whiteColor];
    _lockTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lockTitleLabel];
    
    _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-25, self.bounds.size.height/2+14, 50, 22)];
    [_shareBtn setBackgroundColor:RGBACOLOR(255, 177, 19, 1)];
    [_shareBtn setTitle:@"去拼图" forState:UIControlStateNormal];
    //[_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _shareBtn.layer.cornerRadius = 4;
    _shareBtn.layer.masksToBounds = YES;
    [self addSubview:_shareBtn];
    
}

- (void)setShareNum:(NSInteger)shareNum {

    _shareNum = shareNum;
    _lockTitleLabel.text = [NSString stringWithFormat:@"分享%tu次解锁",shareNum];

}

@end
