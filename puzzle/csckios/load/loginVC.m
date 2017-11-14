//
//  loginVC.m
//  Puzzle
//
//  Created by 王武 on 2017/9/11.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "loginVC.h"
#import "loadNav.h"
#import "textFiedView.h"
#import "FindPasswordVC.h"
#import "RegisterVC.h"

@interface loginVC ()

@property (nonatomic,strong) UIImageView* backImageV;
@property (nonatomic,strong) UIImageView* logoImageV;
@property (nonatomic,strong) UITextField* PhoenTF;
@property (nonatomic,strong) UITextField* passwordTF;
@property (nonatomic,strong) UIButton* loadBt;
@property (nonatomic,strong) UIButton* forgetBt;
@property (nonatomic,strong) UIButton* registerBT;
@property (nonatomic,strong) UIButton* weiChatBt;
@property (nonatomic,strong) UIButton* QQBT;
@property (nonatomic,strong) UIButton* sinaBt;
@property (nonatomic,strong) WWUI* WWObj;





@end

@implementation loginVC

-(void)viewWillAppear:(BOOL)animated{
    
        self.navigationController.navigationBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    loadNav* nav = (loadNav*) self.navigationController;
    [nav setBarTinColor:nil withtitleFont:17 andNavIsHidden:YES andtitle:@"" andTitleColor:[UIColor whiteColor]];
    UIBarButtonItem* backitem = [[UIBarButtonItem alloc]init];
    backitem.title = @"";
    // 隐藏导航栏的额线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
     self.navigationItem.backBarButtonItem = backitem;
    [self creatUI];
}

-(void)creatUI{
    //back
    _backImageV = [WWUI creatImageView:self.view.frame backGroundImageV:@"login_bg"];
    [self.view addSubview:_backImageV];
    //logo
    _logoImageV = [WWUI creatImageView:CGRectZero backGroundImageV:@"login_logo"];
    [self.view addSubview:_logoImageV];
    [_logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(81.5, 51.5));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(rate(70));
    }];

    
    _WWObj= [[WWUI alloc]init];
   _PhoenTF = [_WWObj creatTextField:CGRectZero andBorderStyle:UITextBorderStyleNone andDelegate:_WWObj andKeyBord:UIKeyboardTypeNumberPad andNormalFont:17 andNorfontColor:[UIColor whiteColor] andPlaceColor:[UIColor whiteColor] andPlaceFont:17 andplaceHoder:@"请输入手机号" andMaxNumberWord:11];
    [self.view addSubview:_PhoenTF];
    [_PhoenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(rate(300));
        make.top.mas_equalTo(_logoImageV.mas_bottom).offset(rate(75));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIView* phonelineView = [[UIView alloc]init];
    phonelineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:phonelineView];
    [phonelineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_PhoenTF.mas_bottom);
        make.width.mas_equalTo(_PhoenTF);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(_PhoenTF);
    }];
    
    
    _passwordTF = [_WWObj creatTextField:CGRectZero andBorderStyle:UITextBorderStyleNone andDelegate:_WWObj andKeyBord:UIKeyboardTypeDefault andNormalFont:17 andNorfontColor:[UIColor whiteColor] andPlaceColor:[UIColor whiteColor] andPlaceFont:17 andplaceHoder:@"请输入密码" andMaxNumberWord:8];
    [self.view addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_PhoenTF.mas_bottom).offset(rate(25));
        make.width.mas_equalTo(phonelineView);
        make.height.mas_equalTo(_PhoenTF);
        make.centerX.mas_equalTo(_PhoenTF);
    }];
    
    
    UIView* passWordLineView = [[UIView alloc]init];
    passWordLineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:passWordLineView];
    [passWordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passwordTF.mas_bottom);
        make.width.mas_equalTo(phonelineView);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(phonelineView);
    }];
    
    // 登录按钮
    _loadBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(loadAction) titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:22] image:nil backGroundImage:nil title:@"登  录"];
    _loadBt.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    _loadBt.layer.cornerRadius = rate(25);
    _loadBt.layer.masksToBounds = YES;
    _loadBt.layer.borderWidth = 1;
    _loadBt.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:_loadBt];
    [_loadBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_PhoenTF);
        make.width.mas_equalTo(_PhoenTF);
        make.height.mas_equalTo(rate(50));
        make.top.mas_equalTo(_passwordTF.mas_bottom).offset(rate(50));
    }];
    
    
    _forgetBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(forgetAction) titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] image:nil backGroundImage:nil title:@"忘记密码"];
    [self.view addSubview:_forgetBt];
    [_forgetBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_loadBt.mas_left);
        make.top.mas_equalTo(_loadBt.mas_bottom).offset(rate(15));
        make.height.mas_equalTo(rate(25));
    }];
    
    
    _registerBT = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(registerAction) titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] image:nil backGroundImage:nil title:@"没有账号？立即注册"];
    [self.view addSubview:_registerBT];
    [_registerBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_loadBt.mas_right);
        make.centerY.mas_equalTo(_forgetBt);
        make.height.mas_equalTo(_forgetBt);
    }];
    
    _weiChatBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(otherLoad:) titleColor:nil font:nil image:@"wechat" backGroundImage:nil title:nil];
    [self.view addSubview:_weiChatBt];
    _weiChatBt.tag = 340;
    [_weiChatBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(28.5);
        make.bottom.mas_equalTo(rate(-27));
        make.left.mas_equalTo(rate(80));
    }];
    
    _sinaBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(otherLoad:) titleColor:nil font:nil image:@"weibo" backGroundImage:nil title:nil];
    [self.view addSubview:_sinaBt];
    _sinaBt.tag = 341;
    [_sinaBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(27.5);
        make.centerY.mas_equalTo(_weiChatBt);
        make.right.mas_equalTo(self.view.mas_right).offset(rate(-80));
    }];
    
    _QQBT = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(otherLoad:) titleColor:nil font:nil image:@"qq" backGroundImage:nil title:nil];
    [self.view addSubview:_QQBT];
    _QQBT.tag = 342;
    [_QQBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(24.5);
        make.height.mas_equalTo(28);
        make.centerY.mas_equalTo(_weiChatBt);
        make.centerX.mas_equalTo(_loadBt);
    }];
    
    UILabel* thirdLoadLabel = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:1 font:[UIFont systemFontOfSize:17] textColor:[UIColor whiteColor] text:@"第三方账号登录"];
    [self.view addSubview:thirdLoadLabel];
    [thirdLoadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(_weiChatBt.mas_top).offset(rate(-20));
        make.centerX.mas_equalTo(_loadBt);
    }];
    
    UIView* leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.centerY.mas_equalTo(thirdLoadLabel);
        make.right.mas_equalTo(thirdLoadLabel.mas_left).offset(-8);
        make.height.mas_equalTo(1);
    }];
    
    UIView* rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.centerY.mas_equalTo(thirdLoadLabel);
        make.left.mas_equalTo(thirdLoadLabel.mas_right).offset(8);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Action
// 登录
-(void)loadAction{
    
}

//忘记密码
-(void)forgetAction{
    FindPasswordVC* vc = [[FindPasswordVC alloc]init];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController: vc animated:YES];
}


//注册
-(void)registerAction{
    
    RegisterVC* vc = [[RegisterVC alloc]init];
 
    [self.navigationController pushViewController:vc animated:YES];
 
}

//三方登录
-(void)otherLoad:(UIButton*)bt{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
