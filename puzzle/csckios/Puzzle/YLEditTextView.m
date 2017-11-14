//
//  YLEditTextView.m
//  Puzzle
//
//  Created by yiliu on 16/9/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLEditTextView.h"
#import "MBProgressHUD.h"

@interface YLEditTextView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *biliLabel;

@property (nonatomic, strong) UIView  *bkView;

@property (nonatomic, strong) UIButton *determineBtn;

@end

@implementation YLEditTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView {
    
    self.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.biliLabel];
    [self addSubview:self.bkView];
    [self.bkView addSubview:self.contentField];
    [self addSubview:self.typefaceBtn];
    [self addSubview:self.determineBtn];
    
    self.contentField.text = @"KUMAN";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:self.contentField];
    
}

//选择字体
- (void)typeFace:(UIButton *)btn {
    
    if (btn.selected) {
        
        btn.selected = NO;
        
        if([self.delegate respondsToSelector:@selector(ylEditTextViewSwitchTypeface:)]){
            [self.delegate ylEditTextViewSwitchTypeface:NO];
        }
        
    }else {
        
        btn.selected = YES;
        
        if([self.delegate respondsToSelector:@selector(ylEditTextViewSwitchTypeface:)]){
            [self.delegate ylEditTextViewSwitchTypeface:YES];
        }
        
    }
    
}

//确定
- (void)determine:(UIButton *)btn {
    
    NSInteger num = [self convertToInt:self.contentField.text];
    
    if (num > _numMax) {
        
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.superview];
        [self.superview addSubview:HUD];
        HUD.label.text = @"内容超出限制范围";
        HUD.mode = MBProgressHUDModeText;
        [HUD hideAnimated:YES afterDelay:1.2];
        
    }else {
    
        if([self.delegate respondsToSelector:@selector(ylEditTextViewCompleteEdit)]){
            [self.delegate ylEditTextViewCompleteEdit];
        }
    
    }
    
}

- (void)setNumMax:(NSInteger)numMax {

    _numMax = numMax;
    
    _biliLabel.text = [NSString stringWithFormat:@"%tu / %tu",5,_numMax];
    
}

- (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
    
}

- (void)textFiledEditChanged:(NSNotification *)obj {
    
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            NSInteger num = [self convertToInt:toBeString];
            
            NSString *text = [NSString stringWithFormat:@"%tu / %tu",num,_numMax];
            
            if (num > _numMax) {
                
                NSString *others = [NSString stringWithFormat:@"%tu",num];
                
                NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:text];
                
                [aStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont systemFontOfSize:15],
                                     NSFontAttributeName,
                                     [UIColor redColor],
                                     NSForegroundColorAttributeName,
                                     nil]
                              range:[text rangeOfString:others]];
                
                self.biliLabel.attributedText = aStr;
                
            }else {
                
                self.biliLabel.textColor = [UIColor whiteColor];
                self.biliLabel.text = text;
                
            }
            
        }
        
    }else {
    
        NSInteger num = [self convertToInt:toBeString];
        
        NSString *text = [NSString stringWithFormat:@"%tu / %tu",num,_numMax];
        
        if (num > _numMax) {
            
            NSString *others = [NSString stringWithFormat:@"%tu",num];
            
            NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:text];
            
            [aStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont systemFontOfSize:15],
                                 NSFontAttributeName,
                                 [UIColor redColor],
                                 NSForegroundColorAttributeName,
                                 nil]
                          range:[text rangeOfString:others]];
            
            self.biliLabel.attributedText = aStr;
            
        }else {
            
            self.biliLabel.textColor = [UIColor whiteColor];
            self.biliLabel.text = text;
            
        }
        
    }
    
}

- (void)edealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:self.contentField];
}

- (UILabel *)biliLabel {
    if (!_biliLabel) {
        _biliLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, self.bounds.size.height)];
        _biliLabel.textAlignment = NSTextAlignmentCenter;
        _biliLabel.textColor = [UIColor whiteColor];
        _biliLabel.font = [UIFont systemFontOfSize:17];
    }
    return _biliLabel;
}

- (UIView *)bkView {
    if (!_bkView) {
        _bkView = [[UIView alloc] initWithFrame:CGRectMake(60, 8, self.bounds.size.width-135, self.bounds.size.height-16)];
        _bkView.backgroundColor = RGBACOLOR(66, 67, 68, 1);
    }
    return _bkView;
}

- (UITextField *)contentField {
    if (!_contentField) {
        _contentField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, _bkView.frame.size.width-10, _bkView.frame.size.height)];
        _contentField.text = @"KUMAN";
        _contentField.borderStyle = UITextBorderStyleNone;
        //设置一键清除按钮是否出现
        _contentField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _contentField.font = [UIFont systemFontOfSize:15];
        _contentField.textColor = [UIColor whiteColor];
        _contentField.delegate = self;
    }
    return _contentField;
}

- (UIButton *)typefaceBtn {
    if (!_typefaceBtn) {
        _typefaceBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-70, (self.bounds.size.height-35)/2, 35, 35)];
        [_typefaceBtn setBackgroundImage:[UIImage imageNamed:@"ziti"] forState:UIControlStateNormal];
        [_typefaceBtn setBackgroundImage:[UIImage imageNamed:@"jianpan"] forState:UIControlStateSelected];
        [_typefaceBtn addTarget:self action:@selector(typeFace:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typefaceBtn;
}

- (UIButton *)determineBtn {
    if (!_determineBtn) {
        _determineBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-35, (self.bounds.size.height-30)/2, 30, 30)];
        [_determineBtn setBackgroundImage:[UIImage imageNamed:@"xiaogou"] forState:UIControlStateNormal];
        [_determineBtn addTarget:self action:@selector(determine:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineBtn;
}

@end
