//
//  MaterialDetailsController.h
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//素材详情

#import <UIKit/UIKit.h>


@protocol MaterialDetailsDelegate <NSObject>

/** 下载完成 */
- (void)downSuccess:(NSDictionary *)dict;

@end


@interface MaterialDetailsController : UIViewController

@property (nonatomic, weak) id <MaterialDetailsDelegate> delegate;

/** 是否解除了锁定 */
@property (nonatomic, assign) BOOL isUnlock;

/** 所有图片数据 */
@property (nonatomic, strong) NSArray *dataArray;

/** 当前显示的图片 */
@property (nonatomic, assign) NSInteger proportionIndex;

/** 选中的分组 */
@property (nonatomic, assign) NSInteger section;

@end
