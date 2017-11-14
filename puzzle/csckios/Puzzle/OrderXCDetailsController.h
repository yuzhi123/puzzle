//
//  OrderXCDetailsController.h
//  Puzzle
//
//  Created by yiliu on 2016/11/2.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//相册订单详情

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderXCDetailsController : UIViewController

/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

/** 相册示例图 */
@property (weak, nonatomic) IBOutlet UIImageView *xcImageView;

/** 相册价格 */
@property (weak, nonatomic) IBOutlet UILabel *xcPriceLabel;

/** 相册数量 */
@property (weak, nonatomic) IBOutlet UILabel *xcNumberLabel;

/** 相册小计 */
@property (weak, nonatomic) IBOutlet UILabel *subtotalLabel;

/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

/** 优惠搭配 */
@property (weak, nonatomic) IBOutlet UIView *discountView;

/** 优惠搭配名称 */
@property (weak, nonatomic) IBOutlet UILabel *youhuidapeiNameLabel;

/** 闪光笔图片 */
@property (weak, nonatomic) IBOutlet UIImageView *shanguangbiImageView;

/** 角贴图片 */
@property (weak, nonatomic) IBOutlet UIImageView *jiaotieImageView;

/** 闪光笔名称 */
@property (weak, nonatomic) IBOutlet UILabel *shanguangbiNameLabel;

/** 角贴名称 */
@property (weak, nonatomic) IBOutlet UILabel *jiaotieNameLabel;

/** 优惠搭配价格 */
@property (weak, nonatomic) IBOutlet UILabel *youhuidapeiPriceLabel;





/** 数据 */
@property (nonatomic, strong) OrderModel *orderModel;

@property (nonatomic, strong) NSDictionary *commodityDict;


@end
