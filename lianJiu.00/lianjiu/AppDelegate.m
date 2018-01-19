//
//  AppDelegate.m
//  lianjiu
//
//  Created by cnmobi on 17/8/17.
//  Copyright (c) 2017年 CNMOBI. All rights reserved.
//
#import "UMMobClick/MobClick.h"//友盟统计账号：2048928133@qq.com 密码：yy2048928133.
#import "MXWechatConfig.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "UserInfoModel.h"

//#import "AFNetworking/AFNetworking.h"
#import "AppDelegate.h"
#import "PRJTabBarViewController.h"
#import "LaunchViewController.h"
#import "UIImageView+WebCache.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//微博开发者帐号：3102949991@qq.com
//密码：hsjt28103837.


// 微信AppId：wx567ca296081c4142
// 微信AppSecret：d0eb638f14f10dc9d21af7477a00f352

// QQ APPID：101435461
//    APPKey：115ddcb80ea744fa836ca78e260a3ab1

// gaode地图新AK xUTjcNSPGcB6VaG9X7qqCSxTvIErUe3a
#import <AMapFoundationKit/AMapFoundationKit.h>






#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate, QQApiInterfaceDelegate, WXApiDelegate>



@end
#endif

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    PRJTabBarViewController *tab = [[PRJTabBarViewController alloc] init];
    self.window.rootViewController = tab;

 
    
    
    
    [WXApi registerApp:@"wx567ca296081c4142" withDescription:@"WeChat"];
    
    //gaodedidu
     [AMapServices sharedServices].apiKey = @"0f4bc194a5afeb3bf530032a820a1084";
    
    
    
//    BOOL userHasOnboarded = [[NSUserDefaults standardUserDefaults] boolForKey:@"user_has_onboarded"];
//    if (!userHasOnboarded) {//[[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]&&
//        LaunchViewController *mainVC = [[LaunchViewController alloc] init];
//        self.window.rootViewController = mainVC;
//    }else {
//        PRJTabBarViewController *tab = [[PRJTabBarViewController alloc] init];
//        self.window.rootViewController = tab;
//
//    }
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//UIStatusBarStyleLightContent
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];//whiteColor
    
    [[UINavigationBar appearance] setBarTintColor:MAINColor];//导航栏颜色
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont boldSystemFontOfSize:18], NSFontAttributeName,
                                                                     nil]];
   
    
    
    
//    //友盟统计
//    UMConfigInstance.appKey = @"58f082e67666134d2000170e";
//    //UMConfigInstance.channelId = @"App Store";
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    
    
    //[self shareSDK];
    
    
    
//    //增加登陆时间限制
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//     BOOL islogin = [userDefaults boolForKey:@"islogin"];
//    NSDate *loginDate = (NSDate *)[userDefaults objectForKey:@"loginDate"];
//    NSDate *nowDate = [NSDate date];
//    NSTimeInterval timeInterVal = [nowDate timeIntervalSinceDate:loginDate];
//    
//    
//    
//    
//    if (islogin && loginDate && timeInterVal > 60 * 60 * 24 *30) {//60 * 60 * 24 *30
//        
//        
//        [userDefaults setObject:nowDate forKey:@"loginDate"];
//        [userDefaults setBool:NO forKey:@"islogin"];
//        [userDefaults synchronize];
//
//        
//        
//        //提示框
//        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"重新登录" message:@"登录时效已过期,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//          
//        }];
//        
//        UIAlertAction *quding = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            LoginViewController *loginVc = [[LoginViewController alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
//            [tab presentViewController:nav animated:NO completion:^{
//            }];
//        }];
//        [clear addAction:quXiao];
//        [clear addAction:quding];
//        
//        //初始化UIWindows//AppDelegate.m中添加不上的解决办法
//        UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        aW.rootViewController = [[UIViewController alloc]init];
//        aW.windowLevel = UIWindowLevelAlert + 1;
//        [aW makeKeyAndVisible];
//        [aW.rootViewController presentViewController:clear animated:YES completion:nil];
//    }

    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)shareSDK
{
    [ShareSDK registerApp:@"e0b7706e7ad7" activePlatforms:@[
                                                        @(SSDKPlatformTypeSinaWeibo),
//                                                        @(SSDKPlatformTypeWechat),
                                                        @(SSDKPlatformSubTypeWechatTimeline),
                                                        @(SSDKPlatformSubTypeWechatSession),
                                                        @(SSDKPlatformTypeQQ),
                                                        @(SSDKPlatformSubTypeQQFriend),
                                                        @(SSDKPlatformSubTypeQZone),
//                                                        @(SSDKPlatformTypeMail),
//                                                        @(SSDKPlatformTypeSMS),
//                                                        @(SSDKPlatformTypeTwitter),
//                                                        @(SSDKPlatformTypeFacebook),
//                                                        @(SSDKPlatformTypeLinkedIn),
                                                        ] onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformSubTypeWechatTimeline:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformSubTypeWechatSession:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformSubTypeQQFriend:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformSubTypeQZone:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
//             case SSDKPlatformTypeMail:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
             default:
                 break;
         }
     } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"551561221"
