//
//  ForgotViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "ForgotViewController2.h"
#import "validate.h"
@interface ForgotViewController2 ()

@property(nonatomic,strong)NSString *quhaozhi;
@property (strong, nonatomic) IBOutlet UITextField *accoutTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation ForgotViewController2
{
    NSString *accout;
    NSString *code;
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.quhaoBtn2 setTitle:CustomLocalizedString(@"选择区号", nil) forState:UIControlStateNormal];
    
    self.quhaoBtn2.titleLabel.adjustsFontSizeToFitWidth = YES;
   
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    // Do any additional setup after loading the view from its nib.
    self.accoutTF.placeholder = CustomLocalizedString(@"请输入手机号码", nil);
   self.accoutTF.keyboardType=UIKeyboardTypePhonePad;
    self.codeTF.placeholder = CustomLocalizedString(@"请输入验证码", nil);
    self.codeBtn.titleLabel.numberOfLines = 0;
    self.codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.codeBtn setTitle:CustomLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
    [self.commitBtn setTitle:CustomLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    
    if ([self.number isEqual:@1]) {
        self.title=CustomLocalizedString(@"找回支付密码", nil);
        [btn setTitle:CustomLocalizedString(@"返回",nil ) forState:UIControlStateNormal];
        self.passwordTF.placeholder=CustomLocalizedString(@"请输入支付密码", nil);
        self.passwordAgainTF.placeholder=CustomLocalizedString(@"请再次输入支付密码", nil);
        
    }else{
     self.title = CustomLocalizedString(@"找回登录密码", nil);
    [btn setTitle:CustomLocalizedString(@"登录", nil) forState:UIControlStateNormal];
    self.passwordTF.placeholder = CustomLocalizedString(@"请输入密码", nil);
    self.passwordAgainTF.placeholder = CustomLocalizedString(@"请再次输入密码", nil);
        
    }
    //[self addRightView:self.accoutTF];
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

- (IBAction)quhaoForgot:(id)sender {
    
//    CGPoint point = CGPointMake(100, 120);
//    NSArray *titles = @[@"+86",@"+886",@"+82",@"+81",@"+1",@"+44",@"+852"];//, @"扫一扫"
//    //NSArray *images = @[@"microphone@2x.png", @"camera@2x.png"];//, @"camera@2x.png"
//    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titles images:nil];
//    pop.selectRowAtIndex = ^(NSInteger index){
//        // NSLog(@"select index:%ld", (long)index);
//        
//        _quhaozhi = titles[index];
//        UIButton *btn = (UIButton*)sender;
//        [btn setTitle:_quhaozhi forState:UIControlStateNormal];
//        NSLog(@"里面:%@",_quhaozhi);
//    };
//    [pop show];
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
    CountryCodeVC.deleagete = self;
    
    //block
    [CountryCodeVC toReturnCountryCode:^(NSString *countryCodeStr) {
        //[self.countryCodeLB setText:countryCodeStr];
        
        
        UIButton *btn = (UIButton*)sender;
        [btn setTitle:countryCodeStr forState:UIControlStateNormal];
        
        _quhaozhi = countryCodeStr;
        
    }];
    
    [self presentViewController:CountryCodeVC animated:YES completion:nil];

    
    
    
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
    
    if (!_quhaozhi) {
        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请选择区号", nil) toView:[UIApplication sharedApplication].keyWindow];
        return;
    }

    
    if (self.accoutTF.text.length!=0) {
        
     // NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
     // NSString *vip =  [def objectForKey:@"vip"];
        
        
        NSDictionary *parameters = @{@"area":_quhaozhi?_quhaozhi:@"+86",@"name":self.accoutTF.text,@"type":@"2"};
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
        //CustomLocalizedString(@"", nil)
        
        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请输入手机号", nil) toView:[UIApplication sharedApplication].keyWindow];
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
    if (!_quhaozhi) {
        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"选择区号", nil) toView:[UIApplication sharedApplication].keyWindow];
        return;
    }

    if (
        [validate CheckInputALLPhone:CustomLocalizedString(@"手机号码", nil) withText:self.accoutTF.text]&&[validate CheckInputAccount:CustomLocalizedString(@"密码", nil) withText:self.passwordTF.text withminNum:6 withMaxNum:14000]&&
        [validate CheckInputAccount:CustomLocalizedString(@"密码(再次)", nil) withText:self.passwordAgainTF.text withminNum:6 withMaxNum:14000]&&
        [validate CheckInput:CustomLocalizedString(@"密码", nil) withString:self.passwordTF.text wihtString2:self.passwordAgainTF.text]&&
        [validate CheckInput2:CustomLocalizedString(@"验证码", nil) withString:self.codeTF.text wihtString2:code]&&
        [self accoutSame]
        ) {
        
        
        NSDictionary *parameters = @{@"area":_quhaozhi,@"name":self.accoutTF.text,@"code":self.codeTF.text,@"pwd":self.passwordAgainTF.text};
        [networking AFNPOST:@"" withparameters:parameters success:^(NSMutableDictionary *dic) {
        
            [MBProgressHUD showSuccess:CustomLocalizedString(@"密码修改成功", nil) toView:self.view.window];
            [self back];
        } error:nil HUDAddView:self.view];}
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
