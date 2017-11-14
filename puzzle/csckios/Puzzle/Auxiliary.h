//
//  Auxiliary.h
//  Puzzle
//
//  Created by yiliu on 16/9/12.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface Auxiliary : NSObject

/** 自适应高度宽度*/
+ (CGSize)calculationHeightWidth:(NSString *)str andSize:(float)fot andCGSize:(CGSize)size;

/** 电话号码验证*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/** 计算NSData的MD5值 */
+ (NSString *)getMD5WithData:(NSData *)data;

/** 十六进制颜色转成UIColor */
+ (UIColor *)getColor:(NSString *)hexColor;

///** 时间转换 */
//+ (NSString *)timeTransformation:(NSString *)time;


@end
