//
//  YLFontTypeView.m
//  Puzzle
//
//  Created by yiliu on 16/9/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLFontTypeView.h"
#import "YLFonttypeCell.h"

@interface YLFontTypeView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger selectIndex;

@end


@implementation YLFontTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _selectIndex = 2;
        
        [self loadView];
        
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

- (void)loadView {
    
    NSDictionary *dict = @{@"name":@"华文行楷",@"FonttypeName":@"STXingkai"};
    NSDictionary *dict0 = @{@"name":@"方正新综艺简体",@"FonttypeName":@"FZXZYJW--GB1-0"};
    NSDictionary *dict9 = @{@"name":@"Arial",@"FonttypeName":@"Arial"};
    NSDictionary *dict1 = @{@"name":@"CourierNewPSMT",@"FonttypeName":@"CourierNewPSMT"};
    NSDictionary *dict2 = @{@"name":@"GillSans-ltalic",@"FonttypeName":@"GillSans-ltalic"};
    NSDictionary *dict3 = @{@"name":@"MarkerFelt-Thin",@"FonttypeName":@"MarkerFelt-Thin"};
    NSDictionary *dict4 = @{@"name":@"MarkerFelt-Wide",@"FonttypeName":@"MarkerFelt-Wide"};
    NSDictionary *dict5 = @{@"name":@"AvenirNextCondensed-UltraLight",@"FonttypeName":@"AvenirNextCondensed-UltraLight"};
    NSDictionary *dict6 = @{@"name":@"Georgia-Bold",@"FonttypeName":@"Georgia-Bold"};
    NSDictionary *dict7 = @{@"name":@"AppleColorEmoji",@"FonttypeName":@"AppleColorEmoji"};
    NSDictionary *dict8 = @{@"name":@"Chalkduster",@"FonttypeName":@"Chalkduster"};
    
    self.dataArray = @[dict,dict0,dict9,dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8];
    
    [self addSubview:self.tableView];
    
}

#pragma -mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdetify = @"YLFonttypeCell";
    YLFonttypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[YLFonttypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    if (_selectIndex == indexPath.row) {
        cell.ylImageView.image = [UIImage imageNamed:@"xiaogou"];
    }else {
        cell.ylImageView.image = nil;
    }
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    NSString *typeface = dict[@"name"];
    
    cell.ylTextLabel.font = [UIFont fontWithName:typeface size:17];
    cell.ylTextLabel.text = typeface;
    
    return cell;
}

#pragma -mark  选中cell后，cell颜色变化
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectIndex = indexPath.row;
    
    [tableView reloadData];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    if([self.delegate respondsToSelector:@selector(ylFontTypeViewSwitchTypeface:)]){
        [self.delegate ylFontTypeViewSwitchTypeface:dict[@"FonttypeName"]];
    }
    
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = RGBACOLOR(200, 200, 200, 0.3);
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    return _tableView;
}

@end
