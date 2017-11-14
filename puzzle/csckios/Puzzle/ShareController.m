//
//  ShareController.m
//  Puzzle
//
//  Created by yiliu on 16/9/7.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "ShareController.h"
#import "ShareButton.h"


#import <UMSocialCore/UMSocialCore.h>

@interface ShareController ()

@property (strong, nonatomic) ShareButton *shareQQBtn;
@property (strong, nonatomic) ShareButton *shareQQKongJianBtn;
@property (strong, nonatomic) ShareButton *shareWeiChatBtn;
@property (strong, nonatomic) ShareButton *sharePengYouQuanBtn;
@property (strong, nonatomic) ShareButton *shareTencentBtn;
@property (strong, nonatomic) ShareButton *shareSinaBtn;

@property (weak, nonatomic) IBOutlet UIButton *againPuzzleBtn;

@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float a = (WIDE-150)/4;
    
    _shareQQBtn = [[ShareButton alloc] initWithFrame:CGRectMake(a-20, 180, 90, 76)];
    _shareQQKongJianBtn = [[ShareButton alloc] initWithFrame:CGRectMake(a-20+90+a-40, 180, 90, 76)];
    _shareWeiChatBtn = [[ShareButton alloc] initWithFrame:CGRectMake(a-20+90+a-40+90+a-40, 180, 90, 76)];
    
    _sharePengYouQuanBtn = [[ShareButton alloc] initWithFrame:CGRectMake(a-20, 276, 90, 76)];
    _shareTencentBtn = [[ShareButton alloc] initWithFrame:CGRectMake(a-20+90+a-40, 276, 90, 76)];
    _shareSinaBtn = [[ShareButton alloc] initWithFrame:CGRectMake(a-20+90+a-40+90+a-40, 276, 90, 76)];
    
    _shareQQBtn.contentLabel.text = @"QQ";
    _shareQQKongJianBtn.contentLabel.text = @"QQ空间";
    _shareWeiChatBtn.contentLabel.text = @"微信好友";
    _sharePengYouQuanBtn.contentLabel.text = @"朋友圈";
    _shareTencentBtn.contentLabel.text = @"腾讯微博";
    _shareSinaBtn.contentLabel.text = @"新浪微博";
    
    _shareQQBtn.bkImageView.image = [UIImage imageNamed:@"share_QQ"];
    _shareQQKongJianBtn.bkImageView.image = [UIImage imageNamed:@"share_Qzone"];
    _shareWeiChatBtn.bkImageView.image = [UIImage imageNamed:@"share_wechat1"];
    _sharePengYouQuanBtn.bkImageView.image = [UIImage imageNamed:@"share_wechat2"];
    _shareTencentBtn.bkImageView.image = [UIImage imageNamed:@"share_tencent"];
    _shareSinaBtn.bkImageView.image = [UIImage imageNamed:@"share_sina"];
    
    [_shareQQBtn addTarget:self action:@selector(shareQQ:) forControlEvents:UIControlEventTouchUpInside];
    [_shareQQKongJianBtn addTarget:self action:@selector(shareQQKongJianBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_shareWeiChatBtn addTarget:self action:@selector(shareWeiChat:) forControlEvents:UIControlEventTouchUpInside];
    [_sharePengYouQuanBtn addTarget:self action:@selector(sharePengYouQuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shareTencentBtn addTarget:self action:@selector(shareTencent:) forControlEvents:UIControlEventTouchUpInside];
    [_shareSinaBtn addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_shareQQBtn];
    [self.view addSubview:_shareQQKongJianBtn];
    [self.view addSubview:_shareWeiChatBtn];
    [self.view addSubview:_sharePengYouQuanBtn];
    [self.view addSubview:_shareTencentBtn];
    [self.view addSubview:_shareSinaBtn];
    
    _againPuzzleBtn.layer.cornerRadius = 20;
    _againPuzzleBtn.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回
- (void)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//首页
- (void)homeView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//再来一张
- (IBAction)againPuzzle:(id)sender {
    NSArray *ary = self.navigationController.viewControllers;
    [self.navigationController popToViewController:ary[1] animated:YES];
}

//分享到qq
- (void)shareQQ:(id)sender {
    [self share:UMSocialPlatformType_QQ];
}

//分享到新浪
- (void)shareSina:(id)sender {
    [self share:UMSocialPlatformType_Sina];
}

//分享到微信
- (void)shareWeiChat:(id)sender {
    [self share:UMSocialPlatformType_WechatSession];
}

//分享到QQ空间
- (void)shareQQKongJianBtn:(id)sender {
    [self share:UMSocialPlatformType_Qzone];
}

//分享到腾讯微博
- (void)shareTencent:(id)sender {
    [self share:UMSocialPlatformType_TencentWb];
}

//分享到朋友圈
- (void)sharePengYouQuan:(id)sender {
    [self share:UMSocialPlatformType_WechatTimeLine];
}

- (void)share:(UMSocialPlatformType)platformType {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    shareObject.thumbImage = _shareImage;
    
    [shareObject setShareImage:_shareImage];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            
            [self alertWithError:error];
            
            [hud hideAnimated:YES];
            
        }else{
            
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                
                UMSocialLogInfo(@"response data is %@",data);
                
            }
            
            NSLog(@"分享成功！");
            
            //保存分享次数
            NSInteger shareNum = 0;
            NSString *shareNumStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShareNum"];
            if (shareNumStr) {
                shareNum = [shareNumStr integerValue] + 1;
            }else {
                shareNum = 1;
            }
            NSString *shareNumS = [NSString stringWithFormat:@"%tu",shareNum];
            [[NSUserDefaults standardUserDefaults] setObject:shareNumS forKey:@"ShareNum"];
            
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"分享成功";
            [hud hideAnimated:YES afterDelay:1.2];
            
        }
        
    }];
    
}

- (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}


@end
