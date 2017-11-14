//
//  AdvertisementView.h
//  meitu
//
//  Created by yiliu on 15/9/25.
//  Copyright (c) 2015年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdvertisementDelegate <NSObject>

- (void)advertisementEnd;

@end

@interface AdvertisementView : UIView

@property (nonatomic, weak) id <AdvertisementDelegate> delegate;

/**
 *加载广告
 */
- (void)getGuangGao;

@end
