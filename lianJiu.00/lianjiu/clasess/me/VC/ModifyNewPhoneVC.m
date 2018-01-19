//
//  ModifyPhoneVC.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ModifyNewPhoneVC.h"

@interface ModifyNewPhoneVC ()

@end

@implementation ModifyNewPhoneVC
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
    self.title = @"新手机号码";
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

- (IBAction)sureBtnAction:(id)sender {
    
    
    if (self.phoneTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请输入新手机号码" toView:self.view];
        return;
        
    }
    if (self.codeTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请输入验证码" toView:self.view];
        return;
        
    }

    
    if (![self.phoneTF.text isEqualToString:@""]&&![self.codeTF.text isEqualToString:@""]) {
        
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *uid = [def objectForKey:@"userId"];
        
        [networking AFNPOSTNotCode:[NSString stringWithFormat:@"%@/%@/%@/%@/id=126",PHONECHANGE,uid,self.phoneTF.text,self.codeTF.text] withparameters:nil success:^(NSMutableDictionary *dic) {
            //                HZLog(@"%@---%@",dic,dic[@"message"]);
            NSNumber *status=dic[@"status"];
            if ([status isEqualToNumber:@200]) {
                
                [MBProgressHUD showSuccess:@"修改成功" toView:[UIApplication sharedApplication].keyWindow];
                
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                
                
                [MBProgressHUD showError:dic[@"msg"]toView:self.view];
                
                
            }
            
        } error:nil HUDAddView:self.view];
        
        
        
    }else{
        [MBProgressHUD showNotPhotoError:@"手机号或验证码不能为空" toView:self.view];
    }

}

- (IBAction)codeBtnAction:(UIButton *)sender {
    if (self.phoneTF.text.length!=0) {
        
        
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *uid = [def objectForKey:@"userId"];
        
        [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/%@",SENDNEWPHONE,uid,self.phoneTF.text] withparameters:nil success:^(NSMutableDictionary *dic) {
            code = dic[@"lianjiuData"];
            NSLog(@"获取验证码:%@",dic);
            [MBProgressHUD showSuccess:@"验证码已发送成功" toView:[UIApplication sharedApplication].keyWindow];
            accout = self.phoneTF.text;
            self.getCodeBtn.enabled = NO;
            self.getCodeBtn.alpha = 0.4;
            secondsCountDown = 300;//60秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        } error:^(NSError *error) {
            
        } HUDAddView:self.view];
    }else{
        
        [MBProgressHUD showNotPhotoError:@"手机号码不能为空" toView:[UIApplication sharedApplication].keyWindow];
    }

}
-(void)timeFireMethod{
    secondsCountDown--;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)secondsCountDown] forState:UIControlStateNormal];
    // [self.getCodeBtn setBackgroundColor:[UIColor whiteColor]];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [self.getCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.enabled = YES;
        self.getCodeBtn.alpha = 1;
    }
}

@end
