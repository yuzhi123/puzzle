//
//  YLPhotoPickerController.h
//  TZImagePickerController
//
//  Created by yiliu on 16/6/23.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//获取所有相册

#import <UIKit/UIKit.h>
#import "EditPhotoController.h"


//声明协议中的接口函数
@protocol  YLPhotoPickerDataSource <NSObject>

- (void)completeSelection:(NSArray *)imagesArray;

@end


@interface YLPhotoPickerController : UIViewController

@property(nonatomic,assign) id<YLPhotoPickerDataSource> dataSource;

@property(nonatomic,assign) id<EditPhotoDelegate> delegate;

/** 是否是多选 */
@property (nonatomic,assign) BOOL isMultiselect;

/** 打印照片 */
@property (nonatomic,assign) BOOL isPrint;

@property (nonatomic,assign) BOOL isShare;

- (void)determine;

@end
