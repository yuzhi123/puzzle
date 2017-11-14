//
//  YLDottedLineLabel.m
//  Puzzle
//
//  Created by yiliu on 16/9/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLDottedLineLabel.h"


@interface YLDottedLineLabel (){

    CAShapeLayer *border;
    
}


@property (nonatomic, strong) UIView *bkViv;


@end

@implementation YLDottedLineLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
        
        _bkViv = [[UIView alloc] initWithFrame:self.bounds];
        _bkViv.alpha = 0;
        _bkViv.backgroundColor = [UIColor clearColor];
        [self addSubview:_bkViv];
        
    }
    return self;
}

- (void)loadDottedLine {

    border = [CAShapeLayer layer];
    
    border.strokeColor = [UIColor redColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    border.frame = self.bounds;
    
    border.lineWidth = 1.f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @2];
    
    [_bkViv.layer addSublayer:border];
    
}


- (void)reloadViewFrame:(CGRect)frame {
    
    self.frame = frame;
    
    [self loadDottedLine];

}

//隐藏边框
- (void)hideLayer {
    
    _bkViv.alpha = 0;
    
}

//显示边框
- (void)displayLayer {
    
    _bkViv.alpha = 1;
    
}

//显示再隐藏边框
- (void)displayHideLayer {
    
    [UIView animateWithDuration:1 animations:^{
        
        _bkViv.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2 animations:^{
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                _bkViv.alpha = 0;
            }];
            
        }];
        
    }];
    
}

@end
