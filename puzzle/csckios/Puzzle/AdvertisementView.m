//
//  AdvertisementView.m
//  meitu
//
//  Created by yiliu on 15/9/25.
//  Copyright (c) 2015年 meitu. All rights reserved.
//

#import "AdvertisementView.h"

@interface AdvertisementView ()

@property (nonatomic,strong) UIImageView   *adcertisementImageView;

@property (nonatomic,strong) UILabel   *timeLabel;

@property (nonatomic,assign) NSInteger  timeNum;

@end

@implementation AdvertisementView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.adcertisementImageView.image = [UIImage imageNamed:@"qidong2"];
        [self addSubview:self.timeLabel];
    }
    return self;
}

//加载广告
- (void)getGuangGao{
    
    NSString *imageName = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUANGGAPTUPIAN"];
    /*
    if(!imageName){
        if(self.delegate && [self.delegate respondsToSelector:@selector(advertisementEnd)]){
            [self.delegate advertisementEnd];
        }
        [self removeFromSuperview];
        return;
    }
    */
    NSString *savedPath = [NSString stringWithFormat:@"%@/Documents/GUANGGAPTUPIAN/%@",NSHomeDirectory(),imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:savedPath];
    [self addImage:image andTime:3];
    /*
    if(image){
        
        [self addImage:image andTime:3];
        
    }else{
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(advertisementEnd)]){
            [self.delegate advertisementEnd];
        }
        [self removeFromSuperview];
        
    }
     */
    
}

- (void)addImage:(UIImage *)image andTime:(NSInteger)timeNum{
    
    _timeNum = timeNum;
    
    self.adcertisementImageView.image = image;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.adcertisementImageView.alpha = 1.0;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(carsTimer:) userInfo:nil repeats:YES];
    
}

//移除定时器
- (void)carsTimer:(NSTimer *)timer{
    
    _timeNum--;
    _timeLabel.text = [NSString stringWithFormat:@"%tu秒",_timeNum];
    if (_timeNum == 0) {
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(advertisementEnd)]){
            [self.delegate advertisementEnd];
        }
        [timer invalidate];
        [self removeFromSuperview];
        
    }
    
}

- (UIImageView *)adcertisementImageView{
    if(!_adcertisementImageView){
        _adcertisementImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _adcertisementImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adcertisementImageView.clipsToBounds = YES;
        _adcertisementImageView.alpha = 0;
        [self addSubview:_adcertisementImageView];
    }
    return _adcertisementImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-54, 24, 44, 20)];
        _timeLabel.text = @"3秒";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        _timeLabel.layer.cornerRadius = 10;
        _timeLabel.layer.masksToBounds = YES;
    }
    return _timeLabel;
}


@end
