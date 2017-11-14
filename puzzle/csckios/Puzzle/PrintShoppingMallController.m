//
//  PrintShoppingMallController.m
//  Puzzle
//
//  Created by yiliu on 16/9/8.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "PrintShoppingMallController.h"
#import "PrintShoppingCell.h"
#import "CouponController.h"
#import "OrderController.h"
#import "PrintController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

#import "UIImage+ImageEffects.h"
#import "iCarousel.h"
#import "UIView+Extension.h"

#import "switchView.h"


#define IMAGE_SCALE 1.35

@interface PrintShoppingMallController ()<iCarouselDataSource,iCarouselDelegate>{
    NSArray *commodityArray;
}

//@property (strong, nonatomic) IBOutlet UIScrollView *print_scrollview;

@property(nonatomic,strong) iCarousel* iCarousel;

@property(nonatomic,strong) NSMutableArray* dataList;

@property(nonatomic,strong) NSMutableArray* viewDataArray;

@property (nonatomic,strong) NetWork* net;

@end

@implementation PrintShoppingMallController

#pragma  mark -- property
-(NetWork*)net{
    if (!_net) {
        _net = [[NetWork alloc]init];
    }
    return _net;
}

-(NSMutableArray*)viewDataArray
{
    if (!_viewDataArray) {
        _viewDataArray = [NSMutableArray array];
        
        
    }
    return _viewDataArray;
}


#pragma mark -- viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
   self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
    switchView* switchView1 = [[switchView alloc]initWithViewArray:self.viewDataArray andViewFrame:CGRectMake((WIDE-rate(270))/2.0, (HIGH - 49 - rate(368))/2.0, rate(270), rate(368)) andbackView:nil];
    
    [self.view addSubview:switchView1];
    
   // [self setUpViews];
    //[self getImageArrays];
    
}

-(NSMutableArray*)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc]init];
        
        [_dataList addObject:@"photoSize_5.png"];
        [_dataList addObject:@"photoSize_6.png"];
        [_dataList addObject:@"photoSize_7.png"];
        
    }
    return _dataList;
}

-(void)setUpViews
{
    [self.view addSubview:self.iCarousel];
    [self loadData];
}


-(void)loadData{
    
    for (int i = 0; i<self.dataList.count; i++) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rate(270)*IMAGE_SCALE, rate(368)*IMAGE_SCALE)];
        UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height)];
        imageV.image = [UIImage imageNamed:self.dataList[i]];
        imageV.tag = i;
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)];
        [imageV addGestureRecognizer:singleTap];

        [view addSubview:imageV];
        [self.viewDataArray addObject:view];
    }
    
    
}


//三张图片的点击事件 点击跳转到冲印页面
-(void)clickCategory:(UITapGestureRecognizer* )gestureRecognizer
{
    NSInteger tag = gestureRecognizer.view.tag;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PrintController *print = [storyboard instantiateViewControllerWithIdentifier:@"Print"];
    print.type = [NSString stringWithFormat:@"%tu",tag];
    print.commodityDict = commodityArray[tag];
    [self.navigationController pushViewController:print animated:YES];
}


//我的订单
- (IBAction)myOrderView:(id)sender {

    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    OrderController *order = [storyboard instantiateViewControllerWithIdentifier:@"Order"];
    order.commodityArray = commodityArray;
    [self.navigationController pushViewController:order animated:YES];

}

//网络请求
- (void)getImageArrays {
    /*
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
     */
    //NSString *url = [NSString stringWithFormat:@"%@commodity/allCommodityInfo",POSTURL];
    /*
    [self.net loadPost:@"commodity/allCommodityInfo" andParameter:nil withToken:NO block:^(NSDictionary *dataDic) {
         [hud hideAnimated:YES];
    }];
  */
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hideAnimated:YES];
        
        commodityArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
 
        [self initViews];
        NSLog(@"commodityArray：%@",commodityArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"error：%@",error);
        hud.label.text = @"网络出错";
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:1.2];
        
    }];
*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
