
//
//  PaymentViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/28.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "PaymentViewController.h"
#import "GoodsOrderViewController.h"
#import "UIImageView+WebCache.h"

#import "MXWechatConfig.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MXAliPayHandler.h"
#import "order.h"
#import "FDAlertView.h"
#import "CustomMessageView.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController
{
    CustomMessageView * contentView;
    FDAlertView *alert;
     NSString *code;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款";
    
    _aliPayBtn.layer.borderColor = MAINColor.CGColor;
    _aliPayBtn.layer.borderWidth = 1;
    
    
    
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageViewStr] placeholderImage:[UIImage imageNamed:@"esjpr"]];
    _nameL.text = _name;
    _nameDetailL.text = _nameDetail;
    _priceL.text = [NSString stringWithFormat:@"¥%@元",_price];
    
    
    
    AccountModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNTPATH];
    
    if ([model.userAsset floatValue]>[_price floatValue]) {
        
        self.lianjiuPayBtn.hidden = NO;
    }else{
       //  self.lianjiuPayBtn.hidden = YES;
    }
    
    
    
    
   // model.userAsset;
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getWXOrderPayResult:(NSNotification*)notification
{
    // 获取通知方回传的数据
    NSString* message = (NSString*)[notification object];
    NSLog(@"message:%@",message);
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"支付结果" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *quding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        GoodsOrderViewController *mvc = [[GoodsOrderViewController alloc] init];
        mvc.isPay = @"isPay";
        [self.navigationController pushViewController:mvc animated:YES];
        
        
    }];
    [clear addAction:quding];
    [self presentViewController:clear animated:YES completion:nil];
}

- (IBAction)weixinPayAction:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWXOrderPayResult:) name:@"WEIXINORDER_PAY_NOTIFICATION" object:nil];//监听一个通知
    //发起微信支付
    [MBProgressHUD showMessag:@"订单生成中..." toView:[UIApplication sharedApplication].keyWindow];
    //============================================================
    // 支付流程实现
    // 服务端操作
    //============================================================
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *vip = [def objectForKey:@"userId"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"money":_price, @"userId":vip,@"outTradeNo":_orderID}];
   
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //    [session.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [session POST:WXPAYAPPJP parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"params:%@  diC:%@",params,responseObject);
        
        
//        //提示框
//        UIAlertController *clear = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"responseObject:%@",responseObject] message:@"您的余额不足,是否去充值" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [clear addAction:quXiao];
//        [clear addAction:queRen];
//        [self presentViewController:clear animated:YES completion:nil];
        
        
        
        
        
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
        NSNumber *status=responseObject[@"status"];
        NSDictionary *response = responseObject[@"lianjiuData"];
        int c = [status intValue];
        if (c==200) {
            
            // 发起微信支付，设置参数
            PayReq *request = [[PayReq alloc] init];
            request.openID = [response objectForKey:@"appid"]; // 应用id
            request.partnerId = [response objectForKey:@"partnerid"];// 商户号
            request.prepayId= [response objectForKey:@"prepayid"];// 预支付交易会话
            request.package = @"Sign=WXPay";
            request.nonceStr= [response objectForKey:@"noncestr"];// 随机字符串
            request.timeStamp= [[response objectForKey:@"timestamp"] intValue];
            request.sign = [response objectForKey:@"sign"];
            // 调用微信
            [WXApi sendReq:request];
            
            
        }else{
            
            [MBProgressHUD showNotPhotoError:responseObject[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
        
        [MBProgressHUD showError:@"网络不给力" toView:[UIApplication sharedApplication].keyWindow];
        NSLog(@"%@",error);
    }];
}
- (void)getALOrderPayResult:(NSNotification*)notification{
    // 获取通知方回传的数据
    NSDictionary* message = (NSDictionary*)[notification object];
    NSLog(@"message:%@",message);
    
    
    NSString *msg ;
    if ([message[@"resultStatus"] isEqualToString:@"9000"]) {
        
        msg = @"支付成功";
        
        
    }else{
        msg = [message objectForKey:@"memo"];
       
    }
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"支付结果" message: msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *quding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        GoodsOrderViewController *mvc = [[GoodsOrderViewController alloc] init];
        mvc.isPay = @"isPay";
        [self.navigationController pushViewController:mvc animated:YES];
        
        
    }];
    [clear addAction:quding];
    [self presentViewController:clear animated:YES completion:nil];

    
}

