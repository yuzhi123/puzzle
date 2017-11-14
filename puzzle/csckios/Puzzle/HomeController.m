//
//  HomeController.m
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "HomeController.h"
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

#import "MaterialTypeListController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface HomeController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,AdvertisementDelegate,StartPageViewDelegate,MaterialTypeListDelegate>

@end

@implementation HomeController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //如果是第一次打开就显示引导页
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"firstLaunch"];
        StartPageView *startPageView = [[StartPageView alloc] initWithFrame:CGRectMake(0, 0, WIDE, HIGH)];
        startPageView.delegate = self;
        //startPageView.imageNameArray = @[@"qidong0",@"qidong1",@"qidong2"];
        [self.navigationController.view addSubview:startPageView];
        
    }else {
        
        //如果不是第一次打开就加载广告页
        AdvertisementView *adcertisementView = [[AdvertisementView alloc] initWithFrame:CGRectMake(0, 0, WIDE, HIGH)];
        adcertisementView.delegate = self;
        [self.navigationController.view addSubview:adcertisementView];
        [adcertisementView getGuangGao];
        
    }
    
    //获取广告图片
    ObtainAdvertisement *obtainAdvertisement = [[ObtainAdvertisement alloc] init];
    [obtainAdvertisement obtainAdvertisementImage];
    
    //拷贝初始数据到沙盒(数据库和模板)
    DownBasicsTemplate *donwn = [[DownBasicsTemplate alloc] init];
    [donwn copyPicture];
    
    //获取类型和专题
    [self post];
    
//  打开相机权限
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if(authStatus == AVAuthorizationStatusNotDetermined) {
        
        [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
        }];
        
    }
}

#pragma -mark StartPageViewDelegate
- (void)StartPageViewEnd {
    
    self.zhezhaoView.hidden = YES;
    
    //删除不需要的广告
    NSString *folderPath = [NSString stringWithFormat:@"%@/Documents/GUANGGAPTUPIAN",NSHomeDirectory()];
    
    //获取目录下的所有文件名称（包括文件夹与文件）
    NSArray *fileNameList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    for (NSString *fileName in fileNameList) {
        
        NSString *imageName = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUANGGAPTUPIAN"];
        
        
        if (![fileName isEqual:imageName]) {
            
            NSString *deleteFilePath = [NSString stringWithFormat:@"%@/Documents/GUANGGAPTUPIAN/%@",NSHomeDirectory(),fileName];
            [[NSFileManager defaultManager] removeItemAtPath:deleteFilePath error:nil];
            
            NSLog(@"删除旧广告图片成功");
            
        }
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma -mark AdvertisementDelegate
- (void)advertisementEnd {
    
    self.zhezhaoView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//制作拼图
- (IBAction)openPuzzleView:(id)sender {
    
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"无法访问相册.请在'设置->此时此刻->照片'设置为打开状态." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
        
    }else{
    
        YLPhotoPickerController *ylPhotoPicker = [[YLPhotoPickerController alloc] init];
        ylPhotoPicker.isMultiselect = YES;
        [self.navigationController pushViewController:ylPhotoPicker animated:YES];
        
    }
    
}

//素材中心
- (IBAction)openMaterialTypeList:(id)sender {
    
    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    MaterialTypeListController *materialTypeList = [storyboard instantiateViewControllerWithIdentifier:@"MaterialTypeList"];
    materialTypeList.delegate = self;
    [self.navigationController pushViewController:materialTypeList animated:YES];
    
}

//相机
- (IBAction)camera:(id)sender {
    
    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 跳转到相机页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    } else {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //bao cun
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);

}

#pragma -mark MaterialTypeListDelegate
- (void)openPuzzleView {
    
    //打开照片选取-拼图
    [self openPuzzleView:nil];
    
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
        NSLog(@"专题类型：%@",ary);
        
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


@end
