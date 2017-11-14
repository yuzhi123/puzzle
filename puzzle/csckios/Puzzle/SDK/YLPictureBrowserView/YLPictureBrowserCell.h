//
//  YLPictureBrowserCell.h
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPictureBrowserCell : UICollectionViewCell

/** 边框 */
@property (nonatomic, strong) UIImageView *pbkImageView;

/** 图片 */
@property (nonatomic, strong) UIImageView *pImageView;

/** 边框位置(在CollectionviewCell中的位置，不需要边框可以不设置) */
@property (nonatomic, assign) CGRect pbkImageRect;

/** 图片位置(在CollectionviewCell中的位置) */
@property (nonatomic, assign) CGRect pImageRect;

@end
