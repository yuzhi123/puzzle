//
//  YLBrowserView.m
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLBrowserView.h"
#import "YLBrowserCell.h"
#import "UIImageView+WebCache.h"

@interface YLBrowserView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UIPageControl *pageCtrl;

@end

@implementation YLBrowserView

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
    
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.7);
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageCtrl];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(WIDE-56, self.collectionView.frame.origin.y-36, 36, 36)];
    [btn addTarget:self action:@selector(removeView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"icloseBtn"] forState:UIControlStateNormal];
    [self addSubview:btn];
    
}

//移除view
- (void)removeView:(UIButton *)btn {
    [self removeFromSuperview];
}

//图片数组
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    _pageCtrl.numberOfPages = _dataArray.count;
}

#pragma -mark UICollectionViewDelegate UICollectionViewDataSource
//返回指定区(section)包含的数据源条目数(number of items)，该方法必须实现：
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

//设定全局的Cell尺寸，如果想要单独定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _collectionView.bounds.size;
}

//返回某个indexPath对应的cell，该方法必须实现：
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YLBrowserCell" forIndexPath:indexPath];
    
    cell.pImageView.frame = CGRectMake(20, 0, _collectionView.bounds.size.width-40, _collectionView.bounds.size.height-40);
    cell.remarksLabel.frame = CGRectMake(20, _collectionView.bounds.size.height-40, _collectionView.bounds.size.width-40, 40);
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    [cell.pImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
    cell.remarksLabel.text = dict[@"validity"];
    
    return cell;
}

//张数比例
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger proportionIndex = (scrollView.contentOffset.x + _collectionView.bounds.size.width * 0.5) / _collectionView.bounds.size.width;
    _pageCtrl.currentPage = proportionIndex;
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2-((self.bounds.size.width/320)*230)/2, self.bounds.size.width, (self.bounds.size.width/320)*230) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[YLBrowserCell class] forCellWithReuseIdentifier:@"YLBrowserCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UIPageControl *)pageCtrl {
    if (!_pageCtrl) {
        _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _collectionView.frame.origin.y+_collectionView.frame.size.height, WIDE-40, 30)];
        _pageCtrl.currentPage = 0;
    }
    return _pageCtrl;
}

@end
