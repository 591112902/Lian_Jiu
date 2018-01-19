//
//  RegisterViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/8/29.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import "RegisterViewController.h"
#import "validate.h"
#import "ForgotViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *accoutTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainTF;
@property (strong, nonatomic) IBOutlet UITextField *RecommendedCodeTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;

@property (strong,nonatomic)ForgotViewController *forgotVC;
@end

@implementation RegisterViewController

{
    NSString *accout;
    NSString *code;
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CustomLocalizedString(@"注册", nil);

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH-500, BOUND_HIGHT-550)];
    btn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:CustomLocalizedString(@"登录", nil) forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
    
   
    
    self.accoutTF.placeholder = CustomLocalizedString(@"请输入邮箱", nil);
    
    
    self.passwordTF.placeholder = CustomLocalizedString(@"请输入密码", nil);
    self.passwordAgainTF.placeholder = CustomLocalizedString(@"请再次输入密码", nil);
    if (self.passwordTF&&self.passwordAgainTF) {
        self.forgotVC=[[ForgotViewController alloc]init];
        [self.forgotVC addRightView:self.passwordTF];
        [self.forgotVC addRightView:self.passwordAgainTF];
    }
    self.RecommendedCodeTF.placeholder = CustomLocalizedString(@"请输入推荐人的会员编号(非必填)", nil);
    self.codeTF.placeholder = CustomLocalizedString(@"请输入验证码", nil);
  
    self.codeBtn.titleLabel.numberOfLines = 0;
    self.codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.codeBtn setTitle:CustomLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
    [self.registerBtn setTitle:CustomLocalizedString(@"注 册", nil) forState:UIControlStateNormal];
    
    
}
- (void)back
{
    [countDownTimer invalidate];
    countDownTimer= nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)ToRegister:(id)sender {
    
    if ([validate CheckInputEail:self.accoutTF.text] &&
        [validate CheckInputAccount:CustomLocalizedString(@"密码", nil) withText:self.passwordTF.text withminNum:6 withMaxNum:14000] &&
        [validate CheckInputAccount:CustomLocalizedString(@"密码(再次)", nil) withText:self.passwordAgainTF.text withminNum:6 withMaxNum:14000]&&
        [validate CheckInput:CustomLocalizedString(@"密码", nil) withString:self.passwordTF.text wihtString2:self.passwordAgainTF.text] &&
        [validate CheckInput2:CustomLocalizedString(@"验证码", nil) withString:self.codeTF.text wihtString2:code] && 
        [self accoutSame]
        ) {

        NSDictionary *parameters = @{@"name":self.accoutTF.text,@"code":self.codeTF.text,@"pwd":self.passwordAgainTF.text,@"referrer_vip":self.RecommendedCodeTF.text};
        [networking AFNPOST:@"" withparameters:parameters success:^(NSMutableDictionary *dic) {
            [MBProgressHUD showSuccess:CustomLocalizedString(@"注册成功", nil) toView:self.view.window];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:parameters[@"name"] forKey:@"email"];
            [defaults setObject:parameters[@"pwd"] forKey:@"www"];
            [self back];
        } error:nil HUDAddView:self.view];
    }
    
}
- (BOOL)accoutSame
{
    if ([self.accoutTF.text isEqualToString:accout]) {
        return YES;
    }
    [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请重新获取验证码", nil) toView:self.view];
    return NO;
}
- (IBAction)getCode:(id)sender {

    if ([validate CheckInputEail:self.accoutTF.text]) {
        NSDictionary *parameters = @{@"name":self.accoutTF.text,@"type":@"1"};
        [networking AFNPOST:@"" withparameters:parameters success:^(NSMutableDictionary *dic) {
            code = dic[@"response"];
            NSLog(@"%@",dic);
            [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"验证码已发送成功", nil) toView:[UIApplication sharedApplication].keyWindow];
            accout = self.accoutTF.text;
            self.codeBtn.enabled = NO;
            self.codeBtn.alpha = 0.4;
            secondsCountDown = 300;//60秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        } error:^(NSError *error) {
            
        } HUDAddView:self.view];
    }
}
-(void)timeFireMethod{
    secondsCountDown--;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)secondsCountDown] forState:UIControlStateNormal];
    [self.codeBtn setBackgroundColor:[UIColor grayColor]];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [self.codeBtn setTitle:CustomLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
        self.codeBtn.alpha = 1;
    }
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
