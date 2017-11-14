//
//  ReleaseOrderController.m
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "ReleaseOrderController.h"
#import "OrderOneCell.h"
#import "OrderTwoCell.h"
#import "OrderThreeCell.h"
#import "OrderFourCell.h"
#import "Auxiliary.h"
#import "YLPictureBrowserView.h"
#import "YLBrowserView.h"
#import "AddressController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"

#import <CoreLocation/CoreLocation.h>

//微信支付
#import "WXApi.h"
#import "payRequsestHandler.h"

@interface ReleaseOrderController ()<UITableViewDelegate,UITableViewDataSource,YLPictureBrowserDelegate,AddressDelegate,WXApiDelegate, CLLocationManagerDelegate> {

    YLPictureBrowserView *ylPictureBrowser;
    
    float photoPrice;  //照片单价
    
    float albumPrice;  //相册价格
    BOOL  selectLH;    //选择相册
    
    float imagePrice;  //小计
    float allPrice;    //总计
    float freight;     //运费
    
    NSDictionary *addressDict;
    
    MBProgressHUD *hud;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//运费
@property (weak, nonatomic) IBOutlet UILabel *yunfeiLabel;
//合计
@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;

//位置
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ReleaseOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiChatPay:) name:@"WeiChatPay" object:nil]; //微信支付回调
    
    [self setLocationManager];
    
    //收货地址
    addressDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReceiptAddress"];
    
    if (_commodityDict[@"belong"]) {
        albumPrice = [_commodityDict[@"belong"][0][@"unitPrice"] floatValue];
    }
    
    photoPrice = [_commodityDict[@"unitPrice"] floatValue];
    imagePrice = 0;
    allPrice = 0;
    freight = 8;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self calculationTotal];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_locationManager stopUpdatingLocation];
}

-(void) setLocationManager
{
    if (_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate=self;
        
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_locationManager requestAlwaysAuthorization];
            //_locationManager.allowsBackgroundLocationUpdates = YES;
        }
        //每隔多少米定位一次（这里的设置为任何的移动）
        _locationManager.distanceFilter=kCLDistanceFilterNone;
        
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        _locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        
        [_locationManager startMonitoringSignificantLocationChanges];
    }
}

#pragma mark - CLLocationManagerDelegate  -

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置
    CLLocation *loc = [locations firstObject];
    
    //纬度：loc.coordinate.latitude 经度：loc.coordinate.longitude
    NSLog(@"纬度=%f，经度=%f",loc.coordinate.latitude,loc.coordinate.longitude);
    
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获得的所有信息
            NSLog(@"placemark = %@", placemark.name);
            //获取城市
            NSString *province = placemark.administrativeArea;
            NSString *city = placemark.locality;
            NSString *district = placemark.subLocality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
                district = placemark.subAdministrativeArea;
            }
            NSLog(@"city = %@ , distruct = %@", city, district);
            
            NSDictionary *addressDict1 = @{@"province":province,
                                          @"city":city,
                                          @"quyu":district,
                                          @"address":placemark.name};
            
            //保存收货地址
            [[NSUserDefaults standardUserDefaults] setObject:addressDict1 forKey:@"ReceiptAddress"];
            
            [self choiceAddress];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    
    //停止更新位置（如果定位服务不需要实时更新的话，那么应该停止位置的更新）
    [_locationManager stopUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorMsg = nil;
    if ([error code] == kCLErrorDenied) {
        errorMsg = @"访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        errorMsg = @"获取位置信息失败";
    }
    
    NSLog(@"location error:%@", errorMsg);
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//分组头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

//分组尾高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([_type isEqual:@"1"] && section == 2) {
        return 0.000000001;
    }
    return 10;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        return 200;
        
