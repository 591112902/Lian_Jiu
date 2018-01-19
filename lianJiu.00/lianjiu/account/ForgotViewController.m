//
//  ForgotViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "ForgotViewController.h"
#import "validate.h"
@interface ForgotViewController ()
@property (strong, nonatomic) IBOutlet UITextField *accoutTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation ForgotViewController
{
    NSString *accout;
    NSString *code;
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accoutTF.placeholder = @"请输入你的手机号码";
   
    self.codeBtn.layer.cornerRadius = 3;
    self.codeBtn.layer.borderColor = MAINColor.CGColor;
    self.codeBtn.layer.borderWidth = 1;
    self.codeTF.placeholder = @"请输入验证码";
//    self.codeBtn.titleLabel.numberOfLines = 0;
//    self.codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    
    
    self.title = @"忘记密码";
   // [btn setTitle:@"登录" forState:UIControlStateNormal];
    self.passwordTF.placeholder = @"请输入新密码";
    self.passwordAgainTF.placeholder = @"请再次输入密码";
    
    
   // [self addRightView:self.accoutTF];
    [self addRightView:self.passwordTF];
    [self addRightView:self.passwordAgainTF];
   
}

//textfield添加右边的按钮
- (void)addRightView:(UITextField *)textField
{
    //CGFloat btnH = textField.frame.size.height;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 40)];
    [btn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 5);
    [btn addTarget:self action:@selector(PasswordMingWen:) forControlEvents:UIControlEventTouchUpInside];
    btn.highlighted = NO;
    textField.rightView = btn;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

- (void)addRightViewSJ:(UITextField *)textField
{
    CGFloat btnH = textField.frame.size.height;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, btnH+10, btnH+10)];
    [btn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.imageEdgeInsets = UIEdgeInsetsMake(30, 20, 0, 10);
    [btn addTarget:self action:@selector(PasswordMingWen:) forControlEvents:UIControlEventTouchUpInside];
    btn.highlighted = NO;
    textField.rightView = btn;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

- (void)addRightViewSJ2:(UITextField *)textField
{
    CGFloat btnH = textField.frame.size.height;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, btnH+10, btnH+10)];
    [btn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.imageEdgeInsets = UIEdgeInsetsMake(30, 20, 0, 10);
    [btn addTarget:self action:@selector(PasswordMingWen:) forControlEvents:UIControlEventTouchUpInside];
    btn.highlighted = NO;
    textField.rightView = btn;
    textField.rightViewMode = UITextFieldViewModeAlways;
}


//textfield右边btn点击事件
-(void)PasswordMingWen:(UIButton *)btn
{
    btn.selected = !btn.selected;
    UITextField *textf = (UITextField *)btn.superview;
    textf.secureTextEntry  = !textf.secureTextEntry;
}
- (void)back
{
    [countDownTimer invalidate];
    countDownTimer= nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCode:(id)sender {
    if (self.accoutTF.text.length!=0) {
        //NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        //NSString *vip =  [def objectForKey:@"vip"];
        
        
      //  NSDictionary *parameters = @{@"name":self.accoutTF.text,@"type":@"2"};
        [networking AFNPOST:FORGETPWDSMS withparameters:@{@"phone":self.accoutTF.text} success:^(NSMutableDictionary *dic) {
            code = dic[@"lianjiuData"];
            NSLog(@"%@",dic);
            [MBProgressHUD showSuccess:@"验证码已发送成功" toView:[UIApplication sharedApplication].keyWindow];
            accout = self.accoutTF.text;
            self.codeBtn.enabled = NO;
            self.codeBtn.alpha = 0.4;
            secondsCountDown = 300;//120秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        } error:^(NSError *error) {
            
        } HUDAddView:self.view];
        
        
    }else{
        
        
        
        //CustomLocalizedString(@"qing", nil)
        [MBProgressHUD showSuccess:@"请输入手机号码" toView:[UIApplication sharedApplication].keyWindow];
        
    }
        
}

-(void)timeFireMethod{
    secondsCountDown--;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%li",(long)secondsCountDown] forState:UIControlStateNormal];
    //[self.codeBtn setBackgroundColor:[UIColor whiteColor]];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [self.codeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
        self.codeBtn.alpha = 1;
    }
}

- (IBAction)findPassword:(id)sender {
    
    if (self.accoutTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请输入手机号" toView:self.view];
        return;
    }
    if (self.passwordTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请输入新密码" toView:self.view];
        return;
    }

    if (self.passwordAgainTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请再次输入新密码" toView:self.view];
        return;
    }
    if (self.codeTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请输入验证码" toView:self.view];
        return;
    }

       
    if ([validate CheckInputEail:self.accoutTF.text]&&
        [validate CheckInputAccount:@"密码" withText:self.passwordTF.text withminNum:6 withMaxNum:14000]&&
        [validate CheckInputAccount:@"密码(再次)" withText:self.passwordAgainTF.text withminNum:6 withMaxNum:14000]&&
        [validate CheckInput:@"密码" withString:self.passwordTF.text wihtString2:self.passwordAgainTF.text]
        ) {
        
        
        [networking AFNPOST:[NSString stringWithFormat:@"%@/%@/%@/%@",UPDATEPWD,self.passwordAgainTF.text,self.codeTF.text,self.accoutTF.text] withparameters:nil success:^(NSMutableDictionary *dic) {
                    
            [MBProgressHUD showSuccess:@"密码修改成功" toView:self.view.window];
            [self back];
            
            
        } error:nil HUDAddView:self.view];}
    
    
}


- (BOOL)accoutSame
{
    if ([self.accoutTF.text isEqualToString:accout]) {
        return YES;
    }
    [MBProgressHUD showNotPhotoError:@"请重新获取验证码" toView:self.view];
    return NO;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
//    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (textField==_passwordTF||textField==_passwordAgainTF)
//    {
//        if ([aString length] > 16) {
//            textField.text = [aString substringToIndex:16];
//            return NO;
//        }
//    }
    return YES;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    HZLog(@"%@---dealloc",self.class);
}
@end
