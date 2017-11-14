//
//  YLAssetCell.m
//  TZImagePickerController
//
//  Created by yiliu on 16/6/23.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLAssetCell.h"

@implementation YLAssetCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        _selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        _selectImageView.image = [UIImage imageNamed:@"selected"];
        _selectImageView.hidden = YES;
        [self.contentView addSubview:_selectImageView];
        
    }
    return self;
}

- (void)setAssetModel:(TZAssetModel *)assetModel{
    _assetModel = assetModel;
    
    if (_assetModel.isSelected) {
        
        _selectImageView.hidden = NO;
        
    }else{
    
        _selectImageView.hidden = YES;
        
    }
    
    [[TZImageManager manager] getPhotoWithAsset:_assetModel.asset photoWidth:self.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        self.imageView.image = photo;
    }];
    
}

@end
