//
//  StorySetHeadView.h
//  Puzzle
//
//  Created by yiliu on 2016/10/21.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StorySetHeaderDelegate <NSObject>

/** 编辑时间 */
- (void)editTimeHeader;

///** 编辑地点 */
//- (void)editAddressHeader;

@end


@interface StorySetHeadView : UIView

@property (nonatomic, weak) id <StorySetHeaderDelegate> delegate;

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

/** 封面图 */
@property (nonatomic, assign) NSInteger index;

@end