- (IBAction)alipayAction:(id)sender {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getALOrderPayResult:) name:@"ALIPAYNORDER_PAY_NOTIFICATION" object:nil];//监听一个通知
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *vip = [def objectForKey:@"userId"];
    [networking AFNPOST:ALIPAYAPP withparameters:@{@"cashnum":_price,@"outTradeNo":_orderID,@"userId":vip} success:^(NSMutableDictionary *dic) {
        
        NSLog(@"dicdic:%@",dic);
        
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        
        
        [[AlipaySDK defaultService] payOrder:lianjiuData[@"orderStr"] fromScheme:@"lianjiuAlipay" callback:^(NSDictionary *resultDic) {
            
//            [MBProgressHUD showNotPhotoError:@"支付成功" toView:self.view];
//            GoodsOrderViewController *mvc = [[GoodsOrderViewController alloc] init];
//            mvc.isPay = @"isPay";
//            [self.navigationController pushViewController:mvc animated:YES];
            
            NSLog(@"reslut = %@",resultDic);
            
        }];
        
    } error:nil HUDAddView:self.view];

}

- (IBAction)lianjiuPayAction:(id)sender {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userId = [def objectForKey:@"userId"];
    
    NSString *userNP = [def objectForKey:@"username"];
    if (userNP.length>7) {
        userNP = [userNP stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",WALLETSENDSMS,userId] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        
        code = dic[@"lianjiuData"];
        NSLog(@"获取验证码:%@",dic);
        alert = [[FDAlertView alloc] init];
        contentView=[[CustomMessageView alloc]initWithFrame:CGRectMake(0, 0, 290, 170)];
        contentView.delegate=self;
        //contentView.frame = CGRectMake(0, 0, 320, 160);
        alert.contentView = contentView;
        [alert show];
        contentView.titleLab.text = @"钱包验证";
        contentView.contentLab.text=[NSString stringWithFormat:@"已经向%@发送验证码,请输入验证码",userNP];
        [contentView.authCodeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    } error:^(NSError *error) {
        
    } HUDAddView:self.view];
    

    
    
    
    
    
    
    
    
}


-(void)getCodeAction{
    NSLog(@"getCodeAction:%@",contentView.messageField.text);
}
//点击确认后调用==
-(void)getTimeToValue:(NSString *)theTimeStr
{
    NSLog(@"文本框里的值是：%@",theTimeStr);
    
 
        
        
        FDAlertView *alertt = (FDAlertView *)contentView.superview;
        [alertt hide];
        
        
        
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *uid = [def objectForKey:@"userId"];
        //请求数据=跳转页面
        NSDictionary *para = @{@"excellentId":_orderID,@"check":theTimeStr,@"userId":uid,@"price":_price?_price:@""};
        [networking AFNPOST:WALLETCHCEK withparameters:para success:^(NSMutableDictionary *dic) {
            NSLog(@"DCFillinOrderViewController:%@",dic);
            
            
          
            
            
//            //提示框
//            UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            
//            UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//                
//            }];
//            [clear addAction:quXiao];
//            [clear addAction:queRen];
//            [self presentViewController:clear animated:YES completion:nil];

            
            GoodsOrderViewController *mvc = [[GoodsOrderViewController alloc] init];
            mvc.isPay = @"isPay";
            [self.navigationController pushViewController:mvc animated:YES];
            
              [MBProgressHUD showNotPhotoError:@"付款成功" toView: mvc.view];
            
        } error:^(NSError *error) {
            
            [MBProgressHUD showError:@"稍后重试" toView:self.view];
        } HUDAddView:self.view];

        
        
    
}


@end
