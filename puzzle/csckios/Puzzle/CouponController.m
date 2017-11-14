//
//  CouponController.m
//  Puzzle
//
//  Created by yiliu on 16/9/12.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "CouponController.h"
#import "CouponCell.h"

@interface CouponController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *preferentialCodeField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation CouponController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.dataArray addObject:@"1"];
    [self.dataArray addObject:@"2"];
    [self.dataArray addObject:@"3"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

//返回
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//兑换
- (IBAction)exchange:(id)sender {
}

#pragma -mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"CouponCell";
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.numLabel.text = @"";
//    cell.explainLabel.text = @"";
//    cell.explain0Label.text = @"";
//    cell.explain1Label.text = @"";
//    cell.explain2Label.text = @"";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(choiceCouponDict:)]){
        [self.delegate choiceCouponDict:self.dataArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
