//
//  switchView.m
//  Puzzle
//
//  Created by 王飞 on 2017/10/11.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "switchView.h"
#import "UIView+Extension.h"
#import "iCarousel.h"
#import "UIImage+ImageEffects.h"


@interface switchView ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic,strong) iCarousel* iCarousel;

@property (nonatomic,assign) CGRect iCarouselFrame;

@property (nonatomic,strong) NSMutableArray* viewArray;

@property (nonatomic,strong) NSMutableArray* backViewArray;

@end


@implementation switchView

-(iCarousel*)iCarousel{
    if (!_iCarousel) {
        
        _iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _iCarousel.delegate = self;
        _iCarousel.dataSource =self;
        _iCarousel.bounces = NO;
        _iCarousel.pagingEnabled = YES;
        _iCarousel.type = iCarouselTypeCustom;
        _iCarousel.clipsToBounds = YES;
        //_iCarousel.backgroundColor = [UIColor redColor];
    }
    return _iCarousel;
}


-(instancetype)initWithViewArray:(NSArray*)viewArray andViewFrame:(CGRect)frame andbackView:(NSArray*)backViewArray{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 64, WIDE, HIGH-64-49);
        self.viewArray = [NSMutableArray arrayWithArray:viewArray];
        self.iCarouselFrame = frame;
        [self addSubview:self.iCarousel];
    }
    return self;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    if (self.viewArray.count) {
        
        if (view == nil) {
            //设置最大图片
            // view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 261*BILI, 444*BILI)];
            view = self.viewArray[index];
            // view.backgroundColor = [UIColor whiteColor];
        }
        
        return view;
        
    }
    else
    {
        return nil;
    }
}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.0f;
    //设置最大图和最小图的比例
    static CGFloat min_scale = 395.0/444;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        //放大与缩小的操作
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    if (WIDE == 320) {
        //参数1 用来调节两个item之间的距离
        return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.22, 0.0, 0.0);
    }
    else if (WIDE == 375) {
        return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.22, 0.0, 0.0);
    }
    if (WIDE == 414) {
        return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.22, 0.0, 0.0);
    }
    else
    {
        return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.22, 0.0, 0.0);
        
    }
}

//设置背景
-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    // if (self.viewDataArray.count) {
    // NSInteger i = carousel.currentItemIndex;
    //UIImage* souceImage = self.arrayBackImageArray[i];
    //        UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 150)];
    //        imageV.image = souceImage;
    //        [self.view addSubview:imageV];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg@"]];
    //}
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[souceImage applyLightEffect]];
}

//设置播放元素

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.viewArray.count;
}




@end
