//
//  StorySetView.h
//  Puzzle
//
//  Created by yiliu on 2016/10/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StorySetDelegate <NSObject>

/** 编辑时间 */
- (void)editTime;

/** 编辑地点 */
- (void)editAddress;

@end


@interface StorySetView : UIView

@property (nonatomic, weak) id <StorySetDelegate> delegate;

/** 图片地址 */
@property (nonatomic, strong) NSArray *imageArry;

/** 时间 */
@property (nonatomic, strong) NSString *time;

/** 地点 */
@property (nonatomic, strong) NSString *address;

/** 标题 */
@property (nonatomic, strong) NSString *title;

/** 简介 */
@property (nonatomic, strong) NSString *content;

@end
