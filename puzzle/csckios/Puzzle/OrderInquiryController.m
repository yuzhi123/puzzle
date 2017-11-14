//
//  OrderInquiryController.m
//  Puzzle
//
//  Created by yiliu on 16/10/8.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "OrderInquiryController.h"
#import "OrderInquiryCell.h"
#import "OrderModel.h"
#import "InstancesModel.h"
#import "Auxiliary.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "OrderDetailsController.h"
#import "OrderXCDetailsController.h"


@interface OrderInquiryController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation OrderInquiryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    _selectBtn.layer.cornerRadius = 4;
    _selectBtn.layer.masksToBounds = YES;
    
}

//查询
- (IBAction)inquiryOrder:(id)sender {
    
    if (![Auxiliary isMobileNumber:self.phoneNumberField.text]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
        
    }
    
    [self POST:self.phoneNumberField.text];
    
}

#pragma -mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"OrderInquiryCell";
    OrderInquiryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    OrderModel *orderModel = self.dataArray[indexPath.row];
    
    cell.commodityNameLabel.text = orderModel.commodityName;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",orderModel.total];
    cell.addressLabel.text = orderModel.address;
    cell.orderStateLabel.text = [NSString stringWithFormat:@"订单状态：%@",orderModel.orderState];
    cell.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",orderModel.time];
    
    if (orderModel.courierNumber) {
        cell.courierNumberLabel.text = [NSString stringWithFormat:@"快递单号：%@",orderModel.courierNumber];
    }else {
        cell.courierNumberLabel.text = @"快递单号：暂无";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderModel *orderModel = self.dataArray[indexPath.row];
    InstancesModel *instancesModel = orderModel.instancesArray[0];
    
    if ([instancesModel.name isEqual:@"手写DIY相册"]) {
        
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        OrderXCDetailsController *orderXCDetails = [storyboard instantiateViewControllerWithIdentifier:@"OrderXCDetails"];
        orderXCDetails.orderModel = orderModel;
        orderXCDetails.commodityDict = _commodityArray[2];
        [self.navigationController pushViewController:orderXCDetails animated:YES];
        
    }else {
        
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        OrderDetailsController *orderDetails = [storyboard instantiateViewControllerWithIdentifier:@"OrderDetails"];
        orderDetails.orderModel = orderModel;
        orderDetails.commodityArray = _commodityArray;
        [self.navigationController pushViewController:orderDetails animated:YES];
        
    }
    
}

//返回
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)POST:(NSString *)phoneNumer {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *url = [NSString stringWithFormat:@"%@order/allOrder?phoneNumber=%@",POSTURL,phoneNumer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"订单：%@",ary);
        //模板类型
        for (NSDictionary *dict in ary) {
            
            OrderModel *orderModel = [[OrderModel alloc] init];
            orderModel.orderId = [dict[@"id"] integerValue];
            orderModel.orderState = [NSString stringWithFormat:@"%@",dict[@"state"][@"name"]];
            orderModel.nickName = [NSString stringWithFormat:@"%@",dict[@"nickName"]];
            orderModel.phoneNumber = [NSString stringWithFormat:@"%@",dict[@"phoneNumber"]];
            orderModel.address = [NSString stringWithFormat:@"%@",dict[@"address"]];
            orderModel.time = dict[@"date"];//[Auxiliary timeTransformation:dict[@"date"]];
            orderModel.freight = [dict[@"freight"] floatValue];
            orderModel.total = [dict[@"total"] floatValue];
            
            //快递单号
            if (dict[@"express"]) {
                orderModel.courierNumber = [NSString stringWithFormat:@"%@",dict[@"express"][@"expressNum"]];
            }
            
            NSString *commodityName;
            NSMutableArray *instancesArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *instancesDict in dict[@"instances"]) {
                
                InstancesModel *instancesModel = [[InstancesModel alloc] init];
                instancesModel.instancesId = [instancesDict[@"commodity"][@"id"] integerValue];
                instancesModel.name = [NSString stringWithFormat:@"%@",instancesDict[@"commodity"][@"name"]];
                instancesModel.unitPrice = [NSString stringWithFormat:@"%@",instancesDict[@"commodity"][@"unitPrice"]];
                instancesModel.number = [NSString stringWithFormat:@"%@",instancesDict[@"number"]];
                instancesModel.couponId = [NSString stringWithFormat:@"%@",instancesDict[@"couponId"]];
                
                //照片
                if (instancesDict[@"images"]) {
                    NSMutableArray *imagesURLArray = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSDictionary *imagesDict in instancesDict[@"images"]) {
                        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL ,imagesDict[@"dataURL"]];
                        [imagesURLArray addObject:imageUrl];
                    }
                    instancesModel.imagesURLArray = imagesURLArray;
                }
                
                [instancesArray addObject:instancesModel];
                
                //订单名称
                if (commodityName.length == 0) {
                    commodityName = [NSString stringWithFormat:@"%@",instancesModel.name];
                }else {
                    commodityName = [NSString stringWithFormat:@"%@+%@",commodityName,instancesModel.name];
                }
                
            }
            
            orderModel.commodityName = commodityName;
            orderModel.instancesArray = instancesArray;
            
            [self.dataArray addObject:orderModel];
            
        }
        
        [_tableView reloadData];
        
        [hud hideAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error：%@",error);
        hud.label.text = @"网络出错";
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:1.2];
        
    }];
   */ 
}



@end
