//
//  TemplateTypeModel.h
//  Puzzle
//
//  Created by yiliu on 16/10/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//


#import <Foundation/Foundation.h>

//模板类型
@interface TemplateTypeModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger typeId;

/** 名称 */
@property (nonatomic, strong) NSString *typeName;

/** 实例图 */
@property (nonatomic, strong) NSString *typeImageUrl;

/** 数量 */
@property (nonatomic, assign) NSInteger typeNumber;

/** 是否解除锁定 */
@property (nonatomic, assign) BOOL isUnlock;

/** 分享N次解锁 */
@property (nonatomic, assign) NSInteger shareNumUnlock;


@end




