//
//  AButton.m
//  Puzzle
//
//  Created by yiliu on 16/9/12.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "AButton.h"

@implementation AButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView {

    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _title.font = [UIFont systemFontOfSize:15];
    [self addSubview:_title];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDE-70, self.frame.size.height/2-10, 20, 20)];
    [self addSubview:imageView];
    
    imageView.image = [UIImage imageNamed:@"qianjin"];

}

@end
