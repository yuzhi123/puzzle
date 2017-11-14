//
//  MaterialListViewController.h
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//素材列表

#import <UIKit/UIKit.h>

@interface MaterialListController : UIViewController

/** 是否解除了锁定 */
@property (nonatomic, assign) BOOL isUnlock;

/** 查询类型(分类/专题) */
@property (nonatomic, strong) NSString *selectType;

/** 查询id(分类id/专题id) */
@property (nonatomic, assign) NSInteger selectId;

@end
