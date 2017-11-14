//
//  ReleaseOrderXCController.m
//  Puzzle
//
//  Created by yiliu on 2016/10/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "ReleaseOrderXCController.h"
#import "AddressController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
//微信支付
#import "WXApi.h"
#import "payRequsestHandler.h"

@interface ReleaseOrderXCController ()<AddressDelegate,WXApiDelegate>
{

    //数量
    NSInteger xcNumber;
    
    //小计
    float xjPrice;
    
    //合计
    float allPrice;
    
    //单价
    float djPrice;
    
    //运费
    float freight;
    
    //优品搭配价格
    float ypPrice;
    
    //是否选择了优品搭配
    BOOL isSelectYP;
    
    //用户信息
    NSDictionary *addressDict;
    
    MBProgressHUD *hud;
    
}
@end

@implementation ReleaseOrderXCController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiChatPay:) name:@"WeiChatPay" object:nil]; //微信支付回调
    
    freight = 8;
    ypPrice = [_commodityDict[@"belong"][0][@"unitPrice"] floatValue];
    djPrice = [_commodityDict[@"unitPrice"] floatValue];
    xcNumber = 1;
    
    _diyImageView.contentMode = UIViewContentModeScaleAspectFill;
    _diyImageView.clipsToBounds = YES;
    
    _shanguagnbiImageView.contentMode = UIViewContentModeScaleAspectFill;
    _shanguagnbiImageView.clipsToBounds = YES;
    
    _jiaotieImageView.contentMode = UIViewContentModeScaleAspectFill;
    _jiaotieImageView.clipsToBounds = YES;
    
    //DIY相册示例图
    NSString *url = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,_commodityDict[@"examplePictures"][0][@"dataURL"]];
    [_diyImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    //优惠搭配
    NSArray *belongArray = _commodityDict[@"belong"];
    if (belongArray) {
        
        //闪光笔示例图
        NSDictionary *youhuiDict = belongArray[0];
        NSString *biurl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,youhuiDict[@"examplePictures"][0][@"dataURL"]];
        [_shanguagnbiImageView sd_setImageWithURL:[NSURL URLWithString:biurl]];
        
        //角贴示例图
        NSDictionary *tieDict = belongArray[0];
        NSString *tieurl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,tieDict[@"examplePictures"][1][@"dataURL"]];
        [_jiaotieImageView sd_setImageWithURL:[NSURL URLWithString:tieurl]];
        
        //优惠搭配名称
        _youhuidapeiNameLabel.text = [NSString stringWithFormat:@"(DIY相册伴侣(%@))",belongArray[0][@"name"]];
        
        //优惠搭配总价
        _youhuidapeiPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[belongArray[0][@"unitPrice"] floatValue]];
        
        NSArray *youhuiArray = [belongArray[0][@"name"] componentsSeparatedByString:@"+"];
        //闪光笔名称
        _shanguangbiNameLabel.text = youhuiArray[0];
        
        //角贴名称
        _jiaotieNameLabel.text = youhuiArray[1];
        
    }else {
        
        _payConstraint.constant = -142;
        _youhuidapeiView.hidden = YES;
        
    }
    
    [self calculationPrice];
    
}

//计算价格
- (void)calculationPrice {
    
    xjPrice = djPrice * xcNumber;
    allPrice = xjPrice + freight;
    if (isSelectYP) {
        allPrice += ypPrice;
    }
    
    _numberLabel.text = [NSString stringWithFormat:@"%tu",xcNumber];
    
    _priceXJLabel.text = [NSString stringWithFormat:@"%.2f元",xjPrice];
    
    _allPriceLabel.text = [NSString stringWithFormat:@"%.2f元",allPrice];
    
    //收货地址
    addressDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReceiptAddress"];
    if (addressDict) {
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addressDict[@"province"],addressDict[@"city"],addressDict[@"quyu"],addressDict[@"address"]];
    }
    
}

//填写地址
- (IBAction)addAddress:(id)sender {
    
    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    AddressController *address = [storyboard instantiateViewControllerWithIdentifier:@"AddressController"];
    address.selectAddress = YES;
    address.delegate = self;
    [self.navigationController pushViewController:address animated:YES];
    
}

