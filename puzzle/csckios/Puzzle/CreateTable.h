//
//  CreateTable.h
//  Puzzle
//
//  Created by yiliu on 16/9/18.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateTable : NSObject

/** 如果数据库不存在则创建数据库和表 */
- (void)createDataAndTable;
    
///** 模板表 */
//- (void)createTemplateTable;
//
///** 图片表 */
//- (void)createPhotoTable;
//
///** 文字表 */
//- (void)createWrittenWordsTable;
//
///** 模板图片表 */
//- (void)createTemplatePictureTable;
//
///** 模板类型表 */
//- (void)createTemplateTypeTable;
//
///** 已解锁表的模板类型表 */
//- (void)createTemplateUnlockTable;

@end
