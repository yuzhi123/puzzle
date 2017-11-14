//
//  MaterialListAdministrationController.m
//  Puzzle
//
//  Created by yiliu on 16/9/29.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialListAdministrationController.h"
#import "MaterialListAdministrationCell.h"
#import "TemplateModel.h"
#import "TemplateOperation.h"
#import "UIImageView+WebCache.h"

@interface MaterialListAdministrationController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *editView;
@property (weak, nonatomic) IBOutlet UIButton *retunBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *contengLabel;
@property (strong, nonatomic) NSMutableArray *screenArray;
@property (strong, nonatomic) NSMutableDictionary *selectDict;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableView;

@end

@implementation MaterialListAdministrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.editView];
    
    [self screenDatas];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)setType:(NSString *)type {
    
    _type = type;
    _contengLabel.text = type;
    
}

//筛选数据
- (void)screenDatas {
    
    NSMutableArray *ary0 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *ary1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *ary2 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *ary3 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *ary4 = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TemplateModel *templateModel in _dataArray) {
        
        if (templateModel.photoNum == 1) {
            
            [ary0 addObject:templateModel];
            
        }else if (templateModel.photoNum == 2) {
            
            [ary1 addObject:templateModel];
            
        }else if (templateModel.photoNum == 3) {
            
            [ary2 addObject:templateModel];
            
        }else if (templateModel.photoNum == 4) {
            
            [ary3 addObject:templateModel];
            
        }else if (templateModel.photoNum == 5) {
            
            [ary4 addObject:templateModel];
            
        }
        
    }
    
    if (ary0.count > 0) {
        [self.screenArray addObject:ary0];
    }
    if (ary1.count > 0) {
        [self.screenArray addObject:ary1];
    }
    if (ary2.count > 0) {
        [self.screenArray addObject:ary2];
    }
    if (ary3.count > 0) {
        [self.screenArray addObject:ary3];
    }
    if (ary4.count > 0) {
        [self.screenArray addObject:ary4];
    }
    
}

//编辑
- (IBAction)edit:(id)sender {
    
    if (_editBtn.selected) {
        
        [UIView animateWithDuration:0.2 animations:^{
            _editView.frame = CGRectMake(0, HIGH, WIDE, 44);
        }];
        
        _topTableView.constant = 0;
        _contengLabel.text =_type;
        _editBtn.selected = NO;
        [self.selectDict removeAllObjects];
        _retunBtn.hidden = NO;
        
    }else {
        
        [UIView animateWithDuration:0.2 animations:^{
            _editView.frame = CGRectMake(0, HIGH-44, WIDE, 44);
        }];
        
        _topTableView.constant = 44;
        _contengLabel.text = @"编辑";
        _editBtn.selected = YES;
        _retunBtn.hidden = YES;
        
    }
    
    [_tableView reloadData];
    
}

//返回
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _screenArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_screenArray[section] count] % 3 > 0 ? [_screenArray[section] count] / 3 + 1 : [_screenArray[section] count] / 3;
}

//设置分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TemplateModel *templateModel = _screenArray[section][0];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDE, 30)];
    headLabel.font = [UIFont systemFontOfSize:15];
    headLabel.textColor = [UIColor whiteColor];
    headLabel.backgroundColor = RGBACOLOR(100, 100, 100, 1);
    headLabel.text = [NSString stringWithFormat:@"  %tu张（%tu）",templateModel.photoNum,[_screenArray[section] count]];
    return headLabel;
    
}

//设置分区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

//设置分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