#pragma -mark AddressDelegate
- (void)choiceAddress {
    
    //收货地址
    addressDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReceiptAddress"];
    if (addressDict) {
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addressDict[@"province"],addressDict[@"city"],addressDict[@"quyu"],addressDict[@"address"]];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选择和取消优惠搭配
- (IBAction)selectYH:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (isSelectYP) {
        isSelectYP = NO;
    }else {
        isSelectYP = YES;
    }
    
    btn.selected = isSelectYP;
    
    [self calculationPrice];
    
}

//减少数量
- (IBAction)reduceNumber:(id)sender {
    
    if (xcNumber > 1) {
        xcNumber--;
        [self calculationPrice];
    }
    
}

//增加数量
- (IBAction)increaseNumber:(id)sender {
    xcNumber++;
    [self calculationPrice];
}

//结算
- (IBAction)settlement:(id)sender {
    
    NSString *nickName = addressDict[@"name"];
    
    NSLog(@"nickName %@", nickName);
    
    NSString *phoneNumber = addressDict[@"phoneNumber"];
    
    NSLog(@"phoneNumber %@", phoneNumber);
    
    
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",addressDict[@"province"],addressDict[@"city"],addressDict[@"quyu"],addressDict[@"address"]];
    
    NSLog(@"address %@", address);

    
//    4    手写DIY相册
//    5    闪光笔x5+角贴x2
    
    NSMutableArray *commoditysArray = [[NSMutableArray alloc] init];
    
    NSDictionary *commoditysDict = @{@"imageIds":@"",
                                     @"number":[NSString stringWithFormat:@"%tu",xcNumber],
                                     @"couponId":@"",
                                     @"commodityId":@"4"};
    [commoditysArray addObject:commoditysDict];
    
    if (isSelectYP) {
        
        NSDictionary *commoditysDict = @{@"imageIds":@"",
                                         @"number":@"1",
                                         @"couponId":@"",
                                         @"commodityId":@"5"};
        [commoditysArray addObject:commoditysDict];
        
    }
    
    NSDictionary *dict = @{@"nickName":nickName,
                           @"phoneNumber":phoneNumber,
                           @"address":address,
                           @"commoditys":[commoditysArray JSONString],
                           @"freight":[NSString stringWithFormat:@"%.2f",freight]};
    
    [self POST:dict];
    
}

- (void)POST:(NSDictionary *)dict {
    
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager1.requestSerializer.timeoutInterval = 30;
    
    NSString *url = [NSString stringWithFormat:@"%@order/save",POSTURL];
    
    [manager1 POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hideAnimated:YES];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict);
        [self zhifu:dict[@"msg"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        hud.label.text = @"网络出错";
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:1.2];
        
    }];
    */
}

//请求支付
- (void)zhifu:(NSString *)orderId   {
    
    NSString *description;
    if (isSelectYP) {
        description = [NSString stringWithFormat:@"%@+%@",_commodityDict[@"name"],_commodityDict[@"belong"][@"name"]];
    }else {
        description = _commodityDict[@"name"];
    }
    
    NSDictionary *dict = @{@"orderId":orderId,
                           @"description":description,
                           @"sunPrice":[NSString stringWithFormat:@"%.0f",allPrice*100]};
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager1.requestSerializer.timeoutInterval = 30;
    
    [manager1 POST:@"http://112.124.2.50:8080/wx/app/pay/uniformOrder" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hideAnimated:YES];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@",dict);
        [self sendPay:dict];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        hud.label.text = @"网络出错";
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:1.2];
        
    }];
    */
}

//微信支付
- (void)sendPay:(NSDictionary *)dict
{
    if(dict != nil){
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        [WXApi sendReq:req];
    }else{
        [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
    }
}

#pragma -mark 微信支付回调
- (void)WeiChatPay:(NSNotification*)notification{
    NSString *str = [notification object];
    if([str isEqual:@"YES"]){
        [self alert:@"提示信息" msg:@"订单提交成功，请耐心等待发货!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}

- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
