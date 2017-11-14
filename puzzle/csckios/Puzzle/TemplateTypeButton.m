//
//  TemplateTypeButton.m
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TemplateTypeButton.h"

@implementation TemplateTypeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _xhLabe = [[UILabel alloc] initWithFrame:CGRectMake(7, frame.size.height-2, frame.size.width-14, 2)];
        _xhLabe.backgroundColor = [UIColor redColor];
        _xhLabe.hidden = YES;
        [self addSubview:_xhLabe];
        
    }
    return self;
}

@end
