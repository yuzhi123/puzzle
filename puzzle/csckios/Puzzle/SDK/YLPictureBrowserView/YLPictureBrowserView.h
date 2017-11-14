//
//  YLPictureBrowserView.h
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//图片浏览器

#import <UIKit/UIKit.h>

@protocol YLPictureBrowserDelegate <NSObject>

//点击了view
- (void)tapYLPictureBrowserView;

@end


@interface YLPictureBrowserView : UIView

@property (nonatomic, weak) id <YLPictureBrowserDelegate> delegate;

/** 图片URL数组 */
@property (strong, nonatomic) NSArray *imageurlsArray;

/** 图片数组 */
@property (strong, nonatomic) NSArray *imagesArray;

/** 图片边框数组 */
@property (strong, nonatomic) NSArray *imagesBkArray;

/** 图片边框的位置（不需要可以不设置） */
@property (assign, nonatomic) CGRect imageBkRect;

/** 图片的位置 */
@property (assign, nonatomic) CGRect imageRect;

/** 图片张数的位置 */
@property (assign, nonatomic) CGRect imageProportionRect;

/** 背景颜色 */
@property (strong, nonatomic) UIColor *bkColor;


@end
