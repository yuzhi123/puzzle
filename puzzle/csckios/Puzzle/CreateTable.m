//
//  CreateTable.m
//  Puzzle
//
//  Created by yiliu on 16/9/18.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "CreateTable.h"
#import "FMDB.h"

@implementation CreateTable

- (FMDatabase *)obtainDatabase {
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    return db;
}

//创建数据库和表
- (void)createDataAndTable {
    
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //如果不存在
    if(![fileManager fileExistsAtPath:fileName]) {
        
        //模板表
        [self createTemplateTable];
        
        //照片表
        [self createPhotoTable];
        
        //文字表
        [self createWrittenWordsTable];
        
        //已解锁的模板和专题
        [self createTemplateUnlockTable];
        
    } else {
        NSLog(@"数据库已存在");
    }
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:TEMPLATEPATH]) {
        [fileManager createDirectoryAtPath:TEMPLATEPATH withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"保存模板的文件夹已存在");
    }
    
}

//模板表：templateTable
//主键：id
//类型：templateType(varchar类型)
//专题：templateSpecial（varchar类型）
//模板图片名：templateImageName（varchar）
//照片数量：photoNum(int类型)
//放置的照片（关联图片表）：photos（1,2,3）
//放置的文字（关联文字表,可以为空）：writtenWords（1,2）
//模板示例图：sampleGraphUrl
- (void)createTemplateTable {
    
    //获得数据库
    FMDatabase *db = [self obtainDatabase];
    
    //使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //4.创表
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS templateTable (id integer PRIMARY KEY AUTOINCREMENT, templateType varchar NOT NULL, templateSpecial varchar NOT NULL, templateImageName varchar NOT NULL, photoNum integer NOT NULL, photos varchar NOT NULL, writtenWords varchar, sampleGraphUrl varchar NOT NULL)"];
        BOOL result = [db executeUpdate:sqlCreateTable];
        if (result)
        {
            NSLog(@"创建模板表成功");
        }
        
        [db close];
    }
    
}

//图片表：photoTable
//主键：id
//x坐标：xCoordinatex（float类型）
//y坐标：yCoordinatey（float类型）
//宽：wide（float类型）
//高：high（float类型）
//旋转角度（0-360）：rotationAngle（float类型）
- (void)createPhotoTable {
    
    //获得数据库
    FMDatabase *db = [self obtainDatabase];
    
    //使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //4.创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS photoTable (id integer PRIMARY KEY AUTOINCREMENT, xCoordinatex float NOT NULL, yCoordinatey float NOT NULL, wide float NOT NULL, high float NOT NULL, rotationAngle float NOT NULL)"];
        if (result)
        {
            NSLog(@"创建图片表成功");
        }
        
        [db close];
    }
    
}

//文字表：writtenWordsTable
//主键：id
//x坐标：xCoordinatex（float类型）
//y坐标：yCoordinatey（float类型）
//宽：wide（float类型）
//高：high（float类型）
//文字大小：fontSize（int类型）
//最大字数：numMax（int类型）（中文算2个字）
- (void)createWrittenWordsTable {
    
    //获得数据库
    FMDatabase *db = [self obtainDatabase];
    
    //使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //4.创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS writtenWordsTable (id integer PRIMARY KEY AUTOINCREMENT, xCoordinatex float NOT NULL, yCoordinatey float NOT NULL, wide float NOT NULL, high float NOT NULL, color varchar NOT NULL, fontSize integer NOT NULL, numMax integer NOT NULL)"];
        if (result)
        {
            NSLog(@"创建文字表成功");
        }
        
        [db close];
    }
    
}

//已解锁表的模板类型表：templateUnlockTable
//主键：id
//模板类型：templateType
//专题类型：specialType
- (void)createTemplateUnlockTable {
    
    //获得数据库
    FMDatabase *db = [self obtainDatabase];
    
    //使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //4.创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS templateUnlockTable (id integer PRIMARY KEY AUTOINCREMENT, templateType varchar NOT NULL, specialType varchar NOT NULL)"];
        if (result)
        {
            NSLog(@"创建已解锁表的模板类型表成功");
            
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO templateUnlockTable (templateType, specialType) VALUES ('%@', '%@')",@"清新",@"1"];
            [db executeUpdate:insertSql];
            
            NSString *insertSql1 = [NSString stringWithFormat:@"INSERT INTO templateUnlockTable (templateType, specialType) VALUES ('%@', '%@')",@"时尚",@"1"];
            [db executeUpdate:insertSql1];
            
            NSString *insertSql2 = [NSString stringWithFormat:@"INSERT INTO templateUnlockTable (templateType, specialType) VALUES ('%@', '%@')",@"1",@"科幻"];
            [db executeUpdate:insertSql2];
            
        }
        
        [db close];
    }
    
}

////模板类型表：templateTypeTable
////主键：id
////模板类型：templateType(txt类型)
//- (void)createTemplateTypeTable {
//    
//    //获得数据库
//    FMDatabase *db = [self obtainDatabase];
//    
//    //使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
//    if ([db open])
//    {
//        //4.创表
//        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS templateTypeTable (id integer PRIMARY KEY AUTOINCREMENT, templateType varchar NOT NULL)"];
//        if (result)
//        {
//            NSLog(@"创建模板类型表成功");
//        }
//        
//        [db close];
//    }
//    
//}


@end
