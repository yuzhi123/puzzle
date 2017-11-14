//
//  StorySetController.m
//  Puzzle
//
//  Created by yiliu on 2016/10/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "StorySetController.h"
#import "StorySetCell.h"

#import "YLPhotoPickerController.h"
#import "AddStorySetController.h"

@interface StorySetController ()<UITableViewDataSource,UITableViewDelegate,YLPhotoPickerDataSource>
{
    NSArray *dataArray;
}

@end

@implementation StorySetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.tableFooterView = [self addFooterView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (UIView *)addFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDE, 100)];
    
    UIButton *addStorySet = [[UIButton alloc] initWithFrame:CGRectMake(40, 30, WIDE-80, 40)];
    [addStorySet addTarget:self action:@selector(addStorySet) forControlEvents:UIControlEventTouchUpInside];
    [addStorySet setImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    [addStorySet setTitle:@"创建一个故事集" forState:UIControlStateNormal];
    [addStorySet setTitleColor:RGBACOLOR(191, 191, 191, 1) forState:UIControlStateNormal];
    addStorySet.layer.cornerRadius = 20;
    addStorySet.layer.masksToBounds = YES;
    addStorySet.layer.borderWidth = 1;
    addStorySet.layer.borderColor = RGBACOLOR(191, 191, 191, 1).CGColor;
    [footerView addSubview:addStorySet];
    
    return footerView;
    
}

//创建一个故事集
- (void)addStorySet {
    
    YLPhotoPickerController *ylPhotoPicker = [[YLPhotoPickerController alloc] init];
    ylPhotoPicker.isPrint = YES;
    ylPhotoPicker.dataSource = self;
    ylPhotoPicker.isMultiselect = YES;
    [self.navigationController pushViewController:ylPhotoPicker animated:YES];
    
}

#pragma -mark YLPhotoPickerDataSource 选择的照片
- (void)completeSelection:(NSArray *)imagesArray {
    
    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    AddStorySetController *addStorySet = [storyboard instantiateViewControllerWithIdentifier:@"AddStorySet"];
    [addStorySet.imagesArray addObjectsFromArray:imagesArray];
    [self.navigationController pushViewController:addStorySet animated:YES];
    
}

#pragma -mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdetify = @"StorySetCell";
    StorySetCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

//返回
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