//    }else if (indexPath.section == 2) {
//        
//        if ([_type isEqual:@"1"]) {
//            
//            return 0.00000001;
//            
//        }
//        
//        return 120;
//        
    }
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *reuseIdetify = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"zuobiao"];
        cell.textLabel.text = @"请填写你的收货地址";
        
        if (addressDict) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addressDict[@"province"],addressDict[@"city"],addressDict[@"quyu"],addressDict[@"address"]];
        }
        
        return cell;
        
    }if (indexPath.section == 1) {
        
        static NSString *reuseIdetify = @"OrderOneCell";
        OrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.spPreviewBtn addTarget:self action:@selector(previewSP:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.spNameLabel.text = _commodityDict[@"name"];
        cell.spUnitPriceLabel.text = [NSString stringWithFormat:@"%.2f元/张",photoPrice];
        cell.spSZNumLabel.text = [NSString stringWithFormat:@"%tu",_imagesArray.count];
        cell.spDiscountNumLabel.text = @"无";
        cell.spNumberLabel.text = [NSString stringWithFormat:@"%.2fx%tu张",photoPrice,_imagesArray.count];
        cell.spAllPriceLabel.text = [NSString stringWithFormat:@"%.2f元",imagePrice];
        
        NSString *url = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,_commodityDict[@"examplePictures"][0][@"dataURL"]];
        [cell.spImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        cell.spImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.spImageView.clipsToBounds = YES;
        
        return cell;
        
//    }else if (indexPath.section == 2) {
//        
//        static NSString *reuseIdetify = @"OrderTwoCell";
//        OrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell.lhXZBtn addTarget:self action:@selector(xzLH:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lhPreview:)];
//        [cell.lhImageView addGestureRecognizer:tap];
//        
//        //原价
//        cell.lhOriginalPriceLabel.text = @"";
//        //相册名称
//        cell.lhNameTLabel.text = _commodityDict[@"belong"][0][@"name"];
//        //现价
//        cell.lhPriceLabel.text = [NSString stringWithFormat:@"%.2f元",albumPrice];
//        
//        //相册示例图
//        NSArray *belongArray = _commodityDict[@"belong"];
//        if (belongArray) {
//            
//            NSDictionary *youhuiDict = belongArray[0];
//            NSString *biurl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,youhuiDict[@"examplePictures"][0][@"dataURL"]];
//            [cell.lhImageView sd_setImageWithURL:[NSURL URLWithString:biurl]];
//            
//            cell.lhImageView.contentMode = UIViewContentModeScaleAspectFill;
//            cell.lhImageView.clipsToBounds = YES;
//            
//        }
//        return cell;
        
    }else if (indexPath.section == 2) {
    
        static NSString *reuseIdetify = @"OrderThreeCell";
        OrderThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else {
    
        static NSString *reuseIdetify = @"OrderFourCell";
        OrderFourCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        AddressController *address = [storyboard instantiateViewControllerWithIdentifier:@"AddressController"];
        address.selectAddress = YES;
        address.delegate = self;
        [self.navigationController pushViewController:address animated:YES];
        
    }
    
}

#pragma -mark AddressDelegate
- (void)choiceAddress {
    
    //收货地址
    addressDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReceiptAddress"];
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

//预览
- (void)previewSP:(UIButton *)btn {
    
    self.titleLabel.text = @"照片浏览";
    
    ylPictureBrowser = [[YLPictureBrowserView alloc] initWithFrame:CGRectMake(0, 50, WIDE, HIGH-50)];
    
    ylPictureBrowser.delegate = self;
    
    /** 图片数组 */
    ylPictureBrowser.imagesArray = _imagesArray;
    
    /** 图片的边框位置 */
    ylPictureBrowser.imageBkRect = CGRectMake((ylPictureBrowser.bounds.size.width-(WIDE-130+10))/2, ylPictureBrowser.bounds.size.height/2-((2100.0/1500.0)*(WIDE-130)+55)/2-5, WIDE-130+10, (2100.0/1500.0)*(WIDE-130)+10);
    
    /** 图片的位置 */
    ylPictureBrowser.imageRect = CGRectMake((ylPictureBrowser.bounds.size.width-(WIDE-130))/2, ylPictureBrowser.bounds.size.height/2-((2100.0/1500.0)*(WIDE-130)+55)/2, WIDE-130, (2100.0/1500.0)*(WIDE-130));
    
    /** 图片张数的位置 */
    ylPictureBrowser.imageProportionRect = CGRectMake((ylPictureBrowser.bounds.size.width-(WIDE-130))/2, ylPictureBrowser.bounds.size.height/2+((275.0/200.0)*(WIDE-130)+55)/2+20, WIDE-130, 35);
    
    /** 背景颜色 */
    ylPictureBrowser.bkColor = RGBACOLOR(230, 230, 230, 1);
    
    [self.view addSubview:ylPictureBrowser];
    
}

#pragma -mark 
- (void)tapYLPictureBrowserView {
    self.titleLabel.text = @"确认订单";
    [ylPictureBrowser removeFromSuperview];
    ylPictureBrowser = nil;
}

//相册预览
- (void)lhPreview:(UITapGestureRecognizer *)tap {
    
    //相册示例图
    NSArray *belongArray = _commodityDict[@"belong"];
    NSArray *xcArray = belongArray[0][@"examplePictures"];
    NSString *xcurl0 = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,xcArray[0][@"dataURL"]];
    NSString *xcurl1 = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,xcArray[1][@"dataURL"]];
    NSString *xcurl2 = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,xcArray[2][@"dataURL"]];
    
