//
//  SetUpViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/10/11.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "SetUpViewController.h"

@interface SetUpViewController ()

@end

@implementation SetUpViewController
{
    UIWebView *_webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    
    if (_isSetUpMiMa) {
        [self.setMIMaBtn setTitle:@"   重置密码" forState:UIControlStateNormal];
    }else{
        [self.setMIMaBtn setTitle:@"   设置密码" forState:UIControlStateNormal];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tuichudengluAction:(id)sender {
    
    
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //删除userdefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *vip = [defaults stringForKey:@"userId"];
        NSDictionary *parameters = @{@"userId":vip};
        [networking AFNPOSTNotHUD:LJLOGINOUT withparameters:parameters success:^(NSMutableDictionary *dic) {
        } error:nil];
        [defaults removeObjectForKey:@"userId"];
        [defaults setBool:NO forKey:@"islogin"];
        [defaults synchronize];
        
        //删除归档模型
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        if ([defaultManager isDeletableFileAtPath:ACCOUNTPATH]) {
            [defaultManager removeItemAtPath:ACCOUNTPATH error:nil];
        }
        [self.navigationController popToRootViewControllerAnimated:NO];

    }];
    [clear addAction:quXiao];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];
    
}

- (IBAction)setMimaAction:(id)sender {
    
    if (_isSetUpMiMa) {
      //  [self.setMIMaBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        ModifyPassWordVC *smima = [[ModifyPassWordVC alloc] init];
        smima.hidesBottomBarWhenPushed = YES;
        smima.phoneStr = _phoneStr;
        [self.navigationController pushViewController:smima animated:YES];
        
    }else{
        //[self.setMIMaBtn setTitle:@"设置密码" forState:UIControlStateNormal];
        
        SetUpMimaViewController *smima = [[SetUpMimaViewController alloc] init];
        smima.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:smima animated:YES];
    }
   
}

- (IBAction)xiugaiPhoneAction:(id)sender {
    //修改手机号码
    ModifyPhoneVC *mVC = [[ModifyPhoneVC alloc] init];
    mVC.hidesBottomBarWhenPushed = YES;
    mVC.title = @"修改手机号码";
    [self.navigationController pushViewController:mVC animated:YES];

}

- (IBAction)lianxiKefuAction:(id)sender {
    
    // 提示：不要将webView添加到self.view，如果添加会遮挡原有的视图
    // 懒加载
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://4001818209"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

    
}


@end
