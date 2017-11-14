//
//  OrderDetailsController.h
//  Puzzle
//
//  Created by yiliu on 2016/10/31.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//照片订单详情

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "InstancesModel.h"

@interface OrderDetailsController : UIViewController

@property (nonatomic, strong) OrderModel *orderModel;

@property (nonatomic, strong) NSArray *commodityArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *freightLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;



@end