//    UIImage *image0 = [UIImage imageNamed:@"chanping1"];
//    UIImage *image1 = [UIImage imageNamed:@"chanping2"];
//    UIImage *image2 = [UIImage imageNamed:@"chanping3"];
    
    NSString *validity0 = @"尺寸：27*20*4cm     内页：30张60面\n容量：可放30-120张照片";
    NSString *validity1 = @"高档牛皮纸硬壳封面\n精致礼盒装，自用送人必备";
    NSString *validity2 = @"为你记录生活中的每一刻";
    
    NSDictionary *dict0 = @{@"image":xcurl0,@"validity":validity0};
    NSDictionary *dict1 = @{@"image":xcurl1,@"validity":validity1};
    NSDictionary *dict2 = @{@"image":xcurl2,@"validity":validity2};
    
    NSArray *arry = @[dict0,dict1,dict2];
    
    YLBrowserView *ylBrowser = [[YLBrowserView alloc] initWithFrame:CGRectMake(0, 50, WIDE, HIGH-50)];
    
    ylBrowser.dataArray = arry;
    
    [self.view addSubview:ylBrowser];
    
}

//选择/取消 礼盒
- (void)xzLH:(UIButton *)btn {
    
    if (btn.selected) {
        btn.selected = NO;
        selectLH = NO;
        [self calculationTotal];
    }else {
        btn.selected = YES;
        selectLH = YES;
        [self calculationTotal];
    }
    _hejiLabel.text = [NSString stringWithFormat:@"%.2f",allPrice];
    
}

//返回
- (IBAction)retunView:(id)sender {
    
    if (ylPictureBrowser) {
        
        //如果是预览状态，点返回就取消预览
        [self tapYLPictureBrowserView];
        
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

//计算总价
- (void)calculationTotal {
    
    imagePrice = _imagesArray.count*photoPrice;
    
    if (selectLH) {
        allPrice = imagePrice + albumPrice;
    }else {
        allPrice = imagePrice;
    }
    
//    if (allPrice < 20) {
        allPrice += freight;
        self.yunfeiLabel.hidden = NO;
//    }else {
//        self.yunfeiLabel.hidden = YES;
//    }
    
    self.hejiLabel.text = [NSString stringWithFormat:@"%.2f元",allPrice];
    
}

//结算
- (IBAction)settlement:(id)sender {
    
    if (addressDict.count == 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"填写收货地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
    NSString *nickName = addressDict[@"name"];
    NSString *phoneNumber = addressDict[@"phoneNumber"];
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",addressDict[@"province"],addressDict[@"city"],addressDict[@"quyu"],addressDict[@"address"]];
    
    if (nickName != NULL && phoneNumber != NULL && address!=NULL) {
        //运费
        NSString *freights;
        
        //    if (allPrice < 20) {
        freights = [NSString stringWithFormat:@"%.2f",freight];
        //    }else {
        //        freights = @"0";
        //    }
        
        //    1    LOMO卡照片
        //    2    6寸高清照片
        //    4    手写DIY相册
        //    5    闪光笔x5+角贴x2
        //    6    LOMO专属定制相册
        
        //商品类型id
        NSString *commodityId;
        if ([_type isEqual:@"0"]) {
            
            commodityId = @"1";
            
        }else if ([_type isEqual:@"1"]) {
            
            commodityId = @"2";
            
        }
        
        NSMutableArray *commoditysArray = [[NSMutableArray alloc] init];
        
        NSDictionary *commoditysDict = @{@"imageIds":[_imagesIdArray JSONString],
                                         @"number":[NSString stringWithFormat:@"%tu",_imagesArray.count],
                                         @"couponId":@"",
                                         @"commodityId":commodityId};
        [commoditysArray addObject:commoditysDict];
        
        //如果选择了LOMO专属定制相册
        if (selectLH) {
            
            NSDictionary *commoditysDict = @{@"imageIds":@"",
                                             @"number":@"1",
                                             @"couponId":@"",
                                             @"commodityId":@"6"};
            [commoditysArray addObject:commoditysDict];
            
        }
        
        NSDictionary *dict = @{@"nickName":nickName,
                               @"phoneNumber":phoneNumber,
                               @"address":address,
                               @"commoditys":[commoditysArray JSONString],
                               @"freight":freights};
        
        [self POST:dict];

    }else{
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = @"请填写详细的收件人信息～";
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:0.8];
    }
    
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
    if (selectLH) {
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
    }else {
        [self alert:@"提示信息" msg:@"支付失败!"];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WeiChatPay" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
