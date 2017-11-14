//
//  LockView.h
//  Puzzle
//
//  Created by yiliu on 16/10/17.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//锁

#import <UIKit/UIKit.h>

@interface LockView : UIView

/** 分享按钮 */
@property (nonatomic, strong) UIButton *shareBtn;

/** 分享次数提示 */
@property (nonatomic, strong) UILabel *lockTitleLabel;

/** 分享次数 */
@property (nonatomic, assign) NSInteger shareNum;


@end
