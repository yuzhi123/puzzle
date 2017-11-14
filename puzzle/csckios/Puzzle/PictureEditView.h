//
//  PictureEditView.h
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//图片view

#import <UIKit/UIKit.h>

@interface PictureEditView : UIView

@property (nonatomic, strong) UIImageView *editImageView;

/** 原图 */
@property (nonatomic, strong) UIImage *originalImage;

- (void)reloadViewFrame:(CGRect)frame;

- (void)reloadView;

//- (void)hideView:(BOOL)hide;

@end
