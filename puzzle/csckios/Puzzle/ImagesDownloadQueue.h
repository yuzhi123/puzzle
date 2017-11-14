//
//  ImagesDownloadQueue.h
//  Puzzle
//
//  Created by yiliu on 16/9/27.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ImagesDownloadQueueDelegate <NSObject>

/** 下载进度等信息 */
- (void)downProgress:(NSDictionary *)dict;

/** 下载失败 */
- (void)downFail:(NSDictionary *)dict;

@end



@interface ImagesDownloadQueue : NSObject


@property (nonatomic, weak) id <ImagesDownloadQueueDelegate> delegate;


+ (ImagesDownloadQueue *)CreateDownloadQueueManager;

/** 加入一个下载项 */
- (void)downloadImage:(NSDictionary *)dict;

/** 加入一群下载项 */
- (void)downloadImages:(NSArray *)array;

@end
