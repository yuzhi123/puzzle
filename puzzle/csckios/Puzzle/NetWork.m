//
//  NetWork.m
//  FeiHangChuangKe
//
//  Created by 王飞 on 17/9/11.
//  Copyright © 2017年 FeiHangKeJi.com. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"

@interface NetWork ()
@property (nonatomic,strong)AFHTTPSessionManager* manager;
@end

@implementation NetWork



-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置超长时间
        _manager.requestSerializer.timeoutInterval = 20.0;
    }
    return _manager;
}

// 网络检测
-(void)checkNet
{
    
    NSLog(@"检测网络");
    AFNetworkReachabilityManager* manager = [AFNetworkReachabilityManager sharedManager];
    //开始检测网络
    [manager startMonitoring];
    NSLog(@"有网：%d",[manager isReachable]);
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //status存放当前的网络状态
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //wifi
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //4G网
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                //未连接
                
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                //未知网络
                
                break;
            default:
                break;
        }
    }];
}


#pragma mark -- postRequest
-(void)loadPost:(NSString*) url andParameter:(NSDictionary*)upDic withToken:(BOOL)isToken block:(void(^)(NSDictionary*dataDic))block
{
    [self checkNet];
     NSString* newUrl = [NSString stringWithFormat:@"%@%@",HEADURL,url];
    NSMutableDictionary* dic = @{};
    if (upDic) {
        dic= [NSMutableDictionary dictionaryWithDictionary:upDic];
    }
    
    if (isToken) {
        
        [dic setObject:[self getStrfromUserdefalultWithKey:@"token"] forKey:@"token"];
    }
    
    [self.manager POST:newUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
          NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSDictionary* dic = [self dictionaryWithJsonString:result];
        if ([[dic objectForKey:@"success"] boolValue]) {
            // 存储数据
            [self storageNetDataWithData:dic andKey:url andTask:task andUpDic:upDic];
            block(dic);
        }
        else{
            NSLog(@"%@",[dic objectForKey:@"reason"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSDictionary* dic = @{@"success":@"false"};
        block(dic);
    }];
    
}

#pragma mark -- getRequest
-(void)loadGet:(NSString*) url andparameter:(NSDictionary*)upDic withToken:(BOOL)isToken block:(void(^)(NSDictionary* dataDic))block
{
    [self checkNet];
    NSString* newUrl = [NSString stringWithFormat:@"https://%@%@",HEADURL,url];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:upDic];
    if (isToken) {
        
        [dic setObject:[self getStrfromUserdefalultWithKey:@"token"] forKey:@"token"];
    }

    [self.manager GET:newUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary* dic = [self dictionaryWithJsonString:result];
        
        if ([[dic objectForKey:@"success"] boolValue]) {
            // 存储数据
            [self storageNetDataWithData:dic andKey:url andTask:task andUpDic:upDic];
            block(dic);
        }
        else{
            NSLog(@"%@",[dic objectForKey:@"reason"]);
        }
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary* dic = @{@"success":@"false"};
        block(dic);
    }];
}

// 上传多张图片
-(void)loadpost:(NSString*) url andParameter:(NSDictionary*) upDic  andImageeArray:(NSArray*)array andImageNameArray:(NSMutableArray*)imageNameArray withToken:(BOOL)isToken block:(void(^)(NSDictionary* dataDic))block
{
    [self checkNet];
    NSString* newUrl = [NSString stringWithFormat:@"https://%@%@",HEADURL,url];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:upDic];
    if (isToken) {
        
        [dic setObject:[self getStrfromUserdefalultWithKey:@"token"] forKey:@"token"];
    }
    [self.manager POST:newUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i= 0; i<imageNameArray.count; i++) {
            
            NSData *fileData = UIImageJPEGRepresentation(array[i], 1);
            [formData appendPartWithFileData:fileData name:@"img" fileName:imageNameArray[i] mimeType:@"image/jpeg"];
        
            NSLog(@"第%d张",i);
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        CGFloat jindu = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [self dictionaryWithJsonString:result];
        NSLog(@"%@",[self dictionaryWithJsonString:result]);
        NSDictionary* dic = [self dictionaryWithJsonString:result];
        
        if ([[dic objectForKey:@"success"] boolValue]) {
            // 存储数据
            [self storageNetDataWithData:dic andKey:url andTask:task andUpDic:upDic];
            block(dic);
        }
        else{
            NSLog(@"%@",[dic objectForKey:@"reason"]);
        }

        block(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary* dic = @{@"success":@"false"};
        block(dic);
    }];
    
}

