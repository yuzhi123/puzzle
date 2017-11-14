//
//  OrderModel.h
//  Puzzle
//
//  Created by yiliu on 2016/10/21.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//订单

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger orderId;

/** 订单状态 */
@property (nonatomic, strong) NSString  *orderState;

/** 快递单号 */
@property (nonatomic, strong) NSString  *courierNumber;

/** 姓名 */
@property (nonatomic, strong) NSString  *nickName;

/** 电话 */
@property (nonatomic, strong) NSString  *phoneNumber;

/** 地址 */
@property (nonatomic, strong) NSString  *address;

/** 订单名称 */
@property (nonatomic, strong) NSString  *commodityName;

/** 订单发布时间 */
@property (nonatomic, strong) NSString  *time;

/** 商品信息 */
@property (nonatomic, strong) NSArray  *instancesArray;

/** 运费 */
@property (nonatomic, assign) float    freight;

/** 合计 */
@property (nonatomic, assign) float total;


@end
