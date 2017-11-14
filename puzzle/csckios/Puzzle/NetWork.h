//
//  NetWork.h
//  FeiHangChuangKe
//
//  Created by 王飞 on 17/9/11.
//  Copyright © 2017年 FeiHangKeJi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject



-(void)loadPost:(NSString*) url andParameter:(NSDictionary*)upDic withToken:(BOOL)isToken block:(void(^)(NSDictionary*dataDic))block;

-(void)loadGet:(NSString*) url andparameter:(NSDictionary*)upDic withToken:(BOOL)isToken block:(void(^)(NSDictionary* dataDic))block;
// 上传多张图片
-(void)loadpost:(NSString*) url andParameter:(NSDictionary*) upDic  andImageeArray:(NSArray*)array andImageNameArray:(NSMutableArray*)imageNameArray withToken:(BOOL)isToken block:(void(^)(NSDictionary* dataDic))block;

// 上传用户头像
-(void)loadPostheadImage:(NSString*) url andParameter:(NSDictionary*)upDic withToken:(BOOL)isToken block:(void(^)(NSDictionary*dataDic))block;



@end
