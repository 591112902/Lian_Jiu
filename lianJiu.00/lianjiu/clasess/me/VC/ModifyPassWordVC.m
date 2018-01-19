//
//  ModifyPassWordVC.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ModifyPassWordVC.h"

@interface ModifyPassWordVC ()

@end

@implementation ModifyPassWordVC
{
    NSString *accout;
    NSString *code;
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"_phoneStr_phoneStr%@",_phoneStr);
    
    
    
    
    
    
    
    if (_phoneStr.length>9) {
        
        NSString *tel = [_phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.phoneL.text = [NSString stringWithFormat:@"%@",tel];
    }else{
        
        self.phoneL.text =  [NSString stringWithFormat:@"%@",_phoneStr];
        
    }

    
    
    
    self.title = @"修改密码";
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

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




-(void)timeFireMethod{
    secondsCountDown--;
    
    //设置按钮显示读秒效果
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)secondsCountDown] forState:UIControlStateNormal];
    
    //[self.getCodeBtn setBackgroundColor:[UIColor whiteColor]];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [self.getCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.enabled = YES;
        self.getCodeBtn.alpha = 1;
    }
}




- (IBAction)getCodeBtnClick:(id)sender {
    if (self.phoneL.text.length!=0) {
    
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *userID = [def objectForKey:@"userId"];
        
     
        
        [networking AFNPOST:[NSString stringWithFormat:@"%@",SENDSMSPWD] withparameters:@{@"userId":userID?userID:@""} success:^(NSMutableDictionary *dic) {
            
            code = dic[@"lianjiuData"];
            NSLog(@"获取验证码:%@",dic);
            [MBProgressHUD showSuccess:@"验证码已发送成功" toView:[UIApplication sharedApplication].keyWindow];
            accout = self.password.text;
            self.getCodeBtn.enabled = NO;
            self.getCodeBtn.alpha = 0.8;
            secondsCountDown = 300;//60秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            
        } error:^(NSError *error) {
        } HUDAddView:[UIApplication sharedApplication].keyWindow];
    }
    NSLog(@"_phoneStr:====%@====",_phoneStr);
}

- (IBAction)sureAction:(id)sender {
    
    if (self.password.text.length==0) {
          [MBProgressHUD showNotPhotoError:@"请输入新密码" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (self.passwordAgain.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请再次输入密码" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (self.codeTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入验证码" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }

    if (self.password.text.length<6||self.passwordAgain.text.length<6) {
        [MBProgressHUD showNotPhotoError:@"密码长度至少6位" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    
    if (self.password.text.length!=0&&[validate CheckInput:@"输入的两次密码" withString:self.password.text wihtString2:self.passwordAgain.text]&&self.codeTF.text.length!=0) {
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *userPhone = [def objectForKey:@"userPhone"];
        
        [networking AFNPOSTNotCode:[NSString stringWithFormat:@"%@/%@/%@/%@/pwd=25654",CHANGEPWD,userPhone,self.codeTF.text,self.password.text] withparameters:nil success:^(NSMutableDictionary *dic) {
            //                HZLog(@"%@---%@",dic,dic[@"message"]);
            NSNumber *status=dic[@"status"];
            if ([status isEqualToNumber:@200]) {
                
               
                [MBProgressHUD showSuccess:@"修改成功" toView:[UIApplication sharedApplication].keyWindow];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *vip = [defaults stringForKey:@"userId"];
                
                [networking AFNPOSTNotHUD:LJLOGINOUT withparameters:@{@"userId":vip?vip:@""} success:^(NSMutableDictionary *dic) {
                } error:nil];
                
                //    删除userdefaults
                NSUserDefaults
                *userDefaults = [NSUserDefaults standardUserDefaults];
                //移除UserDefaults中存储的用户信息
                [userDefaults removeObjectForKey:@"name"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults setBool:NO forKey:@"islogin"];
                [userDefaults synchronize];
               
                
                
                LoginViewController *loginVc = [[LoginViewController alloc] init];
                loginVc.isBackMain = YES;
               // loginVc.isXiuMiMa = YES;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
                [self.tabBarController presentViewController:nav animated:YES completion:^{
                }];

                
              
                
                
                
                
                
            }else{
                
                
                [MBProgressHUD showError:dic[@"msg"]toView:self.view];
                
                
            }
            
        } error:nil HUDAddView:self.view];
    }else{
        
      //  [MBProgressHUD showNotPhotoError:@"密码或验证码不能为空" toView:[UIApplication sharedApplication].keyWindow];
    }

    
    
    
    
    
    
}
@end
