//
//  textFiedView.m
//  Puzzle
//
//  Created by 王武 on 2017/9/13.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "textFiedView.h"

@interface textFiedView ()<UITextFieldDelegate>

@end
static textFiedView* selfView;
@implementation textFiedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(UIView*)creatTextField:(CGRect)frame
          andBorderStyle:(UITextBorderStyle)borderStyle
             andDelegate:(id)target
              andKeyBord:(UIKeyboardType)keybord
           andNormalFont:(NSInteger)normalFont
         andNorfontColor:(UIColor*)normalClor
           andPlaceColor:(UIColor*)placeHoderColor
            andPlaceFont:(NSInteger)placeHoderFont
           andplaceHoder:(NSString*)title
        andMaxNumberWord:(NSInteger)wordNumber{
    
            selfView = [[textFiedView  alloc]init];
            selfView.subTextField = [[UITextField alloc]init];
            /***用tag值来记录最大字数***/
             selfView.subTextField.tag = 20000+wordNumber;
             selfView.subTextField.borderStyle = borderStyle;
             selfView.subTextField.delegate = selfView;
             selfView.subTextField.textColor = normalClor;
             selfView.subTextField.placeholder = title;
             selfView.subTextField.font = [UIFont systemFontOfSize:normalFont];
            [ selfView.subTextField setValue:placeHoderColor forKeyPath:@"_placeholderLabel.textColor"];
            [ selfView.subTextField setValue:[UIFont systemFontOfSize:placeHoderFont] forKeyPath:@"_placeholderLabel.font"];
             selfView.subTextField.clearButtonMode = UITextFieldViewModeAlways;
             selfView.subTextField.keyboardType = keybord;
            NSArray* array = @[ selfView.subTextField,[NSString stringWithFormat:@"%ld",wordNumber]];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)name:@"UITextFieldTextDidChangeNotification"
                                                      object:array];
    [ selfView addSubview:selfView.subTextField];
    [selfView.subTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(selfView);
        make.width.mas_equalTo(selfView);
        make.top.mas_equalTo(selfView.mas_top);
        make.left.mas_equalTo(selfView.mas_left);
    }];
    
            return selfView;
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




@end