//                                           appSecret:@"f1f5b61f7637952a2a41ba67145b474d"
                 
                 
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"551561221"
                                           appSecret:@"f1f5b61f7637952a2a41ba67145b474d"
//                                         redirectUri:@"http://www.sharesdk.cn"
                   redirectUri:@"https://api.weibo.com/oauth2/default.html"
                                            authType:SSDKAuthTypeBoth];//SSDKAuthTypeBoth
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx77f8b42d3163922d"
                                       appSecret:@"e00d816d020292d13148d9fe08c944db"];
                 break;
             case SSDKPlatformSubTypeWechatTimeline:
                 [appInfo SSDKSetupWeChatByAppId:@"wx77f8b42d3163922d"
                                       appSecret:@"e00d816d020292d13148d9fe08c944db"];
                 break;
             case SSDKPlatformSubTypeWechatSession:
                 [appInfo SSDKSetupWeChatByAppId:@"wx77f8b42d3163922d"
                                       appSecret:@"e00d816d020292d13148d9fe08c944db"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105038497"
                                      appKey:@"t33qkcJNrlGT9duR"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformSubTypeQQFriend:
                 [appInfo SSDKSetupQQByAppId:@"1105038497"
                                      appKey:@"t33qkcJNrlGT9duR"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformSubTypeQZone:
                 [appInfo SSDKSetupQQByAppId:@"1105038497"
                                      appKey:@"t33qkcJNrlGT9duR"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeMail:
                 [appInfo SSDKSetupMailParamsByText:@"欢迎使用再商网" title:@"分享" images:nil attachments:nil recipients:nil ccRecipients:nil bccRecipients:nil type:SSDKContentTypeAuto];
                 break;
//             case SSDKPlatformTypeSMS:
//                 [appInfo SSDKSetupSMSParamsByText:@"欢迎使用再商网http://www.zs21.cn" title:@"分享" images:nil attachments:nil recipients:@[@"400",@"401",@"10086"] type:SSDKContentTypeAuto];
//                 break;
             case SSDKPlatformTypeTwitter:
                 [appInfo SSDKSetupTwitterByConsumerKey:@"226427" consumerSecret:@"fc5b8aed373c4c27a05b712acba0f8c3" redirectUri:@"f29df781abdd4f49beca5a2194676ca4"];
                 break;
             case SSDKPlatformTypeFacebook:
                 [appInfo SSDKSetupFacebookByApiKey:@"232554794995.apps.googleusercontent.com" appSecret:@"PEdFgtrMw97aCvf0joQj7EMk" authType:SSDKAuthTypeBoth];
             case SSDKPlatformTypeLinkedIn:
                 [appInfo SSDKSetupLinkedInByApiKey:@"232554794995.apps.googleusercontent.com" secretKey:@"232554794995.apps.googleusercontent.com" redirectUrl:@"http://localhost"];
                 break;
             default:
                 break;
         }
     }];
}
#pragma mark - 推送开始

- (void)registerAPNS {
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    if (sysVer >= 10) {
        // iOS 10
        [self registerPush10];
    } else if (sysVer >= 8) {
        // iOS 8-9
        [self registerPush8to9];
    } else {
        // before iOS 8
        [self registerPushBefore8];
    }
#else
    if (sysVer < 8) {
        // before iOS 8
        [self registerPushBefore8];
    } else {
        // iOS 8-9
        [self registerPush8to9];
    }
#endif
}

