//
//  MyTanSuoButton.m
//  meitu
//
//  Created by yiliu on 16/2/29.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "MyTanSuoButton.h"
#import "Masonry.h"

@implementation MyTanSuoButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addView];
    }
    return self;
}

- (void)addView{
    
//    self.layer.cornerRadius = self.bounds.size.height/2;
//    self.layer.masksToBounds = YES;
    
}

@end
