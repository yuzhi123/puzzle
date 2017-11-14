//
//  TemplateOperation.h
//  Puzzle
//
//  Created by yiliu on 16/9/18.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//模板表操作类

#import <Foundation/Foundation.h>
#import "TemplateModel.h"
#import "PhotoModel.h"
#import "WrittenWordModel.h"

@interface TemplateOperation : NSObject

/** 模板表插入数据 */
- (void)insertTemplateTableData:(TemplateModel *)model;

/** 根据模板类型、模板专题、模板图片名称查询是否已下载该模板 */
- (BOOL)selectTemplateType:(NSString *)type special:(NSString *)special imageName:(NSString *)imageName;

///** 根据类型查询模板数据 */
//- (NSMutableArray *)selectTemplateTypeData:(NSString *)type;

/** 根据专题查询模板数据 */
- (NSMutableArray *)selectTemplateTermsData:(NSString *)terms;

///** 根据类型和图片张数查询数据 */
//- (NSMutableArray *)selectTemplateTypeData:(NSString *)type photoNum:(NSInteger)photoNum;

/** 根据专题和图片张数查询数据 */
- (NSMutableArray *)selectTemplateTermData:(NSString *)type photoNum:(NSInteger)photoNum;

/** 根据模板类型、专题类型 搜索是否已解锁 */
- (BOOL)selectIsUnlock:(NSString *)name andType:(NSString *)type;

/** 删除模板 */
- (NSInteger)deleteTemplate:(NSArray *)dataArray;

@end






