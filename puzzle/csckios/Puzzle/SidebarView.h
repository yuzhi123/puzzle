//
//  SidebarView.h
//  Puzzle
//
//  Created by yiliu on 16/8/31.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SidebarDelegate <NSObject>

//切换图片
- (void)switchImage;

//切换方向
- (void)switchImageDirection;

//翻面
- (void)flipImage;

@end


@interface SidebarView : UIView

@property (nonatomic, weak) id <SidebarDelegate> delegate;

@end
