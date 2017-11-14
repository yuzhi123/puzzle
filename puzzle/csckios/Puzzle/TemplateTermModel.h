//
//  TemplateTermModel.h
//  Puzzle
//
//  Created by yiliu on 16/10/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemplateTermModel : NSObject


/** id */
@property (nonatomic, assign) NSInteger termId;

/** 名称 */
@property (nonatomic, strong) NSString *termName;

/** 实例图 */
@property (nonatomic, strong) NSString *termImageUrl;

/** 数量 */
@property (nonatomic, assign) NSInteger termNumber;

/** 是否解除了锁定 */
@property (nonatomic, assign) BOOL isUnlock;

/** 分享N次解锁 */
@property (nonatomic, assign) NSInteger shareNumUnlock;


@end
