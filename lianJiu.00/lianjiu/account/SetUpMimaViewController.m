//
//  SetUpMimaViewController.m
//  lianjiu
//
//  Created by LIHONG on 2018/1/3.
//  Copyright © 2018年 CNMOBI. All rights reserved.
//

#import "SetUpMimaViewController.h"
#import "validate.h"
@interface SetUpMimaViewController ()

@end

@implementation SetUpMimaViewController

-(void)tiaoGoguAction{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isTiaoGou) {
        UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(tiaoGoguAction) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setFrame:CGRectMake(0, 0, 59, 20)];//59 67
        // 使用自定义的按钮初始化一个导航条按钮
        UIBarButtonItem* rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        // 使用数组给导航条添加多个控件
        self.navigationItem.rightBarButtonItem = rightBarBtn;
    }
    
    
    
    
//    self.accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.secureTextEntry  = YES;
    self.accountTF.secureTextEntry  = YES;
    
    
    [self addRightView:self.passwordTF];
    [self addRightView:self.accountTF];
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 40)];
//    [btn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
//    btn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 5);
//    [btn addTarget:self action:@selector(PasswordMingWen:) forControlEvents:UIControlEventTouchUpInside];
//    btn.highlighted = NO;
//    
//    self.passwordTF.rightView = btn;
//    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
//    
//    self.accountTF.rightView = btn;
//    self.accountTF.rightViewMode= UITextFieldViewModeAlways;
    
    self.title = @"设置密码";

    // Do any additional setup after loading the view from its nib.
}


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


-(void)PasswordMingWen:(UIButton *)sender//  password 明文
{
    sender.selected = !sender.selected;
    
    UITextField *textf = (UITextField *)sender.superview;
    textf.secureTextEntry  = !textf.secureTextEntry;
    
   // self.passwordTF.secureTextEntry  = !self.passwordTF.secureTextEntry;
}

- (IBAction)ToLogin:(id)sender {
    //以下写会出现问题 text 不等于空  也可以  self.accountTF.text.length=0;
    
    //[validate CheckInput:@"密码" withString:self.passwordTF.text wihtString2:self.accountTF.text];
    
    if (self.accountTF.text.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请输入密码" toView:self.view];
        return;
    }
    
    if (self.accountTF.text.length < 6) {
        
        [MBProgressHUD showNotPhotoError:@"密码长度至少6位" toView:self.view];
        return;
    }
    
    
    if (self.passwordTF.text.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请再次输入密码" toView:self.view];
        return;
    }
    
    
    if (self.passwordTF.text.length < 6) {
        
        [MBProgressHUD showNotPhotoError:@"密码长度至少6位" toView:self.view];
        return;
    }
    
    
    
    
    
    
    
    if (![self.accountTF.text isEqualToString:@""]&&![self.passwordTF.text isEqualToString:@""]&& [validate CheckInput:@"密码" withString:self.passwordTF.text wihtString2:self.accountTF.text]) {
        if ([self CheckInputEail:self.accountTF.text]) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults objectForKey:@"userId"];
            
            [networking AFNPOSTNotCode:[NSString stringWithFormat:@"%@/%@/%@",MODIFYPWD,[defaults objectForKey:@"userId"],self.accountTF.text] withparameters:nil success:^(NSMutableDictionary *dic) {
                //                HZLog(@"%@---%@",dic,dic[@"message"]);
                NSNumber *status=dic[@"status"];
                if ([status isEqualToNumber:@200]) {
                    
                    if (_isTiaoGou) {
                        
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                        
                    }else{
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    
                }else{
                    
                    [MBProgressHUD showError:dic[@"msg"] toView:self.view];
                    
                }
                
            } error:nil HUDAddView:self.view];
            
        }
        
    }else{
        [MBProgressHUD showNotPhotoError:@"账户或密码不能为空" toView:self.view];
    }
}




//4、判断邮箱
- (BOOL)CheckInputEail:(NSString *)text {
    return YES;
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

@end