//设置分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (WIDE-50.0)/3/(90.0/134.0)+10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"MaterialListAdministrationCell";
    MaterialListAdministrationCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[MaterialListAdministrationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.selectOneBtn addTarget:self action:@selector(selectTemplate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.selectTwoBtn addTarget:self action:@selector(selectTemplate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.selectThreeBtn addTarget:self action:@selector(selectTemplate:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (_editBtn.selected) {
        
        cell.selectOneBtn.hidden = NO;
        cell.selectTwoBtn.hidden = NO;
        cell.selectThreeBtn.hidden = NO;
        
        cell.selectOneBtn.selected = NO;
        cell.selectTwoBtn.selected = NO;
        cell.selectThreeBtn.selected = NO;
        
        cell.selectOneBtn.backgroundColor = [UIColor clearColor];
        cell.selectTwoBtn.backgroundColor = [UIColor clearColor];
        cell.selectThreeBtn.backgroundColor = [UIColor clearColor];
        
    }else {
        
        cell.selectOneBtn.hidden = YES;
        cell.selectTwoBtn.hidden = YES;
        cell.selectThreeBtn.hidden = YES;
    
    }
    
    cell.selectOneBtn.tag = 100000*indexPath.section + indexPath.row*3;
    cell.selectTwoBtn.tag = 100000*indexPath.section + indexPath.row*3+1;
    cell.selectThreeBtn.tag = 100000*indexPath.section + indexPath.row*3+2;
    
    cell.materialImageOneView.image = nil;
    cell.materialImageTwoView.image = nil;
    cell.materialImageThreeView.image = nil;
    
    TemplateModel *templateModel;
    
    if ([_screenArray[indexPath.section] count] > indexPath.row*3) {
        
        //编辑状态
        NSString *key = [NSString stringWithFormat:@"%tu",cell.selectOneBtn.tag];
        if (_editBtn.selected) {
            
            //被选中
            if (self.selectDict[key]) {
                
                cell.selectOneBtn.selected = YES;
                cell.selectOneBtn.backgroundColor = RGBACOLOR(1, 1, 1, 0.3);
                
            }
            
        }
        
        templateModel = _screenArray[indexPath.section][indexPath.row*3];
        [cell.materialImageOneView  sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
        
    }
    if ([_screenArray[indexPath.section] count] > indexPath.row*3+1) {
        
        //编辑状态
        NSString *key = [NSString stringWithFormat:@"%tu",cell.selectTwoBtn.tag];
        if (_editBtn.selected) {
            
            //被选中
            if (self.selectDict[key]) {
                
                cell.selectTwoBtn.selected = YES;
                cell.selectTwoBtn.backgroundColor = RGBACOLOR(1, 1, 1, 0.3);
                
            }
            
        }
        
        templateModel = _screenArray[indexPath.section][indexPath.row*3+1];
        [cell.materialImageTwoView  sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
        
    }
    if ([_screenArray[indexPath.section] count] > indexPath.row*3+2) {
        
        NSString *key = [NSString stringWithFormat:@"%tu",cell.selectThreeBtn.tag];
        if (_editBtn.selected) {
            
            //被选中
            if (self.selectDict[key]) {
                
                cell.selectThreeBtn.selected = YES;
                cell.selectThreeBtn.backgroundColor = RGBACOLOR(1, 1, 1, 0.3);
                
            }
            
        }
        
        templateModel = _screenArray[indexPath.section][indexPath.row*3+2];
        [cell.materialImageThreeView  sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
        
    }
    
    return cell;
    
}

//选择
- (void)selectTemplate:(UIButton *)btn {
    
    NSInteger section = btn.tag / 100000;
    NSInteger row = btn.tag % 100000;
    
    if ([_screenArray[section] count] <= row) {
        return;
    }
    
    NSString *key = [NSString stringWithFormat:@"%tu",btn.tag];
    
    if (btn.selected) {
        
        [self.selectDict removeObjectForKey:key];
        
        btn.selected = NO;
        
        btn.backgroundColor = [UIColor clearColor];
        
    }else {
        
        [self.selectDict setObject:@"1" forKey:key];
        
        btn.selected = YES;
        
        btn.backgroundColor = RGBACOLOR(1, 1, 1, 0.3);
        
    }
    
}

//全选
- (void)selectAll:(UIButton *)btn {
    
    NSInteger num = 0;
    for (int i = 0; i < _screenArray.count; i++) {
        num += [_screenArray[i] count];
    }
    
    //已经全部选中，点击全选则全部取消选中
    if (num == self.selectDict.count) {
        
        [self.selectDict removeAllObjects];
        
    }else {
        
        //没有全部选中点击全选则全选
        for (int i = 0; i < _screenArray.count; i++) {
            
            for (int y = 0; y < [_screenArray[i] count]; y++) {
                
                NSString *key = [NSString stringWithFormat:@"%tu",100000*i + y];
                [self.selectDict setObject:@"1" forKey:key];
                
            }
            
        }
        
    }
    
    [_tableView reloadData];
    
}

//删除选中的
- (void)deleteSelectDatas:(UIButton *)btn {
    
    if (self.selectDict.count == 0) {
        return;
    }
    
    NSArray *ary = [self.selectDict allKeys];
    
    NSMutableArray *deleteArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSString *num in ary) {
        
        NSInteger section = [num integerValue] / 100000;
        NSInteger row = [num integerValue] % 100000;
        
        [deleteArray addObject:_screenArray[section][row]];
        
    }
    
    //删除数据库数据
    TemplateOperation *templateOperation = [[TemplateOperation alloc] init];
    NSInteger deleteNum = [templateOperation deleteTemplate:deleteArray];
    
    //删除了模板的代理
    [self.delegate deleteTemplate:deleteNum];
    
    for (TemplateModel *templateModel in deleteArray) {
        
        for (int i = 0; i < _screenArray.count; i++) {
            
            NSMutableArray *array = _screenArray[i];
            
            [array removeObject:templateModel];
            
            if (array.count == 0) {
                
                [_screenArray removeObject:array];
                
            }
            
        }
        
    }
    
    //删除数据刷新页面
    [self.selectDict removeAllObjects];
    
    [_tableView reloadData];
    
    //发出通知，刷新素材页面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTemplate" object:nil];
    
}

- (NSMutableArray *)screenArray {
    if (!_screenArray) {
        _screenArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _screenArray;
}

- (NSMutableDictionary *)selectDict {
    if (!_selectDict) {
        _selectDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _selectDict;
}

- (UIView *)editView {
    if (!_editView) {
        
        _editView = [[UIView alloc] initWithFrame:CGRectMake(0, HIGH, WIDE, 44)];
        _editView.backgroundColor = RGBACOLOR(40, 43, 53, 1);
        
        UIButton *selectAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDE/2, 44)];
        [selectAllBtn addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
        selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [selectAllBtn setTitle:@" 全选" forState:UIControlStateNormal];
        [selectAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectAllBtn setImage:[UIImage imageNamed:@"xiaogoubaise"] forState:UIControlStateNormal];
        [_editView addSubview:selectAllBtn];
        
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDE/2, 0, WIDE/2, 44)];
        [deleteBtn addTarget:self action:@selector(deleteSelectDatas:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleteBtn setTitle:@" 删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_editView addSubview:deleteBtn];
        
    }
    return _editView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
