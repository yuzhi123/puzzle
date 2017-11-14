//
//  TemplateModel.h
//  Puzzle
//
//  Created by yiliu on 16/9/18.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>

//模板类
@interface TemplateModel : NSObject

/** 主键 */
@property (nonatomic, assign) NSInteger templateId;

/** 类型 */
@property (nonatomic, strong) NSString  *templateType;

/** 专题 */
@property (nonatomic, strong) NSString  *templateSpecial;

/** 模板示例图地址 */
@property (nonatomic, strong) NSString  *templateSampleGraphUrl;

/** 模板下载地址 */
@property (nonatomic, strong) NSString  *templatePictureUrl;

/** 照片数量 */
@property (nonatomic, assign) NSInteger photoNum;

/** 照片(PhotoModel) */
@property (nonatomic, strong) NSArray   *photos;

/** 文字 */
@property (nonatomic, strong) NSArray   *writtenWords;

/** 模板图片名称 */
@property (nonatomic, strong) NSString *templateImageName;


/** 模板是否已下载 */
@property (nonatomic, assign) BOOL  istemplateDownload;

/** 模板是否正在下载 */
@property (nonatomic, assign) BOOL  isDownloading;

/** 模板下载进度 */
@property (nonatomic, assign) float  downloadProgress;

@end