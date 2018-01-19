/**
 @@create by 刘智援 2016-11-28
 
 @简书地址:    http://www.jianshu.com/users/0714484ea84f/latest_articles
 @Github地址: https://github.com/lyoniOS
 @return WXApiManager（微信结果回调类）
 */
#import "MXWechatConfig.h"
#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - 单粒

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
    
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"恭喜您,您已充值成功！";
               
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
