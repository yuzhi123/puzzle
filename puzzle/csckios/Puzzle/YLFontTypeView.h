//
//  YLFontTypeView.h
//  Puzzle
//
//  Created by yiliu on 16/9/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLFontTypeViewDelegate <NSObject>

/** 选择字体 */
- (void)ylFontTypeViewSwitchTypeface:(NSString *)typeface;

@end


@interface YLFontTypeView : UIView

@property (nonatomic, weak) id <YLFontTypeViewDelegate> delegate;

@end
