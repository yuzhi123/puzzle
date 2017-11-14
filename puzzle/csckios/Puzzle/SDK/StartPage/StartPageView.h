//
//  GuideView.h
//  meitu
//
//  Created by yiliu on 15/9/23.
//  Copyright (c) 2015年 meitu. All rights reserved.
//

//引导页面

#import <UIKit/UIKit.h>

@protocol StartPageViewDelegate <NSObject>

- (void)StartPageViewEnd;

@end

@interface StartPageView : UIView

@property (nonatomic, weak) id <StartPageViewDelegate> delegate;

/** 图片名 */
@property (nonatomic, strong) NSArray *imageNameArray;

/** 图片 */
@property (nonatomic, strong) NSArray *imageArray;

@end
