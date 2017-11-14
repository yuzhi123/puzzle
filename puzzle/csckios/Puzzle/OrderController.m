//
//  OrderController.m
//  Puzzle
//
//  Created by yiliu on 16/9/9.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "OrderController.h"
#import "OrderCell.h"
#import "AddressController.h"
#import "OrderInquiryController.h"

@interface OrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation OrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = @[@"我的订单",@"管理收货地址"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    
}

//返回
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//分组头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"OrderCell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _array[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        OrderInquiryController *orderInquiry = [storyboard instantiateViewControllerWithIdentifier:@"OrderInquiry"];
        orderInquiry.commodityArray = _commodityArray;
        [self.navigationController pushViewController:orderInquiry animated:YES];
        
    }else if (indexPath.section == 1) {
    
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        AddressController *address = [storyboard instantiateViewControllerWithIdentifier:@"AddressController"];
        [self.navigationController pushViewController:address animated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