- (void)registerPush10{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }
    }];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

- (void)registerPush8to9{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)registerPushBefore8{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}



-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    //notification是发送推送时传入的字典信息
//    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"fasdf" userInfoValue:@"faf"];
//    //删除推送列表中的这一条
//    [XGPush delLocalNotification:notification];
//    //[XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
//    //清空推送列表
//    //[XGPush clearLocalNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *vip = [defaults objectForKey:@"vip"];
//     BOOL islogin = [defaults boolForKey:@"islogin"];
//    
//     NSLog(@"[XGDemo] device token is    deviceToken:%@",deviceToken);
//    
//    
//    if (islogin) {
//
//        
//        
//        NSString *deviceTokenStr = [XGPush registerDevice:deviceToken account:vip successCallback:^{
//            NSLog(@"[XGDemo] register push success");
//        } errorCallback:^{
//            NSLog(@"[XGDemo] register push error");
//        }];
//        NSLog(@"[XGDemo] device token is %@   deviceToken:%@", deviceTokenStr,deviceToken);
//        
//        
//        
//        
////        [XGPush setAccount:vip successCallback:^{
////            NSLog(@"[XGDemo] Set account success");
////        } errorCallback:^{
////            NSLog(@"[XGDemo] Set account error");
////        }];
//        
//        
//        
//        
//        
//        [defaults setObject:deviceTokenStr forKey:@"plusToken"];
//        [defaults synchronize];
//        
//        
//        if (deviceTokenStr) {
//            NSDictionary *parameters = @{@"vip":vip,@"token":deviceTokenStr};
//            [networking AFNPOSTNotHUD:SETTOKEN withparameters:parameters success:^(NSMutableDictionary *dic) {
//            } error:nil];
//
//        }
//        
//        
//      
//    }
//   
    
    
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
}
//#pragma mark - 跳转界面
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    // if (alertView.tag == 6279980) {
//    if (buttonIndex == 1) {
//        // [MBProgressHUD showNotPhotoError:@"请到个人中心查看" toView:[UIApplication sharedApplication].keyWindow];
//        
//        XiaoxiVC *MYNVC = [[XiaoxiVC alloc] init];
//        [self.window.rootViewController presentViewController:MYNVC animated:YES completion:nil];
//         }
//}
/**
 收到通知的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 */

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"[XGDemo] receive Notification");
//    [XGPush handleReceiveNotification:userInfo
//                      successCallback:^{
//                          NSLog(@"[XGDemo] Handle receive success");
//                      } errorCallback:^{
//                          NSLog(@"[XGDemo] Handle receive error");
//                      }];
}


