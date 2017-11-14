//
//  InstancesModel.h
//  Puzzle
//
//  Created by yiliu on 2016/10/27.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstancesModel : NSObject

/** 商品id */
@property (nonatomic, assign) NSInteger instancesId;

/** 商品名称 */
@property (nonatomic, strong) NSString  *name;

/** 单价 */
@property (nonatomic, strong) NSString  *unitPrice;

/** 数量 */
@property (nonatomic, strong) NSString  *number;

/** 优惠券id */
@property (nonatomic, strong) NSString  *couponId;

/** 照片URL */
@property (nonatomic, strong) NSArray  *imagesURLArray;

@end
