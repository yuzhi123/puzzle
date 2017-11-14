//
//  YLAssetCell.h
//  TZImagePickerController
//
//  Created by yiliu on 16/6/23.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZImageManager.h"
#import "TZAssetModel.h"

@interface YLAssetCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIImageView *selectImageView;

@property (nonatomic,strong) TZAssetModel *assetModel;

@end
