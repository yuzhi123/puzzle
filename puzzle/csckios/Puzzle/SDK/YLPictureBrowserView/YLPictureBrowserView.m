//
//  YLPictureBrowserView.m
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLPictureBrowserView.h"
#import "YLPictureBrowserCell.h"
#import "UIImageView+WebCache.h"

@interface YLPictureBrowserView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

/** 比例 */
@property (nonatomic, strong) UILabel *proportionLabel;

@end


@implementation YLPictureBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)loadView {

    [self addSubview:self.collectionView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self addGestureRecognizer:tap];
    
    _proportionLabel = [[UILabel alloc] init];
    _proportionLabel.textAlignment = NSTextAlignmentCenter;
    _proportionLabel.textColor = RGBACOLOR(0, 200, WIDE, 21);
    [self addSubview:_proportionLabel];
    
}

//图片url
- (void)setImageurlsArray:(NSArray *)imageurlsArray {
    _imageurlsArray = imageurlsArray;
    _proportionLabel.text = [NSString stringWithFormat:@"%tu/%tu",1,_imageurlsArray.count];
}

//图片
- (void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = imagesArray;
    _proportionLabel.text = [NSString stringWithFormat:@"%tu/%tu",1,_imagesArray.count];
}

//图片张数位置
- (void)setImageProportionRect:(CGRect)imageProportionRect {
    _imageProportionRect = imageProportionRect;
    _proportionLabel.frame = _imageProportionRect;
}

//背景颜色
- (void)setBkColor:(UIColor *)bkColor {
    _bkColor = bkColor;
    self.backgroundColor = _bkColor;
}

//点击了view
- (void)tapView:(UITapGestureRecognizer *)tap {
    if(self.delegate && [self.delegate respondsToSelector:@selector(tapYLPictureBrowserView)]){
        [self.delegate tapYLPictureBrowserView];
    }
}

#pragma -mark UICollectionViewDelegate UICollectionViewDataSource
//返回指定区(section)包含的数据源条目数(number of items)，该方法必须实现：
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imagesArray) {
        return _imagesArray.count;
    }else {
        return _imageurlsArray.count;
    }
}

//设定全局的Cell尺寸，如果想要单独定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.bounds.size;
}

//返回某个indexPath对应的cell，该方法必须实现：
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YLPictureBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YLPictureBrowserCell" forIndexPath:indexPath];
    
    cell.backgroundColor = _bkColor;
    cell.contentView.backgroundColor = _bkColor;
    
    cell.pImageRect = _imageRect;
    cell.pbkImageRect = _imageBkRect;
    
    cell.pbkImageView.image = _imagesBkArray[indexPath.row];
    
    if (_imagesArray) {
        cell.pImageView.image = _imagesArray[indexPath.row];
    }else {
        [cell.pImageView sd_setImageWithURL:[NSURL URLWithString:_imageurlsArray[indexPath.row]] placeholderImage:PlaceholderImage];
    }
    
    return cell;
}

//张数比例
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger proportionIndex = (scrollView.contentOffset.x + _collectionView.bounds.size.width * 0.5) / _collectionView.bounds.size.width;
    
    NSInteger index;
    if (_imagesArray) {
        index = _imagesArray.count;
    }else {
        index = _imageurlsArray.count;
    }
    
    _proportionLabel.text = [NSString stringWithFormat:@"%tu/%tu",proportionIndex+1,index];
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[YLPictureBrowserCell class] forCellWithReuseIdentifier:@"YLPictureBrowserCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

@end
