//
//  WWFileOperation.m
//  FeiHangChuangKe
//
//  Created by 王飞 on 16/9/22.
//  Copyright © 2016年 FeiHangKeJi.com. All rights reserved.
//


/**********对文件进行操作************/

#import "WWFileOperation.h"

@implementation WWFileOperation


// 创建文件件
+(void)creatfolderWithName:(NSString*)name
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,name];
    
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    } else {
        NSLog(@"FileDir is exists.");
    }
    
}

// 删除文件
+(void)deleteFolderWithName:(NSString*)floder andSuffix:(NSString*)suffix;
{
     NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *createPath;
    if (floder == nil) {
        createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,suffix];
    }
    else
    {
        createPath = [NSString stringWithFormat:@"%@/%@/%@", pathDocuments,floder,suffix];
    }

    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:createPath error:nil];

}

// 写文件
+(BOOL)writeFileWithDocunemtName:(NSString*)name andFileSuffix:(NSString* ) suffixName andDataFile:(NSData*)data
{
    
    
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath;
    
    if (name == nil) {
        createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,suffixName];
    }
    else
    {
        createPath = [NSString stringWithFormat:@"%@/%@/%@", pathDocuments,name,suffixName];
    }
    
    bool isBool = [data writeToFile:createPath atomically:YES];
    
    return isBool;
 
    
}
// 读文件
+(NSData*)readDataWithDocumentName:(NSString*)name andFileSuffix:(NSString*) suffixName
{
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath;
    
    if (name == nil) {
        createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,suffixName];
    }
    else
    {
        createPath = [NSString stringWithFormat:@"%@/%@/%@", pathDocuments,name,suffixName];
    }
    
    
   NSData* data = [NSData dataWithContentsOfFile:createPath];
    return data;

}

// 删除文件夹
+(void)deleteCocumentWithName:(NSString*)name
{
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath;
     createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,name];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:createPath error:nil];


}

@end
