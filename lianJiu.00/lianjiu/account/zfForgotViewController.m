//
//  ForgotViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "zfForgotViewController.h"
#import "validate.h"
@interface zfForgotViewController ()
@property (strong, nonatomic) IBOutlet UITextField *accoutTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation zfForgotViewController
{
    NSString *accout;
    NSString *code;
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    // Do any additional setup after loading the view from its nib.
    self.accoutTF.placeholder = CustomLocalizedString(@"请输入邮箱", nil);
   
    self.codeTF.placeholder = CustomLocalizedString(@"请输入验证码", nil);
    self.codeBtn.titleLabel.numberOfLines = 0;
    self.codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.codeBtn setTitle:CustomLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
    [self.commitBtn setTitle:CustomLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    
    
        self.title=CustomLocalizedString(@"找回支付密码", nil);
        [btn setTitle:CustomLocalizedString(@"返回",nil ) forState:UIControlStateNormal];
        self.passwordTF.placeholder=CustomLocalizedString(@"请输入新支付密码", nil);
        self.passwordAgainTF.placeholder=CustomLocalizedString(@"请再次输入新支付密码", nil);
        
      // [self addRightView:self.accoutTF];
    [self addRightView:self.passwordTF];
    [self addRightView:self.passwordAgainTF];
}
-(NSNumber *)number{
    if (!_number) {
        _number=[[NSNumber alloc]init];
      
    }
      return _number;
}
//textfield添加右边的按钮
- (void)addRightView:(UITextField *)textField
{
    CGFloat btnH = textField.frame.size.height;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, btnH, btnH)];
    [btn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.imageEdgeInsets = UIEdgeInsetsMake(40, 20, 0, 10);
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
    btn.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 0, 10);
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
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *vip =  [def objectForKey:@"vip"];
        
        
        NSDictionary *parameters = @{@"vip":vip,@"name":self.accoutTF.text,@"type":@"2"};
        [networking AFNPOST:@"" withparameters:parameters success:^(NSMutableDictionary *dic) {
            code = dic[@"response"];
            HZLog(@"%@",dic);
            [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"验证码已发送成功", nil) toView:[UIApplication sharedApplication].keyWindow];
            accout = self.accoutTF.text;
            self.codeBtn.enabled = NO;
            self.codeBtn.alpha = 0.4;
            secondsCountDown = 300;//120秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        } error:^(NSError *error) {
            
        } HUDAddView:self.view];
        
        
    }else{
        //CustomLocalizedString(@"qing", nil)
        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请输入邮箱", nil) toView:[UIApplication sharedApplication].keyWindow];
        
    }
        
}

-(void)timeFireMethod{
    secondsCountDown--;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%li",(long)secondsCountDown] forState:UIControlStateNormal];
    [self.codeBtn setBackgroundColor:[UIColor grayColor]];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [self.codeBtn setTitle:CustomLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
        self.codeBtn.alpha = 1;
    }
}

- (IBAction)findPassword:(id)sender {
    
    if ([validate CheckInputEail:self.accoutTF.text]&&
        [validate CheckInputAccount:CustomLocalizedString(@"支付密码", nil) withText:self.passwordTF.text withminNum:6 withMaxNum:14000]&&
        [validate CheckInputAccount:CustomLocalizedString(@"支付密码(再次)", nil) withText:self.passwordAgainTF.text withminNum:6 withMaxNum:14000]&&
        [validate CheckInput:CustomLocalizedString(@"密码", nil) withString:self.passwordTF.text wihtString2:self.passwordAgainTF.text]&&
        [validate CheckInput2:CustomLocalizedString(@"验证码", nil) withString:self.codeTF.text wihtString2:code]&&
        [self accoutSame]
        ) {
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *vip =  [def objectForKey:@"vip"];

            NSDictionary *PayParmeters=@{@"vip":vip,@"newpayment":self.passwordTF.text,@"code":self.codeTF.text,@"name":self.accoutTF.text};
            [networking AFNPOST:@"" withparameters:PayParmeters success:^(NSMutableDictionary *dic) {
                 [MBProgressHUD showSuccess:CustomLocalizedString(@"支付密码修改成功", nil) toView:self.view.window];
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
