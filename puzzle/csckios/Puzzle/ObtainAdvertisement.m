//
//  ObtainAdvertisement.m
//  meitu
//
//  Created by yiliu on 16/3/9.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "ObtainAdvertisement.h"
#import "AFNetworking.h"

@interface ObtainAdvertisement (){
    NSMutableArray *imageNameArray;
    NSArray *imageUrlArry;
}
@end

@implementation ObtainAdvertisement

//获取广告图片路径
- (void)obtainAdvertisementImage{
    
    imageNameArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    //创建存放广告图的文件夹
    [self fileExists];
    /*
    //获取启动图片的下载地址
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *url = [NSString stringWithFormat:@"%@doStartAdvert",POSTURL];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        imageUrlArry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        for (NSString *path in imageUrlArry) {
            NSArray *ary = [path componentsSeparatedByString:@"/"];
            NSString *savedPath = [NSString stringWithFormat:@"%@/Documents/GUANGGAPTUPIAN/%@",NSHomeDirectory(),ary[ary.count-1]];
            
            NSString *imageDownloadUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,path];
            
            NSString *imageName = ary[ary.count-1];
            NSString *imageNameBC = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUANGGAPTUPIAN"];
            
            if (![imageName isEqual:imageNameBC]) {
                [self downloadAdvertisementImage:imageDownloadUrl savedPath:savedPath andImageName:imageName];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
   */
}

//下载启动图片
- (void)downloadAdvertisementImage:(NSString *)url savedPath:(NSString *)savedPath andImageName:(NSString *)imagename {
    /*
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        
        //保存图片的名字
        [[NSUserDefaults standardUserDefaults] setObject:imagename forKey:@"GUANGGAPTUPIAN"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败%@",error);
    }];
    
    [operation start];
    */
}

//判断文件是否存在
- (void)fileExists{
    
    NSString *folderPath = [NSString stringWithFormat:@"%@/Documents/GUANGGAPTUPIAN",NSHomeDirectory()];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //判断createPath路径文件夹是否已存在
    if (![fileManager fileExistsAtPath:folderPath]){
        
        //创建文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSLog(@"创建保存启动图的文件夹成功");
        
    }
    
}

@end
