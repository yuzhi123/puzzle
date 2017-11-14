//
//  UserSetingVC.m
//  Puzzle
//
//  Created by 王武 on 2017/10/25.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "UserSetingVC.h"

@interface UserSetingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;

@property (nonatomic,strong) NSArray* arrayFirst;

@property (nonatomic,strong) NSArray* arrayThrid;

@property (nonatomic,strong) UIButton* loginOutBt;

@end

@implementation UserSetingVC


-(NSArray*)arrayFirst{
    if (!_arrayFirst) {
        _arrayFirst = @[@"消息通知",@"隐私设置"];
    }
    return _arrayFirst;
}

-(NSArray*)arrayThrid{
    if (!_arrayThrid) {
        _arrayThrid = @[@"清除缓存",@"帮助",@"关于我们"];
    }
    return _arrayThrid;
}

-(UITableView*)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDE, HIGH) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces  = NO;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 隐藏导航栏的额线
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:USER_NAME_COLOR}];
    self.title = @"设置";
    self.view.backgroundColor = USER_BACK_COLOR;
    [self creatUI];
    
    
}



-(void)creatUI{
    
    [self.view addSubview:self.tableView];
    
    _loginOutBt = [WWUI creatButton:CGRectZero targ:self sel:@selector(loginOut) titleColor:USER_ORDER_COLOR font:[UIFont systemFontOfSize:17] image:nil backGroundImage:nil title:@"退出登录"] ;
    _loginOutBt.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loginOutBt];
    [_loginOutBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(48);
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-rate(225));
        make.width.mas_equalTo(rate(150));
    }];
    _loginOutBt.layer.cornerRadius = 24;
    _loginOutBt.layer.masksToBounds = YES;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.arrayFirst.count;
    }
    else if (section == 1){
        return self.arrayThrid.count;
    }
    return 0;
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = USER_ORDER_COLOR;
        if (indexPath.section == 1) {
            cell.textLabel.text = self.arrayThrid[indexPath.row];
        }
        else{
            cell.textLabel.text = self.arrayFirst[indexPath.row];
        }
 
        UIImageView* enterImageV = [WWUI creatImageView:CGRectZero backGroundImageV:@"qianjin"];
        [cell addSubview:enterImageV];
        [enterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.textLabel);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.right.mas_equalTo(cell.mas_right).offset(-8);
        }];
        
        if ( !((indexPath.section == 1 && indexPath.row == 2)  || (indexPath.section == 0 && indexPath.row == 1))) {
            UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(rate(10), 50, rate(339), 1)];
            lineView.backgroundColor = [UIColor colorWithRed:211.0/255 green:212.0/255 blue:213.0/255 alpha:1.0];;
            [cell addSubview:lineView];
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDE, 12)];
    return viewHeader;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDE, 0)];
    viewHeader.backgroundColor = [UIColor redColor];
    return viewHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

// 退出登录
-(void)loginOut{
    
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
