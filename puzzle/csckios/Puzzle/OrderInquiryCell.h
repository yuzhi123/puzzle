//
//  OrderInquiryCell.h
//  Puzzle
//
//  Created by yiliu on 16/10/8.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInquiryCell : UITableViewCell

/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;

/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

/** 订单状态 */
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;

/** 快递单号 */
@property (weak, nonatomic) IBOutlet UILabel *courierNumberLabel;

/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *orderTime;

@end
