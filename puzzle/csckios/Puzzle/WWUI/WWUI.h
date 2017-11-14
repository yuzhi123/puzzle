//
//  WWUI.h
//  Demo
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 WangWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WWUI : NSObject

+(UILabel*)creatLabel:(CGRect)cg backGroundColor:(UIColor*)bgColor textAligment:(NSInteger)alignment font:(UIFont*)font textColor:(UIColor*)textColor text:(NSString*)text;
+(UIImageView*)creatImageView:(CGRect)cg backGroundImageV:(NSString*)imageName;

+(UIButton*)creatButton:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title;

+(UIButton*)creatButtonWithHight:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title;
// 原图展示
+(UIButton*)creatButton:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font originalImage:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title;
// 自定义高亮
+(UIButton*)creatButtonWithMyHight:(CGRect)cg hightLightColor:(UIColor*)hightColor targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font nomalColor:(UIColor*)nomalColor title:(NSString*)title;

//slider
+(UISlider*)creatSlider:(CGRect)frame andMaxNumber:(float)maxNumber  andMinNUmber:(float)minNunmber andDefuultValue:(float)defaultValue andMinColor:(UIColor*)minColor andMaxColor:(UIColor*)maxColor andThumbColor:(UIColor*) thumbColor andTagdet:(id)target sel:(SEL)sel;


//外部不能给tag值
// uitextField
-(UITextField*)creatTextField:(CGRect)frame
               andBorderStyle:(UITextBorderStyle)borderStyle
                  andDelegate:(id)target
                   andKeyBord:(UIKeyboardType)keybord
                andNormalFont:(NSInteger)normalFont
              andNorfontColor:(UIColor*)normalClor
                andPlaceColor:(UIColor*)placeHoderColor
                 andPlaceFont:(NSInteger)placeHoderFont
                andplaceHoder:(NSString*)title
             andMaxNumberWord:(NSInteger)wordNumber;

//masory专用label



+(UILabel*)creatMasoryLable:(CGFloat)dispatchOfBoundryAndWord  //文字与label的边界距离
             withTitleColor:(UIColor*)textColor
                    AndFont:(UIFont*)font
                    andText:(NSString*)text;



@end
