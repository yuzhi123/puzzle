//
//  TemplateOperation.m
//  Puzzle
//
//  Created by yiliu on 16/9/18.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TemplateOperation.h"
#import "FMDB.h"


@implementation TemplateOperation

- (FMDatabase *)obtainDatabase {
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"/student.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    return db;
}


/** 插入数据 */
- (void)insertTemplateTableData:(TemplateModel *)model {
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        /** 类型 */
        NSString *templateType = model.templateType;
        
        /** 专题 */
        NSString *templateSpecial = model.templateSpecial;
        
        /** 模板模板名称 */
        NSString *templateImageName = model.templateImageName;
        
        /** 照片数量 */
        NSInteger photoNum = model.photoNum;
        
        /** 照片(PhotoModel) */
        NSArray *photos = model.photos;
        
        /** 文字 */
        NSArray *writtenWords = model.writtenWords;
        
        /** 模板示例图url */
        NSString *sampleGraphUrl= model.templateSampleGraphUrl;
        
        //图片表插入数据
        for (PhotoModel *photoModel in photos) {
            
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO photoTable (xCoordinatex, yCoordinatey, wide, high, rotationAngle) VALUES ('%f', '%f', '%f', '%f', '%f')",photoModel.xCoordinatex, photoModel.yCoordinatey, photoModel.wide, photoModel.high, photoModel.rotationAngle];
            [db executeUpdate:insertSql];
            
        }
        
        //文字表插入数据
        for (WrittenWordModel *writtenWordModel in writtenWords) {
            
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO writtenWordsTable (xCoordinatex, yCoordinatey, wide, high, color, fontSize, numMax) VALUES ('%f', '%f', '%f', '%f', '%@' ,'%tu', '%tu')",writtenWordModel.xCoordinatex, writtenWordModel.yCoordinatey, writtenWordModel.wide, writtenWordModel.high, writtenWordModel.color, writtenWordModel.fontSize, writtenWordModel.numMax];
            [db executeUpdate:insertSql];
        }
        
        //查询新插入的图片id
        NSString *photosStr = @"";
        if (photos.count > 0) {
            
            NSString *executeQuery = [NSString stringWithFormat:@"select * from photoTable order by id desc limit %tu",photos.count];
            FMResultSet *resultSet = [db executeQuery:executeQuery];
            
            while ([resultSet next]) {
                
                if (photosStr.length == 0) {
                    
                    photosStr = [NSString stringWithFormat:@"%tu",[resultSet intForColumn:@"id"]];
                    
                }else {
                    
                    photosStr = [NSString stringWithFormat:@"%@,%tu",photosStr,[resultSet intForColumn:@"id"]];
                    
                }
                
            }
            
        }
        
        //查询新插入的文字的id
        NSString *writtenWordsStr = @"";
        if (writtenWords.count > 0) {
            
            NSString *executeQuery = [NSString stringWithFormat:@"select * from writtenWordsTable order by id desc limit %tu",writtenWords.count];
            FMResultSet *resultSet = [db executeQuery:executeQuery];
            
            while ([resultSet next]) {
                
                if (writtenWordsStr.length == 0) {
                    
                    writtenWordsStr = [NSString stringWithFormat:@"%tu",[resultSet intForColumn:@"id"]];
                    
                }else {
                    
                    writtenWordsStr = [NSString stringWithFormat:@"%@,%tu",writtenWordsStr,[resultSet intForColumn:@"id"]];
                    
                }
                
            }
            
        }
        //模板表
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO templateTable (templateType, templateSpecial, templateImageName, photoNum, photos, writtenWords, sampleGraphUrl) VALUES ('%@', '%@', '%@', '%tu', '%@', '%@', '%@')",templateType, templateSpecial, templateImageName, photoNum, photosStr, writtenWordsStr, sampleGraphUrl];
        [db executeUpdate:insertSql];
        NSLog(@"插入数据成功");
        
        [db close];
        
    }else {
        
        NSLog(@"打开数据库失败");
        
    }
    
}

/** 根据模板类型、模板专题、模板图片名称查询是否已下载该模板 */
- (BOOL)selectTemplateType:(NSString *)type special:(NSString *)special imageName:(NSString *)imageName {

    FMDatabase *db = [self obtainDatabase];
    
    BOOL isDown = NO;
    
    if ([db open]) {
        
        NSString *selectSql = [NSString stringWithFormat:@"select * from templateTable where templateType='%@' and templateSpecial='%@' and templateImageName='%@'",type,special,imageName];
        FMResultSet *resultSet = [db executeQuery:selectSql];
        
        //遍历结果集合
        while ([resultSet next]) {
            
            isDown = YES;
            
        }
        
        [db close];
        
    }
    
    return isDown;
    
}

