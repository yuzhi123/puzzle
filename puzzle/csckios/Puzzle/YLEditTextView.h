//
//  YLEditTextView.h
//  Puzzle
//
//  Created by yiliu on 16/9/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//编辑文字

#import <UIKit/UIKit.h>

@protocol YLEditTextViewDelegate <NSObject>

/** 切换字体 */
- (void)ylEditTextViewSwitchTypeface:(BOOL)isTypeface;

/** 完成编辑 */
- (void)ylEditTextViewCompleteEdit;

@end




@interface YLEditTextView : UIView

@property (nonatomic, weak) id <YLEditTextViewDelegate> delegate;

/** 文本框 */
@property (nonatomic, strong) UITextField *contentField;

/** 最大字数 */
@property (nonatomic, assign) NSInteger numMax;

@property (nonatomic, strong) UIButton *typefaceBtn;


- (void)edealloc;

@end
