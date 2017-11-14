//
//  YLPictureBrowserCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLPictureBrowserCell.h"

@implementation YLPictureBrowserCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pbkImageView = [[UIImageView alloc] init];
        _pbkImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_pbkImageView];
        
        _pImageView = [[UIImageView alloc] init];
        _pImageView.contentMode = UIViewContentModeScaleAspectFill;
        _pImageView.clipsToBounds = YES;
        [self.contentView addSubview:_pImageView];
        
    }
    return self;
}

- (void)setPbkImageRect:(CGRect)pbkImageRect {

    _pbkImageRect = pbkImageRect;
    
    _pbkImageView.frame = _pbkImageRect;
    
}

- (void)setPImageRect:(CGRect)pImageRect {

    _pImageRect = pImageRect;
    
    _pImageView.frame = _pImageRect;
    
}

@end
