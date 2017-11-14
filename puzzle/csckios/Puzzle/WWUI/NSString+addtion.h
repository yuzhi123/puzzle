//
//  NSString+addtion.h
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/8/21.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (addtion)

//返还单行文字宽度
-(CGSize)stringLengthwithFont:(CGFloat)font;
// 返还多行文字高度
-(CGSize)stringHightwithfont:(NSInteger)font withWidth:(CGFloat)width;
// 返还字符串的长度 （中文两个字符，中文一个字符）
-(NSUInteger) unicodeLengthOfString: (NSString *) text;

//phone text (中间字符代替) 参数一，起始位置，参数二，参数3，需要代替的字符串
-(NSString*) phoneString:(NSInteger)BeginIndex andlength:(NSInteger)length andReplaceChar:(NSString*)str;

// label  用于设置label的行高，注意需要设置label的各种属性，大小，来限定大小 1.行间距 2.行数 3 label
-(UILabel*)labelLineSpace:(NSInteger) lineSpace withlines:(NSInteger)lines withLabel:(UILabel*)label;

-(BOOL) isMobileNumbel;
@end
