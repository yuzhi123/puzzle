//
//  downTempeBtn.m
//  Puzzle
//
//  Created by yiliu on 2016/11/2.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "DownTempeBtn.h"


@implementation DownTempeBtn

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
    
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self loadView];
    }
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadView];
    }
    return self;
    
}

- (void)loadView {
    
    _bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    _bkView.backgroundColor = [UIColor redColor];
    [self addSubview:_bkView];
    
}

- (void)setProgress:(float)progress {
    
    _progress = progress;
    _bkView.frame = CGRectMake(0, 0, self.frame.size.width*_progress, self.frame.size.height);
    
}

- (void)setHideProgress:(BOOL)hideProgress {
    
    _hideProgress = hideProgress;
    
    if (_hideProgress) {
        
        _bkView.hidden = YES;
        
    }else {
        
        _bkView.hidden = NO;
        
        
    }
    
}

@end