/** 根据类型查询模板表 */
- (NSMutableArray *)selectTemplateTypeData:(NSString *)type {
    
    NSMutableArray *templateArray = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        NSString *selectSql = [NSString stringWithFormat:@"select * from templateTable where templateType='%@'",type];
        FMResultSet *resultSet = [db executeQuery:selectSql];
        
        //遍历结果集合
        while ([resultSet next]) {
            
            TemplateModel *template = [[TemplateModel alloc] init];
            template.templateId = [resultSet intForColumn:@"id"];
            template.templateType = [resultSet stringForColumn:@"templateType"];
            template.templateSpecial = [resultSet stringForColumn:@"templateSpecial"];
            template.templateImageName = [resultSet stringForColumn:@"templateImageName"];
            template.templateSampleGraphUrl = [resultSet stringForColumn:@"sampleGraphUrl"];
            template.photoNum = [resultSet intForColumn:@"photoNum"];
            template.photos = [self selectPhotoTableDta:[resultSet stringForColumn:@"photos"]];
            template.writtenWords = [self selectWrittenWordsTableDta:[resultSet stringForColumn:@"writtenWords"]];
            [templateArray addObject:template];
            
        }
        
        [db close];
        
    }
    
    return templateArray;
    
}


/** 根据专题查询模板数据 */
- (NSMutableArray *)selectTemplateTermsData:(NSString *)terms {
    
    NSMutableArray *templateArray = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        NSString *selectSql = [NSString stringWithFormat:@"select * from templateTable where templateSpecial='%@'",terms];
        FMResultSet *resultSet = [db executeQuery:selectSql];
        
        //遍历结果集合
        while ([resultSet next]) {
            
            TemplateModel *template = [[TemplateModel alloc] init];
            template.templateId = [resultSet intForColumn:@"id"];
            template.templateType = [resultSet stringForColumn:@"templateType"];
            template.templateSpecial = [resultSet stringForColumn:@"templateSpecial"];
            template.templateImageName = [resultSet stringForColumn:@"templateImageName"];
            template.templateSampleGraphUrl = [resultSet stringForColumn:@"sampleGraphUrl"];
            template.photoNum = [resultSet intForColumn:@"photoNum"];
            template.photos = [self selectPhotoTableDta:[resultSet stringForColumn:@"photos"]];
            template.writtenWords = [self selectWrittenWordsTableDta:[resultSet stringForColumn:@"writtenWords"]];
            [templateArray addObject:template];
            
        }
        
        [db close];
        
    }
    
    return templateArray;
    
}


/** 根据类型和图片数量查询模板表 */
- (NSMutableArray *)selectTemplateTypeData:(NSString *)type photoNum:(NSInteger)photoNum {

    NSMutableArray *templateArray = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        NSString *selectSql = [NSString stringWithFormat:@"select * from templateTable where templateType='%@' and photoNum=%tu",type,photoNum];
        FMResultSet *resultSet = [db executeQuery:selectSql];
        
        //遍历结果集合
        while ([resultSet next]) {
            
            TemplateModel *template = [[TemplateModel alloc] init];
            template.templateId = [resultSet intForColumn:@"id"];
            template.templateType = [resultSet stringForColumn:@"templateType"];
            template.templateSpecial = [resultSet stringForColumn:@"templateSpecial"];
            template.templateImageName = [resultSet stringForColumn:@"templateImageName"];
            template.templateSampleGraphUrl = [resultSet stringForColumn:@"sampleGraphUrl"];
            template.photoNum = [resultSet intForColumn:@"photoNum"];
            template.photos = [self selectPhotoTableDta:[resultSet stringForColumn:@"photos"]];
            template.writtenWords = [self selectWrittenWordsTableDta:[resultSet stringForColumn:@"writtenWords"]];
            [templateArray addObject:template];
            
        }
        
        [db close];
        
    }
    
    return templateArray;
    
}


/** 根据专题和图片数量查询模板表 */
- (NSMutableArray *)selectTemplateTermData:(NSString *)term photoNum:(NSInteger)photoNum {
    
    NSMutableArray *templateArray = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        NSString *selectSql = [NSString stringWithFormat:@"select * from templateTable where templateSpecial='%@' and photoNum=%tu",term,photoNum];
        FMResultSet *resultSet = [db executeQuery:selectSql];
        
        //遍历结果集合
        while ([resultSet next]) {
            
            TemplateModel *template = [[TemplateModel alloc] init];
            template.templateId = [resultSet intForColumn:@"id"];
            template.templateType = [resultSet stringForColumn:@"templateType"];
            template.templateSpecial = [resultSet stringForColumn:@"templateSpecial"];
            template.templateImageName = [resultSet stringForColumn:@"templateImageName"];
            template.templateSampleGraphUrl = [resultSet stringForColumn:@"sampleGraphUrl"];
            template.photoNum = [resultSet intForColumn:@"photoNum"];
            template.photos = [self selectPhotoTableDta:[resultSet stringForColumn:@"photos"]];
            template.writtenWords = [self selectWrittenWordsTableDta:[resultSet stringForColumn:@"writtenWords"]];
            [templateArray addObject:template];
            
        }
        
        [db close];
        
    }
    
    return templateArray;
    
}


