//
//  LoginViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/12/5.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//
#import "DXLoginViewController.h"
#import "ForgotVC.h"
#import "RegisterVC.h"

#import "PRJTabBarViewController.h"
#import "NSString+MD5.h"
#import "AccountModel.h"

@interface DXLoginViewController ()
{
   
}
@property (strong, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;


@property (strong, nonatomic) IBOutlet UIView *tuJianMaView;


@property (strong, nonatomic) IBOutlet UITextField *tuiJianMaTF;







@end

@implementation DXLoginViewController
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
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
   
    
    self.accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
//    self.passwordTF.secureTextEntry  = YES;
//
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 40)];
//    [btn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
//    btn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 5);
//    [btn addTarget:self action:@selector(PasswordMingWen:) forControlEvents:UIControlEventTouchUpInside];
//    btn.highlighted = NO;
//    
//    self.passwordTF.rightView = btn;
//    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;

  
    self.title = @"验证短信登录";
    
    
    
    self.getCodeBtn.layer.cornerRadius = 3;
    self.getCodeBtn.layer.borderWidth = 1;
    self.getCodeBtn.layer.borderColor = MAINColor.CGColor;
    
    
    [self.view layoutSubviews];
    
    
    
    
}

-(void)PasswordMingWen:(UIButton *)sender//  password 明文
{
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry  = !self.passwordTF.secureTextEntry;
}


- (IBAction)getCodeAction:(id)sender {


    if (self.accountTF.text.length!=0) {
        
        
        [networking AFNPOST:[NSString stringWithFormat:@"%@/%@",SENDSMSLOGIN,self.accountTF.text] withparameters:nil success:^(NSMutableDictionary *dic) {
           
            code =  [NSString stringWithFormat:@"%@",dic[@"lianjiuData"]];//返回0代表为不存在推荐码，1代表存在推荐码）
            NSLog(@"code:%@",code);
            
            if ([code isEqualToString:@"0"]) {
                
                self.tuJianMaView.hidden = NO;
               
               
            }else{
                 self.tuJianMaView.hidden = YES;
              
               

            }
            
            
            
            
            
            NSLog(@"获取验证码:%@",dic);
            [MBProgressHUD showSuccess:@"验证码已发送成功" toView:[UIApplication sharedApplication].keyWindow];
            accout = self.accountTF.text;
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
    //[self.getCodeBtn setBackgroundColor:[UIColor whiteColor]];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [self.getCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.enabled = YES;
        self.getCodeBtn.alpha = 1;
    }
}

- (IBAction)ToLogin:(id)sender {
//以下写会出现问题 text 不等于空  也可以  self.accountTF.text.length=0;

  
    
    
    if (self.accountTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入手机号码" toView:self.view];
        return;
    }
    
    if (self.passwordTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入验证码" toView:self.view];
        return;
    }

    
    
    
    if (![self.accountTF.text isEqualToString:@""]&&![self.passwordTF.text isEqualToString:@""]) {
        if ([self CheckInputEail:self.accountTF.text]) {
//            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//            NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
            
            
            
            [networking AFNPOSTNotCode:SMSLOGIN withparameters:@{@"phone":self.accountTF.text,@"uCode":self.passwordTF.text,@"udetailsEquipment":@"2",@"udetailsReferrer":self.tuiJianMaTF.text?self.tuiJianMaTF.text:@""} success:^(NSMutableDictionary *dic) {
               NSLog(@"dic::%@---",dic);
                NSNumber *status=dic[@"status"];
                if ([status isEqualToNumber:@200]) {
                    NSDictionary *responseDic = dic[@"lianjiuData"];
                    
                    
                    NSLog(@"%@   %@",responseDic[@"userId"],responseDic[@"userPhone"]);
                    
                   
                    [defaults setObject:responseDic[@"username"] forKey:@"username"];
                    [defaults setObject:responseDic[@"userPhone"] forKey:@"userPhone"];
                    [defaults setObject:responseDic[@"userId"] forKey:@"userId"];
                   // [defaults setObject:parameters[@"pwd"] forKey:@"www"];
                   
                    [defaults setBool:YES forKey:@"islogin"];
                    [defaults setObject:[NSDate date] forKey:@"loginDate"];
//                    [self queryPersonReadNameID];
//                    [self queryBusinessReadNameID];
                    [defaults synchronize];
                    AccountModel *model = [AccountModel ModelWith:responseDic];
                    [NSKeyedArchiver archiveRootObject:model toFile:ACCOUNTPATH];
                    
                    
                    
                    
                    
                    
                    [networking AFNPOSTNotCode:[NSString stringWithFormat:@"%@/%@/username=126",ISPWD,self.accountTF.text] withparameters:nil success:^(NSMutableDictionary *dic) {
                        NSLog(@"ISPWD%@",dic);
                        NSNumber *status = dic[@"status"];
                        if ([status isEqualToNumber:@200]) {
                           // isSetUp = YES;
                            
                            [MBProgressHUD showSuccess:@"登录成功" toView:self.view.window];
                            
                            [self dismissViewControllerAnimated:YES completion:^{
                                
                            }];
                           
                            
                        }else if ([status isEqualToNumber:@400]){
                            //没有设置密码=调到设置密码页面
                            SetUpMimaViewController *svc = [[SetUpMimaViewController alloc] init];
                            svc.isTiaoGou = YES;
                         
                       
                           [self.navigationController pushViewController:svc animated:YES];

                        
                            
                        }else{
                           // isSetUp = YES;//这里假设默认设置过密码
                            [self dismissViewControllerAnimated:YES completion:^{
                                
                            }];
                        }
                    } error:^(NSError *error) {
                        
                        // isSetUp = YES;//这里假设默认设置过密码
                        [self dismissViewControllerAnimated:YES completion:^{
                        }];
                    } HUDAddView:self.view];

                    
                    
                    
                    
                    
                    
                }else{
//                    [MBProgressHUD showError:dic[@"message"] toView:self.view];
                      [MBProgressHUD showError:dic[@"msg"]toView:self.view];

                }
                
            } error:nil HUDAddView:self.view];
           
        }
        
    }else{
        [MBProgressHUD showNotPhotoError:@"账户或密码不能为空" toView:self.view];
    }
}




//4、判断邮箱
- (BOOL)CheckInputEail:(NSString *)text {
//    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//
//
//    if (![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"您输入的账号不存在", nil) toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.accountTF) {
        [self.passwordTF becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


@end
