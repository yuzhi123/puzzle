//
//  DIYPrintView.m
//  Puzzle
//
//  Created by yiliu on 16/10/10.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "DIYPrintView.h"
#import "SDCycleScrollView.h"

@implementation DIYPrintView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

- (void)loadView {
    
    UIImage *image0 = [UIImage imageNamed:@"headImage0"];
    UIImage *image1 = [UIImage imageNamed:@"headImage1"];
    UIImage *image2 = [UIImage imageNamed:@"headImage2"];
    UIImage *image3 = [UIImage imageNamed:@"headImage3"];
    NSArray *imagesArray = @[image0,image1,image2,image3];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDE, 230*WIDE/320.0) imageNamesGroup:imagesArray];
    [self addSubview:cycleScrollView];
    
    
    
}

@end
