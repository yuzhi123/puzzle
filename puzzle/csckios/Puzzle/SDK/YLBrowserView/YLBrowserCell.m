//
//  YLBrowserCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLBrowserCell.h"

@implementation YLBrowserCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pImageView = [[UIImageView alloc] init];
        _pImageView.contentMode = UIViewContentModeScaleAspectFill;
        _pImageView.clipsToBounds = YES;
        [self.contentView addSubview:_pImageView];
        
        _remarksLabel = [[UILabel alloc] init];
        _remarksLabel.numberOfLines = 0;
        _remarksLabel.backgroundColor = [UIColor whiteColor];
        _remarksLabel.textAlignment = NSTextAlignmentCenter;
        _remarksLabel.font = [UIFont systemFontOfSize:11];
        _remarksLabel.textColor = RGBACOLOR(120, 120, 120, 1);
        [self.contentView addSubview:_remarksLabel];
        
    }
    return self;
}

@end
