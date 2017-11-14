//
//  ShareButton.m
//  Puzzle
//
//  Created by yiliu on 16/9/7.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "ShareButton.h"

@implementation ShareButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self loadView];
        
    }
    return self;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView {
    
    _bkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-25, 0, 50, 50)];
    [self addSubview:_bkImageView];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.textColor = [UIColor whiteColor];
    [self addSubview:_contentLabel];
    
}

@end
