//
//  TimeView.h
//  Puzzle
//
//  Created by yiliu on 2016/10/21.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//时间选择器

#import <UIKit/UIKit.h>

@protocol TimeViewDelegate <NSObject>

/** 选择的时间 */
- (void)choiceTime:(NSString *)time;

@end



@interface TimeView : UIView

@property (nonatomic, weak) id <TimeViewDelegate> delegate;

@end