/** 根据id查询图片表 */
- (NSMutableArray *)selectPhotoTableDta:(NSString *)photoIds {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSArray *photoIdArrary = [photoIds componentsSeparatedByString:@","];
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        for (NSString *photoId in photoIdArrary) {
            
            NSString *selectSql = [NSString stringWithFormat:@"select * from photoTable where id='%@'",photoId];
            FMResultSet *resultSet = [db executeQuery:selectSql];
            
            //遍历结果集合
            while ([resultSet next]) {
                
                PhotoModel *photoModel = [[PhotoModel alloc] init];
                photoModel.photoId = [resultSet intForColumn:@"id"];
                photoModel.xCoordinatex = [resultSet doubleForColumn:@"xCoordinatex"];
                photoModel.yCoordinatey = [resultSet doubleForColumn:@"yCoordinatey"];
                photoModel.wide = [resultSet doubleForColumn:@"wide"];
                photoModel.high = [resultSet doubleForColumn:@"high"];
                photoModel.rotationAngle = [resultSet doubleForColumn:@"rotationAngle"];
                [dataArray addObject:photoModel];
                
            }
            
        }
        
    }
    
    return dataArray;
    
}

/** 根据id查询文字表 */
- (NSMutableArray *)selectWrittenWordsTableDta:(NSString *)writtenWordsIds {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSArray *writtenWordsIdArrary = [writtenWordsIds componentsSeparatedByString:@","];
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        for (NSString *writtenWordId in writtenWordsIdArrary) {
            
            NSString *selectSql = [NSString stringWithFormat:@"select * from writtenWordsTable where id='%@'",writtenWordId];
            FMResultSet *resultSet = [db executeQuery:selectSql];
            
            //遍历结果集合
            while ([resultSet next]) {
                
                WrittenWordModel *writtenWordModel = [[WrittenWordModel alloc] init];
                writtenWordModel.writtenWordId = [resultSet intForColumn:@"id"];
                writtenWordModel.xCoordinatex = [resultSet doubleForColumn:@"xCoordinatex"];
                writtenWordModel.yCoordinatey = [resultSet doubleForColumn:@"yCoordinatey"];
                writtenWordModel.wide = [resultSet doubleForColumn:@"wide"];
                writtenWordModel.high = [resultSet doubleForColumn:@"high"];
                writtenWordModel.color = [resultSet stringForColumn:@"color"];
                writtenWordModel.fontSize = [resultSet doubleForColumn:@"fontSize"];
                writtenWordModel.numMax = [resultSet doubleForColumn:@"numMax"];
                [dataArray addObject:writtenWordModel];
                
            }
            
        }
        
    }
    
    return dataArray;
    
}

/** 根据模板类型、专题类型 搜索是否已解锁 */
- (BOOL)selectIsUnlock:(NSString *)name andType:(NSString *)type {
    
    FMDatabase *db = [self obtainDatabase];
    
    BOOL isDown = NO;
    
    if ([db open]) {
        
        NSString *selectSql = [NSString stringWithFormat:@"select * from templateUnlockTable where %@='%@'",type,name];
        FMResultSet *resultSet = [db executeQuery:selectSql];
        
        //遍历结果集合
        while ([resultSet next]) {
            
            isDown = YES;
            
        }
        
        [db close];
        
    }
    
    return isDown;
    
}


/** 删除模板 */
- (NSInteger)deleteTemplate:(NSArray *)dataArray {
    
    NSInteger deleteNum = 0;
    
    FMDatabase *db = [self obtainDatabase];
    
    if ([db open]) {
        
        for (TemplateModel *model in dataArray) {
            
            NSString *deleteSql = [NSString stringWithFormat:@"delete from templateTable where id='%tu'",model.templateId];
            BOOL isc =  [db executeUpdate:deleteSql];
            if (isc) {
                deleteNum++;
                NSLog(@"删除成功");
            }else {
                NSLog(@"删除失败");
            }
            
        }
        
        [db close];
        
    }
    
    return deleteNum;
    
}

@end
