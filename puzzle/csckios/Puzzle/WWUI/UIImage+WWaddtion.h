//
//  UIImage+WWaddtion.h
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/8/25.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WWaddtion)

//图片切割 指定指定尺寸与位置切割
-(UIImage*)cutImage:(UIImage*)image frame:(CGRect)fra;

// 图片 剧中切割，选定宽高比，高度比例
-(UIImage*)cutImage:(UIImage*)image withAspectRatio:(CGFloat)kuanGaoBi withAspectHight:(CGFloat)gaoDuBi;

// 图片 剧中切割，选定宽高比，高度比例（当高度大于宽度时，高比，小于时，宽比）
-(UIImage*)cutImage:(UIImage*)image withAutoAspectRatio:(CGFloat)kuanGaoBi withAspectHight:(CGFloat)gaoDuBi;
// 修改图片尺寸
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

#pragma mark -- 图片切割 用于默认图 自动尺寸切割，传入当前需要的宽高比就行
- (UIImage*)cutImagewithScale:(CGFloat)scale;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
