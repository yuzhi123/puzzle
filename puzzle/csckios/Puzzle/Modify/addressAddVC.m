//
//  addressAddVC.m
//  Puzzle
//
//  Created by 王飞 on 2017/11/6.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "addressAddVC.h"
#import "addressV.h"

@interface addressAddVC ()

@end

@implementation addressAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的地址";
    self.view.backgroundColor = USER_BACK_COLOR;
    [self creatUI];
}


-(void)creatUI{
    
    addressV* view = [[addressV alloc]initWithFrame:CGRectMake(0, 0, WIDE, HIGH)];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
