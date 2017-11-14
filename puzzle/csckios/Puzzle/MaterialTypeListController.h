//
//  MaterialTypeListController.h
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//素材类型

#import <UIKit/UIKit.h>


@protocol MaterialTypeListDelegate <NSObject>

/** 进入选择照片页面-拼图 */
- (void)openPuzzleView;

@end


@interface MaterialTypeListController : UIViewController

@property (nonatomic, weak) id <MaterialTypeListDelegate> delegate;

@end
