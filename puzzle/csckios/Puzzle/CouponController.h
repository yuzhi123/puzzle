//
//  CouponController.h
//  Puzzle
//
//  Created by yiliu on 16/9/12.
//  Copyright © 2016年 mushoom. All rights reserved.
//



//优惠劵
#import <UIKit/UIKit.h>


@protocol CouponDelegate <NSObject>

/** 选择的优惠劵 */
- (void)choiceCouponDict:(NSDictionary *)dict;

@end


@interface CouponController : UIViewController

@property (nonatomic, weak) id <CouponDelegate> delegate;



@end
