//
//  UIImage+WWaddtion.m
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/8/25.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//

#import "UIImage+WWaddtion.h"

@implementation UIImage (WWaddtion)


//图片切割 指定指定尺寸与位置切割
-(UIImage*)cutImage:(UIImage*)image frame:(CGRect)fra
{
    UIImageView* tempImageView = [[UIImageView alloc]initWithImage:image];
    
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [tempImageView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
    
}

// 图片 剧中切割，选定宽高比，高度比例（当高度大于宽度时，高比，小于时，宽比）
-(UIImage*)cutImage:(UIImage*)image withAutoAspectRatio:(CGFloat)kuanGaoBi withAspectHight:(CGFloat)gaoDuBi
{
    
      UIImageView* tempImageView = [[UIImageView alloc]initWithImage:image];
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [tempImageView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect frame = tempImageView.frame;
    
    CGRect lastFrame;
    
    if (image.size.width>image.size.height) {
        
         lastFrame = CGRectMake((frame.size.width-kuanGaoBi*gaoDuBi*frame.size.height)/2, (frame.size.width - gaoDuBi*frame.size.height)/2, kuanGaoBi*gaoDuBi*frame.size.height, gaoDuBi*frame.size.height);
        
        
    }
    else
    {
       lastFrame = CGRectMake((frame.size.width-gaoDuBi*frame.size.height)/2, (frame.size.width - gaoDuBi*frame.size.height*kuanGaoBi)/2, gaoDuBi*frame.size.height, gaoDuBi*frame.size.height*kuanGaoBi);
      

    }
    
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, lastFrame);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;

}

// 图片 剧中切割，选定宽高比，高度比例（当高度大于宽度时，高比，小于时，宽比）
-(UIImage*)cutImage:(UIImage*)image withAspectRatio:(CGFloat)kuanGaoBi withAspectHight:(CGFloat)gaoDuBi
{
    UIImageView* tempImageView = [[UIImageView alloc]initWithImage:image];
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [tempImageView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect frame = tempImageView.frame;
    
    CGRect lastFrame;
    
    lastFrame = CGRectMake((frame.size.width-kuanGaoBi*gaoDuBi*frame.size.height)/2, (frame.size.width - gaoDuBi*frame.size.height)/2, kuanGaoBi*gaoDuBi*frame.size.height, gaoDuBi*frame.size.height);
  
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, lastFrame);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}


#pragma mark -- 图片切割
-(UIImage*)cutImagewithScale:(CGFloat)scale
{
    
    UIImageView* tempImageView = [[UIImageView alloc]initWithImage:self];
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [tempImageView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect lastFrame;
    
    if ( self.size.width/scale > self.size.height) {
        
        lastFrame = CGRectMake( (self.size.width-self.size.height*scale)/2, 0, self.size.height*scale, self.size.height);
        
    }
    else
    {
        lastFrame = CGRectMake(0, (self.size.height-self.size.width/scale)/2, self.size.width, self.size.width/scale);
    }
    
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, lastFrame);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
    
}


- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    return newImage ;
}

/**
 *  返回指定颜色生成的图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