// 上传用户头像
-(void)loadPostheadImage:(NSString*) url andParameter:(NSDictionary*)upDic withToken:(BOOL)isToken block:(void(^)(NSDictionary*dataDic))block
{
    [self checkNet];
    NSString* newUrl = [NSString stringWithFormat:@"https://%@%@",HEADURL,url];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:upDic];
    if (isToken) {
        
        [dic setObject:[self getStrfromUserdefalultWithKey:@"token"] forKey:@"token"];
    }
    [self.manager POST:newUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *fileData = UIImageJPEGRepresentation([upDic objectForKey:@"photo"], 1);
        [formData appendPartWithFileData:fileData name:@"photo" fileName:@"www.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        //CGFloat jindu = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [self dictionaryWithJsonString:result];
        NSLog(@"%@",[self dictionaryWithJsonString:result]);
        NSDictionary* dic = [self dictionaryWithJsonString:result];
        
        if ([[dic objectForKey:@"success"] boolValue]) {
            // 存储数据
            [self storageNetDataWithData:dic andKey:url andTask:task andUpDic:upDic];
            block(dic);
        }
        else{
            NSLog(@"%@",[dic objectForKey:@"reason"]);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary* dic = @{@"success":@"false"};
        block(dic);
    }];
    

}



// tool
-(NSString*)getStrfromUserdefalultWithKey:(NSString*)key{
    
    NSUserDefaults* myUserdefault = [NSUserDefaults standardUserDefaults];
    NSString* value = [myUserdefault objectForKey:key];
    [myUserdefault synchronize];
    return value;
}

// json转字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//数组转json
-(NSArray*)arrayWithJsonString:(NSString*)jsonString{
    
    if (!jsonString) {
        return nil;
    }
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err;
    NSArray* array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    return array;
}



#pragma mark -- 存入数据
// 存数据 网络数据存储 做缓存
/*
 param1: 网络数据
 param2: 访问链接
 param3: 网络task
 param4: 上传数据
 利用url作为文件后缀，如果有lastId 将lastID与url一起做为后缀生成文件
 */

-(void)storageNetDataWithData:(NSDictionary*)data andKey:(NSString*)url andTask:(NSURLSessionDataTask * _Nonnull)task andUpDic:(NSDictionary*)dic{
    
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 创建文件夹路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/UrlInfomation", pathDocuments];
    //判断文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    } else {
        NSLog(@"FileDir is exists.");
    }
    // 去除.与/
    NSString* tempStrUrl = [url stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString* strUrl = [tempStrUrl stringByReplacingOccurrencesOfString:@"/" withString:@""];
    // 获取文件后缀
    NSString* suffix = [self getSuffix:dic andUrl:strUrl];
    // 拼成最新路径
    NSString* configFile = [createPath stringByAppendingString:suffix]; //最新地址，也可能是以前的地址
    
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
        NSDictionary* dicTemp = r.allHeaderFields;
        NSLog(@"%@",dicTemp);
        if (data== nil) { //访问出错  无数据返回
            return;
        }
        
        // 需要写入文件的数据源
        NSDictionary* newDic = @{@"task":dicTemp,@"data":data};
        
        NSLog(@"当前状态码%ld",(long)r.statusCode);
        
        // 内容发生改变
        if (r.statusCode == 200) {
            
            //获取以前的路径，可能为空
            
            NSFileManager* fileManager = [NSFileManager defaultManager];
            
            // 生成新的路径
            //直接移除以前的数据
            [fileManager removeItemAtPath:configFile error:nil];
            
            // 并且重新写入
            BOOL isSuccess = [newDic writeToFile:configFile atomically:YES];
            
            if (isSuccess) {
                NSLog(@"文件写入成功");
            }
            else
            {
                NSLog(@"文件写入失败");
            }
            
        }
        
    }
    else
    {
        NSDictionary* dataDic = [NSDictionary dictionaryWithContentsOfFile:configFile];
        
        NSLog(@"访问出错，采用缓存数据");
    
    }
}

#pragma mark -- 取数据
// 取缓存数据
/*
 param1:链接URL
 param2:上传的数据
 */
-(NSDictionary*)getCacheDataWithUrl:(NSString*)url AndUpDic:(NSDictionary*)upDic{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 创建文件夹路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/UrlInfomation", pathDocuments];
    //判断文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    } else {
        NSLog(@"FileDir is exists.");
    }
    // 去除.与/
    NSString* tempStrUrl = [url stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString* strUrl = [tempStrUrl stringByReplacingOccurrencesOfString:@"/" withString:@""];
    // 获取文件后缀
    NSString* suffix = [self getSuffix:upDic andUrl:strUrl];
    // 拼成最新路径
    NSString* configFile = [createPath stringByAppendingString:suffix]; //最新地址，也可能是以前的地址

    NSDictionary* dataDic = [NSDictionary dictionaryWithContentsOfFile:configFile];
    
    return (NSDictionary*)[dataDic objectForKey:@"data"];

}

//生成文件后缀
-(NSString*)getSuffix:(NSDictionary*)dic andUrl:(NSString*)str
{
    if ([dic objectForKey:@"lastId"]) {
        
        return [NSString stringWithFormat:@"/%@%@.plist",str,[dic objectForKey:@"lastId"]];
    }
    else if ([dic objectForKey:@"last_Id"])
    {
        return [NSString stringWithFormat:@"/%@%@.plist",str,[dic objectForKey:@"last_Id"]];
    }
    else if ([dic objectForKey:@"last_id"])
    {
        return [NSString stringWithFormat:@"/%@%@.plist",str,[dic objectForKey:@"last_id"]];
    }
    return [NSString stringWithFormat:@"/%@.plist",str];
}

@end
