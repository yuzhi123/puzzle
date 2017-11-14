 //
//  AppDelegate.m
//  Puzzle
//
//  Created by yiliu on 16/8/29.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "AppDelegate.h"

#import <UMSocialCore/UMSocialCore.h>

#import "IQKeyboardManager.h"

#import "Auxiliary.h"
#import "CreateTable.h"
#import "TemplateOperation.h"
#import "DownBasicsTemplate.h"
#import "WXApi.h"

#define WXAppID         @"wxaa579ebb1067db16"
#define WXAppSecret     @"54d9db48ebc541159bff235d36fdddc7"

//登录
#import "loadNav.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    //拷贝初始数据到沙盒(数据库和模板)
    DownBasicsTemplate *donwn = [[DownBasicsTemplate alloc] init];
    [donwn copyPicture];
    
    //初始化友盟分享
    [self setUM];
    
    //启动基本SDK
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"39990cbe325df78e8740eb507a7013a2"];
    
   /*
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [loadNav shareLoadVC];
    [self.window makeKeyAndVisible];
*/
    
    
    
    return YES;
}

//初始化友盟分享
- (void)setUM {
    
    //打开调试日志
//    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5809887fbd69b924c000299e"];
    
    // 获取友盟social版本号
//    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxaa579ebb1067db16" appSecret:@"54d9db48ebc541159bff235d36fdddc7" redirectURL:@"www.cscki.com"];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105771342"  appSecret:@"9nUgNBUNyAo5C3l4" redirectURL:@"www.cscki.com"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"4161657671"  appSecret:@"ca67902ddba31a85e460fbafebe8bafe" redirectURL:@"www.cscki.com"];
    
    //微信支付
    [WXApi registerApp:@"wxaa579ebb1067db16" withDescription:@"此时此刻"];
}

#pragma mark - 如果使用SSO（可以简单理解成客户端授权），以下方法是必要的
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        NSString *weiChatUrl = [NSString stringWithFormat:@"%@",url];
        if([weiChatUrl rangeOfString:@"pay"].location !=NSNotFound){
            return [WXApi handleOpenURL:url delegate:self];
        }else{
            return YES;
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        NSString *weiChatUrl = [NSString stringWithFormat:@"%@",url];
        if([weiChatUrl rangeOfString:@"pay"].location !=NSNotFound){
            return [WXApi handleOpenURL:url delegate:self];
        }else{
            return YES;
        }
    }
    return result;
}

//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        NSString *weiChatUrl = [NSString stringWithFormat:@"%@",url];
        if([weiChatUrl rangeOfString:@"pay"].location !=NSNotFound){
            return [WXApi handleOpenURL:url delegate:self];
        }else{
            return YES;
        }
    }
    return result;
}

#endif

//支付结果
-(void)onResp:(BaseResp*)resp{
    NSString *strTitle;
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if ([resp isKindOfClass:[PayResp class]]) {
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeiChatPay" object:@"YES"];
                NSLog(@"支付结果: 成功!");
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeiChatPay" object:@"NO"];
                [self alertTitle:strTitle andContent:@"支付失败!"];
                NSLog(@"支付结果: 失败!");
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeiChatPay" object:@"NO"];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeiChatPay" object:@"NO"];
                [self alertTitle:strTitle andContent:@"发送失败"];
                NSLog(@"发送失败");
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeiChatPay" object:@"NO"];
                [self alertTitle:strTitle andContent:@"微信不支持"];
                NSLog(@"微信不支持");
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeiChatPay" object:@"NO"];
                [self alertTitle:strTitle andContent:@"授权失败"];
                NSLog(@"授权失败");
            }
                break;
            default:
                break;
        }
    }
}

- (void)alertTitle:(NSString *)title andContent:(NSString *)content{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
