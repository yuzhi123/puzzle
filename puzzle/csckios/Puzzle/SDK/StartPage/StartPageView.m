//
//  GuideView.m
//  meitu
//
//  Created by yiliu on 15/9/23.
//  Copyright (c) 2015年 meitu. All rights reserved.
//

#import "StartPageView.h"

@interface StartPageView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView   *guideScrollView;

@property (nonatomic,strong) UIPageControl  *guidePageControl;

@property (nonatomic,assign) NSInteger      imagePage;

@property (nonatomic,assign) NSInteger      imagePageB;

@end

@implementation StartPageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imagePageB = 9999;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _imagePageB = 9999;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imagePageB = 9999;
    }
    return self;
}

- (UIScrollView *)guideScrollView{
    if(!_guideScrollView){
        _guideScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _guideScrollView.delegate = self;
        _guideScrollView.contentSize = CGSizeMake(WIDE*_imagePageB, HIGH);
        _guideScrollView.showsHorizontalScrollIndicator = NO;
        _guideScrollView.pagingEnabled = YES;
        _guideScrollView.bounces = NO;
        [self addSubview:_guideScrollView];
    }
    return _guideScrollView;
}

//代码里的小圆点注释掉了 图片上已经做好小圆点
//- (UIPageControl *)guidePageControl{
//    if(!_guidePageControl){
//        _guidePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDE/2-50, HIGH-20, 100, 10)];
//        _guidePageControl.numberOfPages = _imagePageB;
//        _guidePageControl.currentPage = 0;
//        _guidePageControl.enabled = NO;
//        // 设置非选中页的圆点颜色
//        _guidePageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//        // 设置选中页的圆点颜色
//        _guidePageControl.currentPageIndicatorTintColor = RGBACOLOR(245, 186, 24, 1);
//        [self addSubview:_guidePageControl];
//    }
//    return _guidePageControl;
//}

//加载图片
- (void)setImageNameArray:(NSArray *)imageNameArray {
    
    _imageNameArray = imageNameArray;
    _imagePageB = _imageNameArray.count;
    
    _imagePage = 0;
    for (int i=0; i<_imageNameArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDE*i, 0, WIDE, HIGH)];
        imageView.image = [UIImage imageNamed:imageNameArray[i]];
        [self.guideScrollView addSubview:imageView];
    }
    self.guidePageControl.hidden = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [self.guideScrollView addGestureRecognizer:tap];
    
}

//加载图片
- (void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    _imagePageB = _imageArray.count;
    
    _imagePage = 0;
    for (int i=0; i<_imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDE*i, 0, WIDE, HIGH)];
        imageView.image = imageArray[i];
        imageView.backgroundColor = [UIColor redColor];
        [self.guideScrollView addSubview:imageView];
    }
    self.guidePageControl.hidden = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [self.guideScrollView addGestureRecognizer:tap];
    
}

//正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.guidePageControl.currentPage = page;
    _imagePage = page;
}

- (void)tapScrollView{
    if(_imagePage == _imagePageB-1){
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(StartPageViewEnd)]){
            [self.delegate StartPageViewEnd];
        }
        
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
}

@end
