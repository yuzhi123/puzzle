//
//  TemplateTypeData.h
//  Puzzle
//
//  Created by yiliu on 16/10/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//模板类型和专题数据

#import <Foundation/Foundation.h>

@interface TemplateTypeData : NSObject

/**
 *创建信息保存单例
 */
+ (TemplateTypeData *)CreateTemplateTypeData;



///** 类型 */
//@property (nonatomic, strong) NSMutableArray *templateTypes;

/** 专题 */
@property (nonatomic, strong) NSMutableArray *templateTerms;



@end
