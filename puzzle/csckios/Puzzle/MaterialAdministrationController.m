//
//  MaterialAdministrationController.m
//  Puzzle
//
//  Created by yiliu on 16/9/29.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialAdministrationController.h"
#import "MaterialTypeCell.h"
#import "TemplateOperation.h"
#import "MaterialListAdministrationController.h"
#import "TemplateTypeData.h"
#import "TemplateTermModel.h"
#import "UIImageView+WebCache.h"

@interface MaterialAdministrationController ()<UITableViewDataSource,UITableViewDelegate,MaterialListAdministrationDelegate>{

    NSInteger selectIndex;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation MaterialAdministrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectDatas];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

//查询数据
- (void)selectDatas {
    
    TemplateTypeData *templateTypeData = [TemplateTypeData CreateTemplateTypeData];
    
    TemplateOperation *templateOperation = [[TemplateOperation alloc] init];
    
    for (TemplateTermModel *templateTermModel in templateTypeData.templateTerms) {
        
        NSArray *aryQX = [templateOperation selectTemplateTermsData:templateTermModel.termName];
        
        NSDictionary *dictQX = @{@"type":templateTermModel.termName,@"data":aryQX,@"typeImageUrl":templateTermModel.termImageUrl};
        
        [self.dataArray addObject:dictQX];
        
    }
    
}

#pragma -mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

////设置分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//设置分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdetify = @"MaterialTypeCell";
    MaterialTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[MaterialTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.lockView.hidden = YES;
    }
    
    if (indexPath.row % 2 == 0) {
        cell.bkView.hidden = NO;
    }else {
        cell.bkView.hidden = YES;
    }
    
    NSDictionary *dict = _dataArray[indexPath.row];
    NSString *typeImageUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,dict[@"typeImageUrl"]];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@(%tu)",dict[@"type"],[dict[@"data"] count]];
    [cell.bkImageView sd_setImageWithURL:[NSURL URLWithString:typeImageUrl] placeholderImage:PlaceholderImage];
    [cell.materialImageView sd_setImageWithURL:[NSURL URLWithString:typeImageUrl] placeholderImage:PlaceholderImage];
    
    return cell;
    
}

#pragma -mark  选中cell后，cell颜色变化
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _dataArray[indexPath.row];
    selectIndex = indexPath.row;
    
    if ([dict[@"data"] count] == 0) {
        return;
    }
    
    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    MaterialListAdministrationController *materialDetails = [storyboard instantiateViewControllerWithIdentifier:@"MaterialListAdministration"];
    materialDetails.delegate = self;
    materialDetails.type = dict[@"type"];
    materialDetails.dataArray = dict[@"data"];
    [self.navigationController pushViewController:materialDetails animated:YES];
    
}

#pragma -mark MaterialListAdministrationDelegate 删除了模板 刷新数据
- (void)deleteTemplate:(NSInteger)deleteNum {
    
    TemplateTypeData *templateTypeData = [TemplateTypeData CreateTemplateTypeData];
    
    TemplateOperation *templateOperation = [[TemplateOperation alloc] init];
    
    TemplateTermModel *templateTermModel = templateTypeData.templateTerms[selectIndex];
    
    NSArray *aryQX = [templateOperation selectTemplateTermsData:templateTermModel.termName];
    
    NSDictionary *dictQX = @{@"type":templateTermModel.termName,@"data":aryQX,@"typeImageUrl":templateTermModel.termImageUrl};
    
    [self.dataArray removeObjectAtIndex:selectIndex];
    [self.dataArray insertObject:dictQX atIndex:selectIndex];
    
    [_tableView reloadData];
    
}

/*修改当前页面状态栏为白色*/
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
}


@end
