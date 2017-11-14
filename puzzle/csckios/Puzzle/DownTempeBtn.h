//
//  downTempeBtn.h
//  Puzzle
//
//  Created by yiliu on 2016/11/2.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//下载按钮

#import <UIKit/UIKit.h>

@interface DownTempeBtn : UIButton

/** 进度 */
@property (nonatomic, assign) float progress;

/** 隐藏下载进度条 */
@property (nonatomic, assign) BOOL hideProgress;


@property (nonatomic, strong) UIView *bkView;

@end

