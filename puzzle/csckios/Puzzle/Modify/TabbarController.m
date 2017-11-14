//
//  TabbarController.m
//  Pikachu Totoro
//
//  Created by 孙鲜艳 on 2016/12/20.
//  Copyright © 2016年 sunxy. All rights reserved.
//

#import "TabbarController.h"

#import "YLPhotoPickerController.h"
#import "TemplateTypeData.h"
#import "TemplateTypeModel.h"
#import "TemplateTermModel.h"
#import "StartPageView.h"
#import "MBProgressHUD.h"
#import "TZImageManager.h"

#import "AFNetworking.h"
#import "DownBasicsTemplate.h"
#import "ObtainAdvertisement.h"
#import "AdvertisementView.h"
#import "PrintShoppingMallController.h"
#import "PZTakePhotoVC.h"
#import "PZPersonCenterVC.h"
#import "MaterialTypeListController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LBTabBar.h"

@interface TabbarController ()<UITabBarControllerDelegate, MaterialTypeListDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,LBTabBarDelegate,StartPageViewDelegate,AdvertisementDelegate>
@end

@implementation TabbarController
#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = RGBACOLOR(219, 183, 108, 1); //这里设置tabbar的选中颜色
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self post];
    [self setUpAllChildViewController];

    [self initTabbar];
    
    [self initSpliteView];
}


/**初始化闪图页面*/
-(void)initSpliteView{
    
    //如果是第一次打开就显示引导页
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"firstLaunch"];
        StartPageView *startPageView = [[StartPageView alloc] initWithFrame:CGRectMake(0, 0, WIDE, HIGH)];
        startPageView.delegate = self;
        startPageView.imageNameArray = @[@"qidong0",@"qidong1",@"qidong2"];
        
        self.tabBar.hidden = YES;
        
        [self.view addSubview:startPageView];
    }else{
        
        //如果不是第一次打开就加载广告页
        AdvertisementView *adcertisementView = [[AdvertisementView alloc] initWithFrame:CGRectMake(0, 0, WIDE, HIGH)];
        adcertisementView.delegate = self;
        [self.navigationController.view addSubview:adcertisementView];
        [adcertisementView getGuangGao];
        
        self.tabBar.hidden = YES;
        
        [self.view addSubview:adcertisementView];
        
        //获取广告图片
        ObtainAdvertisement *obtainAdvertisement = [[ObtainAdvertisement alloc] init];
        [obtainAdvertisement obtainAdvertisementImage];
    }
    
    
    
}


- (void)initTabbar{
    
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    [self setValue:tabbar forKeyPath:@"tabBar"];
}

- (void)setUpAllChildViewController{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PrintShoppingMallController *printvc = [storyBoard instantiateViewControllerWithIdentifier:@"PrintShoppingMall"];
    [self setUpOneChildViewController:printvc Image:@"mfcy_off" selectedImage:@"mfcy_on" title:@"照片冲印" hidebar:YES];

    YLPhotoPickerController *ylPhotoPicker = [[YLPhotoPickerController alloc] init];
    ylPhotoPicker.isMultiselect = YES;
    ylPhotoPicker.isShare = YES;
    [self setUpOneChildViewController:ylPhotoPicker Image:@"mbds_off" selectedImage:@"mbds_on" title:@"模板大师" hidebar:NO];
    
    MaterialTypeListController *materialTypevc = [storyBoard instantiateViewControllerWithIdentifier:@"MaterialTypeList"];
    materialTypevc.delegate = self;
    [self setUpOneChildViewController:materialTypevc Image:@"mtyj_off" selectedImage:@"mtyj_on" title:@"模板中心" hidebar:YES];
    
    PZPersonCenterVC *personalvc = [storyBoard instantiateViewControllerWithIdentifier:@"PZPersonCenterVC"];
    [self setUpOneChildViewController:personalvc Image:@"wdxw_off" selectedImage:@"wdxw_on" title:@"我的小窝" hidebar:NO];

}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

- (void)setUpOneChildViewController:(UIViewController *)viewController Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title hidebar:(BOOL)hidebar{
    //设置导航栏背景色 按钮色 不要下划线 以及是否显示
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    [navC.navigationBar setBarTintColor:RGBACOLOR(255, 255, 255, 1)];
    [navC.navigationBar setTintColor:RGBACOLOR(0, 0, 0, 1)];
    [navC.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    navC.navigationBar.shadowImage = [[UIImage alloc] init];
    navC.navigationBarHidden = hidebar;

    //设置tabbar
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = mySelectedImage;
    viewController.tabBarItem.title = title;
    
    [self addChildViewController:navC];
}

// 相机
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PZTakePhotoVC *takephoto = [storyBoard instantiateViewControllerWithIdentifier:@"PZTakePhotoVC"];
   
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:takephoto];
    [self presentViewController:navVc animated:YES completion:nil];

}

- (void)post {
    
    TemplateTypeData *templateTypeData = [TemplateTypeData CreateTemplateTypeData];
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager1.requestSerializer.timeoutInterval = 30;
    
    NSString *url1 = [NSString stringWithFormat:@"%@templet/term",POSTURL];
    
    [manager1 GET:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //模板专题
        for (NSDictionary *dict in ary) {
            TemplateTermModel *templateTerm = [[TemplateTermModel alloc] init];
            templateTerm.termId = [dict[@"id"] integerValue];
            templateTerm.termName = [NSString stringWithFormat:@"%@",dict[@"name"]];
            templateTerm.termImageUrl = [NSString stringWithFormat:@"%@",dict[@"downloadURL"]];
            templateTerm.shareNumUnlock = [dict[@"minShareNum"] integerValue];
            [templateTypeData.templateTerms addObject:templateTerm];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error：%@",error);
    }];
     */
}


#pragma -mark MaterialTypeListDelegate
- (void)openPuzzleView {
    
    //打开照片选取-拼图
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"无法访问相册.请在'设置->此时此刻->照片'设置为打开状态." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
        
    }else{
        
//        YLPhotoPickerController *ylPhotoPicker = [[YLPhotoPickerController alloc] init];
//        ylPhotoPicker.isMultiselect = YES;
//        
//        [_selectedVC.view addSubview:ylPhotoPicker.view];
    }
}

-(void)StartPageViewEnd{
    self.tabBar.hidden = false;
}
    
-(void)advertisementEnd{
    self.tabBar.hidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
