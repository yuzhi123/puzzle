//
//  EditPhotoController.h
//  TZImagePickerController
//
//  Created by yiliu on 16/6/23.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//编辑图片

#import <UIKit/UIKit.h>
#import "TZAssetModel.h"


//声明协议中的接口函数
@protocol  EditPhotoDelegate <NSObject>

- (void)editSuccess:(UIImage *)image;

@end

@interface EditPhotoController : UIViewController


@property(nonatomic,assign) id<EditPhotoDelegate> delegate;


@property (nonatomic,strong) TZAssetModel *assetModel;


@property (nonatomic,strong) UIImageView *imageView;

@end
