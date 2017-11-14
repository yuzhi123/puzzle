//
//  TemplateListView.m
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TemplateListView.h"
#import "TemplateCell.h"
#import "UIImageView+WebCache.h"
#import "TemplateModel.h"

@interface TemplateListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation TemplateListView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self addSubview:self.tableView];
        
        _selectIndex = 0;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self addSubview:self.tableView];
        
        _selectIndex = 0;
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    [_tableView reloadData];
    
}

#pragma -mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

#pragma -mark 设置分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 82)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

#pragma -mark 设置分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 82)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"TemplateCell";
    TemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[TemplateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TemplateModel *templateModel = _dataArray[indexPath.row];
    [cell.templateImageView  sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
    
    if (_selectIndex == indexPath.row) {
        
        [cell selectTemplate];
        
    }else {
    
        [cell cancelSelectTemplate];
    
    }
    
    return cell;
    
}

#pragma -mark  选中cell后，cell颜色变化
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(choiceContent:)]){
        [self.delegate choiceContent:indexPath.row];
    }
    _selectIndex = indexPath.row;
    [_tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.width) style:UITableViewStylePlain];
        _tableView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _tableView.pagingEnabled = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