/**
 收到静默推送的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   // NSLog(@"[XGDemo] receive slient Notification");
    
    
//    NSLog(@"[XGDemo] userinfo %@", userInfo);
//    [XGPush handleReceiveNotification:userInfo
//                      successCallback:^{
//                          NSLog(@"[XGDemo] Handle receive success");
//                      } errorCallback:^{
//                          NSLog(@"[XGDemo] Handle receive error");
//                      }];
//    completionHandler(UIBackgroundFetchResultNewData);
//    
    
//    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
//        
//        NSLog(@"打开时打开时打开时打开时打开时userInfouserInfo:%@",userInfo);
//        //提示框
//        UIAlertController *clear = [UIAlertController alertControllerWithTitle:CustomLocalizedString(@"收到一条消息", nil) message:userInfo[@"aps"][@"alert"] preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        UIAlertAction *quding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            XiaoxiVC *MYNVC = [[XiaoxiVC alloc] init];
//            [self.window.rootViewController presentViewController:MYNVC animated:YES completion:nil];
//            
//        }];
//        [clear addAction:quxiao];
//        [clear addAction:quding];
//        // UIViewController *vc = [UIApplication sharedApplication].windows[0].rootViewController;
//        [self.window.rootViewController presentViewController:clear animated:YES completion:nil];
//    }

}

// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知的回调
// 无论本地推送还是远程推送都会走这个回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    NSLog(@"[XGDemo] click notification");
//    [XGPush handleReceiveNotification:response.notification.request.content.userInfo
//                      successCallback:^{
//                          NSLog(@"[XGDemo] Handle receive success");
//                      } errorCallback:^{
//                          NSLog(@"[XGDemo] Handle receive error");
//                      }];
//    
//    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif






#pragma mark - 推送结束
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
//    [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
//        NSLog(@"KeepAlive");
//    }];

//  __block UIBackgroundTaskIdentifier bgTask=  [application beginBackgroundTaskWithExpirationHandler:^{
//      
//      
//  }];
//    
//    [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{ [self backgroundHandler]; }];
//    
//    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^(void){
//        [self backgroundHandler];//如果此时不再调用beginBackgroundTaskWithExpirationHandler，则只有10秒钟的后台执行时间了。
//    }];
//    if (backgroundAccepted) {
//        NSLog(@"------------------------------Start new alive.");
//    }
//    [self backgroundHandler];
    
    
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
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
//    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"内存警告" message:@"程序可能会被杀掉" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alerView show];
}
#pragma mark - 微信支付回调

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.scheme isEqualToString:@"wx567ca296081c4142"]){
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"tencent101435461"]){
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"wx567ca296081c4142"]){
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"tencent101435461"]){
        return [TencentOAuth HandleOpenURL:url];
    }else if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            NSNotification *notification = [NSNotification notificationWithName:@"ALIPAYNORDER_PAY_NOTIFICATION" object:resultDic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            

            
        }];
        
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    if ([url.scheme isEqualToString:@"wx567ca296081c4142"]){
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:@"tencent101435461"]){
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
    }else if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            NSNotification *notification = [NSNotification notificationWithName:@"ALIPAYNORDER_PAY_NOTIFICATION" object:resultDic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
   
            
            
        }];
        
    }
    return YES;
}


- (void)onReq:(BaseReq *)req{
    
}

- (void)onResp:(BaseResp *)resp{
    NSLog(@"resp %d",resp.errCode);
    
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
            if ([_wxDelegate respondsToSelector:@selector(loginSuccessByCode:)]) {
                SendAuthResp *resp2 = (SendAuthResp *)resp;
                [_wxDelegate loginSuccessByCode:resp2.code];
            }
        }else{ //失败
            NSLog(@"error %@",resp.errStr);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];//[NSString stringWithFormat:@"reason : %@",resp.errStr]
            [alert show];
        }
    }

    
    if([resp isKindOfClass:[PayResp class]]){
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"恭喜您,您已支付成功！";
                
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
            case WXErrCodeCommon:
                strMsg = @"失败！普通错误类型";
                NSLog(@"普通错误类型－PaySuccess，retcode = %d", resp.errCode);
                break;
            case WXErrCodeUserCancel:
                strMsg = @"失败！您取消了支付操作!";
                NSLog(@"用户点击取消并返回－PaySuccess，retcode = %d", resp.errCode);
                break;
            case WXErrCodeSentFail:
                strMsg = @"失败！发送失败";
                NSLog(@"发送失败－PaySuccess，retcode = %d", resp.errCode);
                break;
            case WXErrCodeAuthDeny:
                strMsg = @"失败！授权失败";
                NSLog(@"授权失败－PaySuccess，retcode = %d", resp.errCode);
                break;
            case WXErrCodeUnsupport:
                strMsg = @"失败！微信不支持";
                NSLog(@"微信不支持－PaySuccess，retcode = %d", resp.errCode);
                break;
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        
        
        
        NSNotification *notification = [NSNotification notificationWithName:@"WEIXINORDER_PAY_NOTIFICATION" object:strMsg];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        //[MBProgressHUD showNotPhotoError:@"支付回调" toView:[UIApplication sharedApplication].keyWindow];
        //提示框   message:strMsg
        //        UIAlertController *clear = [UIAlertController alertControllerWithTitle:CustomLocalizedString(@"支付结果", nil) message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        //        UIAlertAction *quding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //            UIViewController *vc = [UIApplication sharedApplication].windows[0].rootViewController;
        //
        //            [vc.navigationController popViewControllerAnimated:YES];
        //
        //
        //        }];
        //        [clear addAction:quding];
        //        UIViewController *vc = [UIApplication sharedApplication].windows[0].rootViewController;
        //        [vc presentViewController:clear animated:YES completion:nil];
        
        
        
        
    }

    
    
}


@end
