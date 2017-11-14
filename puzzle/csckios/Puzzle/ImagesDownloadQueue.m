//
//  ImagesDownloadQueue.m
//  Puzzle
//
//  Created by yiliu on 16/9/27.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "ImagesDownloadQueue.h"
#import "AFNetworking.h"
#import "TemplateModel.h"
#import "TemplateOperation.h"

@interface ImagesDownloadQueue (){
    
    BOOL isDown;
    
}

@property (nonatomic,strong) NSMutableArray *imagesArray;

@end


@implementation ImagesDownloadQueue

+ (ImagesDownloadQueue *)CreateDownloadQueueManager
{
    static ImagesDownloadQueue *imagesDownload = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        imagesDownload = [[self alloc] init];
    });
    return imagesDownload;
}

//加入一个下载项
- (void)downloadImage:(NSDictionary *)dict {
    
    [self.imagesArray addObject:dict];
    
    [self down];
    
}

//加入一群下载项
- (void)downloadImages:(NSArray *)array {
    
    [self.imagesArray addObjectsFromArray:array];
    
    [self down];
    
}

//下载
- (void)down {
    
    if (isDown == NO) {
        
        if (self.imagesArray.count > 0) {
            
            isDown = YES;
            
            NSDictionary *dict = self.imagesArray[0];
            
            TemplateModel *templateModel = dict[@"TemplateModel"];
            
            [self post:[NSURL URLWithString:templateModel.templatePictureUrl] andImageName:templateModel.templateImageName];
            
        }
        
    }
    
}

//下载
- (void)post:(NSURL *)url andImageName:(NSString *)imageName {
/*
    //2.专门进行下载的管理类
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];    //默认传输的数据类型是二进制
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //模式是下载模式
    NSProgress *downloadProgress = nil;
    
    // 第一个参数：将要下载文件的路径    第二个参数：下载进度    第三个参数：（block）：处理下载后文件保存的操作    第四个参数（block）：下载完成的操作 
    NSURLSessionDownloadTask *task = [sessionManager downloadTaskWithRequest:[NSURLRequest requestWithURL:url] progress:&downloadProgress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //沙盒的Documents路径
        NSString *downLoadPath = [NSString stringWithFormat:@"%@/%@",TEMPLATEPATH,imageName];
        
        //返回下载后保存文件的路径
        return [NSURL fileURLWithPath:downLoadPath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        NSLog(@"error : %@",error);
        if (error) {
            
            //下载失败
            NSDictionary *dict = self.imagesArray[0];
            if (self.delegate && [self.delegate respondsToSelector:@selector(downFail:)]) {
                [self.delegate downFail:dict];
            }
            
            [self.imagesArray removeObjectAtIndex:0];
            
            isDown = NO;
            [self down];
            
        }
        
    }];
    
    [task resume];
    
    //利用kvo监听下载进度
    //利用kvo  通过将当前类的对象设置成观察者(监听者),让当前类观察downloadProgress里面的fractionCompleted属性的变化
    //NSKeyValueObservingOptionNew:标记值的变化,这个是新值    //NSKeyValueObservingOptionOld:旧值
    [downloadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    */
}

#pragma mark - //kvo观察者触发的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    
    //获取 进度变化
    float chanagefl = [[object valueForKeyPath:keyPath] floatValue];
    
    NSLog(@"下载进度：%f",chanagefl);
    
    NSDictionary *dict = self.imagesArray[0];
    
    TemplateModel *templateModel = dict[@"TemplateModel"];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        templateModel.downloadProgress = chanagefl;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(downProgress:)]) {
            [self.delegate downProgress:dict];
        }
        
        if (chanagefl == 1 && templateModel.istemplateDownload == NO) {
            
            templateModel.istemplateDownload = YES;
            templateModel.isDownloading = NO;
            
            TemplateOperation *templateOperation = [[TemplateOperation alloc] init];
            [templateOperation insertTemplateTableData:templateModel];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(downProgress:)]) {
                [self.delegate downProgress:dict];
            }
            
            [self.imagesArray removeObjectAtIndex:0];
            
            isDown = NO;
            [self down];
            
        }
        
    }];
    
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _imagesArray;
}


@end
