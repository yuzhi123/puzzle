//
//  WWFileOperation.h
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/9/22.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWFileOperation : NSObject

// 创建文件夹
+(void)creatfolderWithName:(NSString*)name;

+(void)deleteCocumentWithName:(NSString*)name;

// 删除文件夹 不用带／，如果不含文件夹，那么传nil
+(void)deleteFolderWithName:(NSString*)floder andSuffix:(NSString*)suffix;

// 写文件
+(BOOL)writeFileWithDocunemtName:(NSString*)name andFileSuffix:(NSString* ) suffixName andDataFile:(NSData*)data;

// 读文件
+(NSData*)readDataWithDocumentName:(NSString*)name andFileSuffix:(NSString*) suffixName ;


@end
