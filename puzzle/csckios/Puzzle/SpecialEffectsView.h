//
//  SpecialEffectsView.h
//  meitu
//
//  Created by yiliu on 15/5/27.
//  Copyright (c) 2015年 meitu. All rights reserved.
//

//特效

#import <UIKit/UIKit.h>

@protocol SpecialEffectsDelegate <NSObject>

- (void)specialEffectsLJImage:(UIImage *)image;

@end

@interface SpecialEffectsView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) id<SpecialEffectsDelegate> delegate;

@property (nonatomic, strong) UIImage *photoImage;

@end
