//
//  DownBasicsTemplate.m
//  Puzzle
//
//  Created by yiliu on 2016/11/7.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "DownBasicsTemplate.h"
#import "PhotoModel.h"

@implementation DownBasicsTemplate

//拷贝初始数据到沙盒
- (void)copyPicture {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:TEMPLATEPATH]) {
        [fileManager createDirectoryAtPath:TEMPLATEPATH withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拷贝数据到沙盒
        NSArray *nameArray = @[@"655de742-d07b-4e0e-94e1-a7d0bfc1dd59",@"winterTemplet",@"2b6d0929-a93c-46c0-b2a4-5c8a4a4975cf",@"02c8a830-4592-413c-af21-fecc98ec35ef",@"4f1bb48d-e417-4327-ae34-44c5185ca8e1",@"7abff410-98aa-4891-adf5-d3812309b4ba",@"0698a50e-7adb-416c-93cb-3797c956241e",@"03330b14-bef6-420e-8e75-6c4214130c64",@"edd3f009-c12d-4bca-a6b7-4a214bee8f14",@"b6197ce5-3e18-4798-8149-d4dad2cb76f9",@"e63ebfaa-cfae-46aa-8a47-d5e725caa017"];
        
        for (NSString *name in nameArray) {
            
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
            
            NSString *filePath = [NSString stringWithFormat:@"%@/%@.png",TEMPLATEPATH,name];
            [fileManager copyItemAtPath:imagePath toPath:filePath error:NULL];
            
        }
        
        //拷贝数据库到沙盒
        NSString *sqlitePath = [[NSBundle mainBundle] pathForResource:@"student" ofType:@"sqlite"];
        
        NSString *appDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [NSString stringWithFormat:@"%@/student.sqlite",appDir];
        [fileManager copyItemAtPath:sqlitePath toPath:filePath error:NULL];
        
    } else {
        NSLog(@"保存模板的文件夹已存在");
    }
    
}

//保存模板数据
- (void)preservationTemplateData {
    
    //创建数据库和表
    //CreateTable *template = [[CreateTable alloc] init];
    //[template createDataAndTable];

//    PhotoModel *photoModel = [[PhotoModel alloc] init];
//    photoModel.xCoordinatex = 322;
//    photoModel.yCoordinatey = 448;
//    photoModel.wide = 900;
//    photoModel.high = 900;
//    photoModel.rotationAngle = 0;
//
//    WrittenWordModel *writtenWordModel = [[WrittenWordModel alloc] init];
//    writtenWordModel.xCoordinatex = 540;
//    writtenWordModel.yCoordinatey = 1400;
//    writtenWordModel.wide = 420;
//    writtenWordModel.high = 170;
//    writtenWordModel.color = @"#b0c6ca";
//    writtenWordModel.fontSize = 48;
//    writtenWordModel.numMax = 4;
//
//    TemplateModel *templateModel = [[TemplateModel alloc] init];
//    templateModel.templateType = @"清新";
//    templateModel.templateSpecial = @"自拍达人";
//    templateModel.templateImageName = @"goodMorning.png";
//    templateModel.photoNum = 1;
//    templateModel.photos = @[photoModel];
//    templateModel.writtenWords = @[writtenWordModel];

//    PhotoModel *photoModel = [[PhotoModel alloc] init];
//    photoModel.xCoordinatex = 0;
//    photoModel.yCoordinatey = 0;
//    photoModel.wide = 1500;
//    photoModel.high = 1198;
//    photoModel.rotationAngle = 0;
//
//    PhotoModel *photoModel1 = [[PhotoModel alloc] init];
//    photoModel1.xCoordinatex = 155;
//    photoModel1.yCoordinatey = 1016;
//    photoModel1.wide = 683;
//    photoModel1.high = 976;
//    photoModel1.rotationAngle = 0;
//
//    TemplateModel *templateModel = [[TemplateModel alloc] init];
//    templateModel.templateType = @"清新";
//    templateModel.templateSpecial = @"自拍达人";
//    templateModel.templateImageName = @"winter.png";
//    templateModel.photoNum = 2;
//    templateModel.photos = @[photoModel,photoModel1];
//    templateModel.writtenWords = @[];

//    PhotoModel *photoModel = [[PhotoModel alloc] init];
//    photoModel.xCoordinatex = 95;
//    photoModel.yCoordinatey = 171;
//    photoModel.wide = 1273;
//    photoModel.high = 860;
//    photoModel.rotationAngle = -2.5;
//
//    PhotoModel *photoModel1 = [[PhotoModel alloc] init];
//    photoModel1.xCoordinatex = 137;
//    photoModel1.yCoordinatey = 1193;
//    photoModel1.wide = 578;
//    photoModel1.high = 758;
//    photoModel1.rotationAngle = 0;
//
//    PhotoModel *photoModel2 = [[PhotoModel alloc] init];
//    photoModel2.xCoordinatex = 789;
//    photoModel2.yCoordinatey = 1193;
//    photoModel2.wide = 578;
//    photoModel2.high = 758;
//    photoModel2.rotationAngle = 0;
//
//    TemplateModel *templateModel = [[TemplateModel alloc] init];
//    templateModel.templateType = @"清新";
//    templateModel.templateSpecial = @"自拍达人";
//    templateModel.templateImageName = @"Taste.png";
//    templateModel.photoNum = 3;
//    templateModel.photos = @[photoModel,photoModel1,photoModel2];
//    templateModel.writtenWords = @[];
//
//
//    TemplateOperation *templateOperation = [[TemplateOperation alloc] init];
//    [templateOperation insertTemplateTableData:templateModel];
//
//    //查询模板
//    NSArray *aray = [templateOperation selectTemplateTableData:@"清新"];
//    NSLog(@"查询到的结果：%@",aray);

}

@end
