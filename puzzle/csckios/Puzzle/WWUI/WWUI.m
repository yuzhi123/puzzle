//
//  WWUI.m
//  Demo
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 WangWu. All rights reserved.
//

#import "WWUI.h"
#import "UIView+Addition.h"
#import "UIImage+WWaddtion.h"

@interface WWUI ()<UITextFieldDelegate>

@end

@implementation WWUI
+(UILabel*)creatLabel:(CGRect)cg backGroundColor:(UIColor*)bgColor textAligment:(NSInteger)alignment font:(UIFont*)font textColor:(UIColor*)textColor text:(NSString*)text
{
    UILabel* label = [[UILabel alloc]initWithFrame:cg];
    
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    label.userInteractionEnabled = YES;
    label.textAlignment = alignment;
    label.font = font;
    label.textColor = textColor;
    label.text = text;
    
    return label;
}

+(UIImageView *)creatImageView:(CGRect)cg backGroundImageV:(NSString *)imageName
{
    UIImageView* imageV = [[UIImageView alloc]initWithFrame:cg];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.userInteractionEnabled = YES;
    return imageV;
}

// 原图展示
+(UIButton*)creatButton:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font originalImage:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title
{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    
    UIImageView* imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [bt addSubview:imv];
  
    imv.center =CGPointMake(bt.width/2, bt.height/2);
    
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}


// 不带高亮
+(UIButton*)creatButton:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title
{
   
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    [bt setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateHighlighted];
    
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}
// 带高亮
+(UIButton*)creatButtonWithHight:(CGRect)cg  targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title
{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}

// 定制高亮颜色
+(UIButton*)creatButtonWithMyHight:(CGRect)cg hightLightColor:(UIColor*)hightColor targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font nomalColor:(UIColor*)nomalColor title:(NSString*)title
{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitle:title forState:UIControlStateHighlighted];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [bt setBackgroundImage:[UIImage imageWithColor:nomalColor andSize:cg.size] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageWithColor:hightColor andSize:cg.size] forState:UIControlStateHighlighted];
    bt.titleLabel.font = font;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
  
    return bt;
}


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
                        andMaxNumberWord:(NSInteger)wordNumber{
    
    UITextField* textField = [[UITextField alloc]init];
    /***用tag值来记录最大字数***/
    textField.tag = 20000+wordNumber;
    textField.borderStyle = borderStyle;
    textField.delegate = target;
    textField.textColor = normalClor;
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:normalFont];
    [textField setValue:placeHoderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:placeHoderFont] forKeyPath:@"_placeholderLabel.font"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.keyboardType = keybord;
    NSArray* array = @[textField,[NSString stringWithFormat:@"%ld",wordNumber]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)name:@"UITextFieldTextDidChangeNotification"
        object:array];
    return textField;
}


-(void)textFiledEditChanged:(NSNotification *)obj{
    NSArray* array = (NSArray *)obj.object;
    UITextField* textField = array.firstObject;
    NSInteger wordNumber = [array.lastObject integerValue];
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > wordNumber+2) {
                textField.text = [toBeString substringToIndex:wordNumber+2];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
            if (textField.text.length>wordNumber)
            {
                textField.text = [textField.text substringToIndex:wordNumber];
            }
        }
        NSLog(@"%@",textField.text);
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > wordNumber)
        {
            textField.text = [toBeString substringToIndex:wordNumber];
            
        }
        NSLog(@"%@",textField.text);
        
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSMutableString * newText = [NSMutableString stringWithString:textField.text];
    [newText replaceCharactersInRange:range withString:string];
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    NSInteger* maxWorderNumber = textField.tag - 20000;
    if (newText.length <= textField.text.length || newText.length <= maxWorderNumber) {
        
        NSLog(@"toBeStrint1==========%@",newText);
        
        return YES;
    } else {
        
        newText = [newText substringToIndex:maxWorderNumber];
        NSLog(@"toBeStrint2==========%@",newText);
        
        return NO;
    }
    
}

//slider
+(UISlider*)creatSlider:(CGRect)frame andMaxNumber:(float)maxNumber  andMinNUmber:(float)minNunmber andDefuultValue:(float)defaultValue andMinColor:(UIColor*)minColor andMaxColor:(UIColor*)maxColor andThumbColor:(UIColor*) thumbColor andTagdet:(id)target sel:(SEL)sel
{
    UISlider* slider = [[UISlider alloc]initWithFrame:frame];
    [slider addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    slider.minimumValue = minNunmber;
    slider.maximumValue = maxNumber;
    slider.value = defaultValue;
    slider.minimumTrackTintColor = minColor;
    slider.maximumTrackTintColor = maxColor;
    slider.thumbTintColor = thumbColor;
    return slider;
}

// label masory
+(UILabel*)creatMasoryLable:(CGFloat)dispatchOfBoundryAndWord
             withTitleColor:(UIColor*)textColor
                    AndFont:(UIFont*)font
                    andText:(NSString*)text{
    
    UILabel* label = [[UILabel alloc]init];
    label.textColor = [UIColor clearColor];
    UILabel* innerLabel = [[UILabel alloc]init];
    [label addSubview:innerLabel];
    innerLabel.textColor = textColor;
    innerLabel.font = font;
    innerLabel.textAlignment = NSTextAlignmentCenter;
    innerLabel.backgroundColor = [UIColor cyanColor];
    innerLabel.text = text;
    [label layoutIfNeeded];
    [innerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(label.mas_left).offset(dispatchOfBoundryAndWord);
        make.right.mas_equalTo(label.mas_right).offset(-dispatchOfBoundryAndWord);
        make.height.mas_equalTo(label);
        make.center.mas_equalTo(label);
    }];
    
    [label addObserver:label forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    return label;
    
}


@end

