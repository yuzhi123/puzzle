//
//  PZPersonCenterVC.m
//  Puzzle
//
//  Created by 孙鲜艳 on 2017/4/10.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "PZPersonCenterVC.h"
#import "personTableView.h"
#import "UILabel+ExtraWidth.h"
#import "WWSpaceLabel.h"
#import "UserSetingVC.h"


@interface PZPersonCenterVC ()

@property (nonatomic,strong) personTableView* personView;

@property (nonatomic,strong) UIButton* setBt;


@end

@implementation PZPersonCenterVC



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title= @"我的小窝";
    
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:USER_NAME_COLOR}];
    
       UIBarButtonItem* backitem = [[UIBarButtonItem alloc]init];
    backitem.title = @"";
    
    self.navigationItem.backBarButtonItem = backitem;
 
    _personView = [[personTableView alloc]initWithFrame:CGRectMake(0, 0, WIDE, HIGH)];
    _personView.backgroundColor = USER_BACK_COLOR;
    [self.view addSubview:_personView];
    
    _setBt = [WWUI creatButton:CGRectZero targ:self sel:@selector(enterSet) titleColor:nil font:nil image:@"user_set" backGroundImage:nil title:nil];
    [self.view addSubview:_setBt];
    [_setBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.top.mas_equalTo(self.view.mas_top).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-rate(10));
    }];

    
}



#pragma mark -- action
//进入设置
-(void)enterSet{
    UserSetingVC* vc = [[UserSetingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
