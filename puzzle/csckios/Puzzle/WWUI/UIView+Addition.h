//
//  UIView+Addition.h
//  wangwu
//
//  Created by wantexe on 16/8/7.
//  Copyright © 2016年 limingfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

-(NSString*)getStringFromUserDefaultForKey:(NSString*)key;

-(NSArray*)getArrayFromUserDefaultForKey:(NSString*)key;

-(NSDictionary*)getDicFromUserDefaultForKey:(NSString*)key;

// 清除所以子视图
-(void)removeAllSubView;
@end
