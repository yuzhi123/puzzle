//
//  RegisterVC.m
//  Puzzle
//
//  Created by 王武 on 2017/9/11.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (nonatomic,strong)WWUI* WWObj;
@property (nonatomic,strong)UITextField* phoneTF;
@property (nonatomic,strong)UITextField* authCodeTF;// 验证码
@property (nonatomic,strong)UITextField* passwordTF;
@property (nonatomic,strong)UILabel* tipLabel;
@property (nonatomic,strong)UIButton* registerBt;
@property (nonatomic,strong)UIButton* authCodeBT;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255 green:241.0/255 blue:242.0/255 alpha:1.0];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    loadNav* nav = (loadNav*)self.navigationController;
    [nav setBarTinColor:[UIColor whiteColor] withtitleFont:17 andNavIsHidden:NO andtitle:@"找回密码" andTitleColor:[UIColor blackColor]];
    self.navigationItem.title = @"注册";
    [self creatUI];
}

-(void)creatUI{
    
    
    // 手机号
    UILabel* phoneLable = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:0 font:[UIFont systemFontOfSize:15] textColor:LABELCOLOR text:@"输入手机号"];
    [self.view addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_offset(110);
        make.height.mas_offset(50);
        make.left.mas_offset((WIDE-300)/2.0);
        make.top.mas_offset(55);
    }];
    
    _WWObj = [[WWUI alloc]init];
    _phoneTF = [_WWObj creatTextField:CGRectZero andBorderStyle:UITextBorderStyleNone andDelegate:_WWObj andKeyBord:UIKeyboardTypeNumberPad andNormalFont:15 andNorfontColor:[UIColor lightGrayColor] andPlaceColor:[UIColor lightGrayColor] andPlaceFont:15 andplaceHoder:@"11位有效号码" andMaxNumberWord:11];
    [self.view addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(190);
        make.left.mas_equalTo(phoneLable.mas_right);
        make.height.mas_equalTo(phoneLable);
        make.centerY.mas_equalTo(phoneLable);
    }];
    
    UIView* phoneLineView = [[UIView alloc]init];
    phoneLineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:phoneLineView];
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_phoneTF.mas_bottom);
    }];
    
 
    // 输入登录密码
    UILabel* passwordLable = [WWUI creatLabel:CGRectZero backGroundColor:[UIColor clearColor] textAligment:0 font:[UIFont systemFontOfSize:15] textColor:kUIColorFromRGB(0x2a2a2a) text:@"输入登录密码"];
    [self.view addSubview:passwordLable];
    [passwordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(110);
        make.height.mas_offset(50);
        make.left.mas_offset((WIDE-300)/2.0);
        make.top.mas_equalTo(_phoneTF.mas_bottom).offset(10);
    }];
    
    _passwordTF = [_WWObj creatTextField:CGRectZero andBorderStyle:UITextBorderStyleNone andDelegate:_WWObj andKeyBord:UIKeyboardTypeNumberPad andNormalFont:15 andNorfontColor:[UIColor lightGrayColor] andPlaceColor:[UIColor lightGrayColor] andPlaceFont:15 andplaceHoder:@"8到16位有效密码" andMaxNumberWord:16];
    [self.view addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(190);
        make.left.mas_equalTo(passwordLable.mas_right);
        make.height.mas_equalTo(passwordLable);
        make.centerY.mas_equalTo(passwordLable);
    }];
    
    UIView* passwordLineView = [[UIView alloc]init];
    [self.view addSubview:passwordLineView];
    passwordLineView.backgroundColor = [UIColor lightGrayColor];
    [passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_passwordTF.mas_bottom);
    }];
    
    //验证码
    UILabel* autoCodeLabel = [WWUI creatLabel:CGRectZero backGroundColor:[UIColor clearColor] textAligment:0 font:[UIFont systemFontOfSize:15] textColor:LABELCOLOR text:@"输入验证码"];
    [self.view addSubview:autoCodeLabel];
    [autoCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(110);
        make.height.mas_offset(50);
        make.left.mas_offset((WIDE-300)/2.0);
        make.top.mas_equalTo(_passwordTF.mas_bottom).offset(20);
    }];
    
    _authCodeTF = [_WWObj creatTextField:CGRectZero andBorderStyle:UITextBorderStyleNone andDelegate:_WWObj andKeyBord:UIKeyboardTypePhonePad andNormalFont:15 andNorfontColor:[UIColor lightGrayColor] andPlaceColor:[UIColor lightGrayColor] andPlaceFont:15 andplaceHoder:@"6位验证码" andMaxNumberWord:6];
    [self.view addSubview:_authCodeTF];
    [_authCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(autoCodeLabel.mas_right);
        make.centerY.mas_equalTo(autoCodeLabel);
        make.height.mas_equalTo(autoCodeLabel);
        make.width.mas_offset(300-110-rate(95));
    }];
    
    _authCodeBT = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(getAuthCode) titleColor:[UIColor colorWithRed:212.0/255 green:184.0/255 blue:118.0/255 alpha:1.0] font:[UIFont systemFontOfSize:15] image:nil backGroundImage:nil title:@"发送验证码"];
    _authCodeBT.layer.borderWidth = 1;
    _authCodeBT.layer.borderColor = [UIColor colorWithRed:212.0/255 green:184.0/255 blue:118.0/255 alpha:1.0].CGColor;
    _authCodeBT.layer.cornerRadius = 15;
    _authCodeBT.layer.masksToBounds = YES;
    [self.view addSubview:_authCodeBT];
    [_authCodeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rate(95));
        make.left.mas_equalTo(_authCodeTF.mas_right);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(_authCodeTF);
    }];
    
    UIView* authCodeView = [[UIView alloc]init];
    authCodeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:authCodeView];
    [authCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.mas_equalTo(300);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(autoCodeLabel.mas_bottom);
    }];
    
    _tipLabel = [WWUI creatLabel:CGRectZero backGroundColor:[UIColor clearColor] textAligment:0 font:[UIFont systemFontOfSize:15] textColor:[UIColor  lightGrayColor] text:@"0.0"];
    [self.view addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.left.mas_equalTo(autoCodeLabel.mas_left);
        make.height.mas_equalTo(rate(32));
        make.top.mas_equalTo(authCodeView.mas_bottom);
    }];
    
    _registerBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(regiseterAction) titleColor:[UIColor colorWithRed:212.0/255 green:184.0/255 blue:118.0/255 alpha:1.0] font:[UIFont systemFontOfSize:17] image:nil backGroundImage:nil title:@"注   册"];
    [self.view addSubview:_registerBt];
    _registerBt.layer.cornerRadius = 25;
    _registerBt.layer.masksToBounds = YES;
    _registerBt.layer.borderColor = [UIColor colorWithRed:212.0/255 green:184.0/255 blue:118.0/255 alpha:1.0].CGColor;
    _registerBt.layer.borderWidth = 1;
    [_registerBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(autoCodeLabel.mas_bottom).offset(rate(100));
    }];
}


//获取验证码
-(void)getAuthCode{
    
}

// 注册
-(void)regiseterAction{
    
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
