//
//  TemplateTypeData.m
//  Puzzle
//
//  Created by yiliu on 16/10/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TemplateTypeData.h"

@implementation TemplateTypeData

+ (TemplateTypeData *)CreateTemplateTypeData
{
    static TemplateTypeData *templateTypeData = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        templateTypeData = [[self alloc] init];
    });
    return templateTypeData;
}


///** 类型 */
//- (NSMutableArray *)templateTypes {
//    if (!_templateTypes) {
//        _templateTypes = [[NSMutableArray alloc] initWithCapacity:0];
//    }
//    return _templateTypes;
//}

/** 专题 */
- (NSMutableArray *)templateTerms {
    if (!_templateTerms) {
        _templateTerms = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _templateTerms;
}

@end
