//
//  TXVC.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/29.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "TXVC.h"
#import "WxTXViewController.h"
#import "AlipayViewController.h"

@interface TXVC ()

@property (nonatomic,strong) NSString *payStyle;

@end

@implementation TXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    
    
    self.wxView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payChooseClass:)];
    [self.wxView addGestureRecognizer:tap];
    self.wxView.tag = 10;
    
    
    self.alipayView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payChooseClass:)];
    [self.alipayView addGestureRecognizer:tap2];
    self.alipayView.tag = 11;

    
    
    
    self.yhkView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payChooseClass:)];
    [self.yhkView addGestureRecognizer:tap3];
    self.yhkView.tag = 12;

    
    
    
    
    _payStyle = @"wx";
    self.wxBtn.selected = YES;
    self.alipayBtn.selected = NO;
    self.yhkBtn.selected = NO;

    
   
    // Do any additional setup after loading the view from its nib.
}
-(void)payChooseClass:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag==10) {
        _payStyle = @"wx";
        self.wxBtn.selected = YES;
        self.alipayBtn.selected = NO;
        self.yhkBtn.selected = NO;
        
    }else if(tap.view.tag==11){
        _payStyle = @"alipay";
        self.wxBtn.selected = NO;
        self.alipayBtn.selected = YES;
        self.yhkBtn.selected = NO;
    }else if(tap.view.tag==12){
        _payStyle = @"yhk";
        self.wxBtn.selected = NO;
        self.alipayBtn.selected = NO;
        self.yhkBtn.selected = YES;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextAction:(UIButton *)sender {
    NSLog(@"支付方式是:%@",_payStyle);
    if ([_payStyle isEqualToString:@"wx"]) {
        ErWeiMaWxViewController *tx = [[ErWeiMaWxViewController alloc] init];
        [self.navigationController pushViewController:tx animated:YES];

    }else  if ([_payStyle isEqualToString:@"alipay"]) {
        AlipayViewController *tx = [[AlipayViewController alloc] init];
        [self.navigationController pushViewController:tx animated:YES];
        
    }else  if ([_payStyle isEqualToString:@"yhk"]) {
        
        
        
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL islogin = [defaults boolForKey:@"islogin"];
        NSString *vip = [defaults objectForKey:@"userId"];
        if (!islogin) {
            return;
        }else{
            
            AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            UIView *superView = [UIApplication sharedApplication].keyWindow;
            [MBProgressHUD showHUDAddedTo:superView animated:YES];
            [manager GET:[NSString stringWithFormat:@"%@/%@",ISUSERBANKCARD,vip] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSNumber *code=dict[@"status"];
                int c = [code intValue];
                if (c==200) {
                  
                    
                    if ([dict[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
                        
                        NSDictionary *lianjiuData = dict[@"lianjiuData"];
                        YhkTxViewController *tx = [[YhkTxViewController alloc] init];
                        tx.lianjiuData = lianjiuData;
                        [self.navigationController pushViewController:tx animated:YES];

                        
                        
                    }
                    
                }else{
                    [MBProgressHUD showNotPhotoError:dict[@"msg"] toView:superView];
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                
            }];
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    
    
}
@end
