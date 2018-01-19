//
//  BindingUser_ViewController.m
//  盒家健康(新版)
//
//  Created by 洪铭翔 on 17/10/16.
//  Copyright © 2017年 洪铭翔. All rights reserved.
//

#import "BindingUser_ViewController.h"
#import "PhoneTool.h"
#import "CalculateManager.h"
#import "UIColor+Util.h"
#import "UIViewController+Alert.h"

@interface BindingUser_ViewController ()
{
    NSInteger time;
    NSTimer *timer;
}
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *verificationCodeBtn;
@property (strong, nonatomic) IBOutlet UIButton *finishBtn;

@property (nonatomic, strong) UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;

//@property (nonatomic, strong) NSString *codeStr;

@end

@implementation BindingUser_ViewController

- (void)setFont {
    self.verificationCodeBtn.titleLabel.font = Calculate_Font(25);
    self.finishBtn.titleLabel.font = Calculate_Font(30);
    self.TitleLabel.font = Calculate_Font(27);
    
    self.phoneTextField.layer.borderWidth = 1;
    self.phoneTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.phoneTextField.layer.cornerRadius = 5;
    self.phoneTextField.layer.masksToBounds = YES;
    
    self.codeTextField.layer.borderWidth = 1;
    self.codeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.codeTextField.layer.cornerRadius = 5;
    self.codeTextField.layer.masksToBounds = YES;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    self.barStyle = Defaults;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setCreateTitle];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFont];
    self.title = @"绑定手机号码";
}
#pragma mark 判断是否需要显示时间
- (void)setCreateTitle {
    //然后创建日期对象
    NSDate *date1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"ForgetTime"];
    if (date1 == nil || ![date1 isKindOfClass:[NSDate class]]) {
        return;
    }
    NSDate *date = [NSDate date];
    //计算时间间隔（单位是秒）
    NSTimeInterval compatetTime = [date timeIntervalSinceDate:date1];
    //计算天数、时、分、秒
    int minutes = ((int)compatetTime)%(3600*24)%3600;
    if (minutes < 0) {
        minutes = -minutes;
    }
    if (minutes > 0) {
        time = 50 - minutes;
        [self timerStart];
    }
}
- (UILabel *)label {
    if (_label == nil) {
        [self.verificationCodeBtn layoutIfNeeded];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.verificationCodeBtn.frame.size.width, self.verificationCodeBtn.frame.size.height)];
        _label.userInteractionEnabled = YES;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = MAINColor;
        _label.textColor = [UIColor whiteColor];
        _label.font = Calculate_Font(25);
    }
    return _label;
}
- (void)timerStart {
    [self.verificationCodeBtn insertSubview:self.label aboveSubview:self.verificationCodeBtn.titleLabel];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(verificationCodeHandle) userInfo:nil repeats:YES];
    [timer fire];
}
- (void)timerStop {
    [timer invalidate];
    timer = nil;
    [self.label removeFromSuperview];
    [self.verificationCodeBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
    
}
- (void)verificationCodeHandle {
    time--;
    self.label.text = [NSString stringWithFormat:@"%ld", (long)time];
    if (time <= 0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ForgetTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self timerStop];
    }
}
- (void)LoginWithLoginType:(NSString *)loginType thirdPartyUserId:(NSString *)thirdPartyUserId  {
    __weak BindingUser_ViewController *weakSelf = self;
    
}
- (IBAction)finishAction:(id)sender {
//    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak BindingUser_ViewController *weakSelf = self;
   
    
    
    
    
    if (self.phoneTextField.text.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请输入你的手机号码" toView:self.view];
        return;
    }
    if (self.codeTextField.text.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请输入你的验证码" toView:self.view];
        return;
    }

//    
//        if (self.phoneTextField.text.length == 0) {
//    
//           self.phoneTextField.text=@" ";
//        }
//        if (self.codeTextField.text.length == 0) {
//    
//            self.codeTextField.text=@" ";
//        }

    
        NSDictionary *para ;
        if (_isWeiXin.length>0) {
            
             para = @{@"openId":self.openId?self.openId:@"",@"userPhone":self.phoneTextField.text,@"code":self.codeTextField.text,@"nickname":self.QWnickname?self.QWnickname:@"",@"picture":self.pictrue?self.pictrue:@"",@"type":@"0",@"udetailsEquipment":@"2",};
            
            
            
        }else{
            
            para = @{@"openId":self.openId?self.openId:@"",@"userPhone":self.phoneTextField.text,@"code":self.codeTextField.text,@"nickname":self.QWnickname?self.QWnickname:@"",@"picture":self.pictrue?self.pictrue:@"",@"type":@"1",@"udetailsEquipment":@"2",};
          
        }
      
        
        
//        //提示框
//        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message: [NSString stringWithFormat:@"%@",para] preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [clear addAction:quXiao];
//        [clear addAction:queRen];
//        [self presentViewController:clear animated:YES completion:nil];
        

        
        
        
        NSLog(@" para:%@",para);
    
    
    
    
    
    
    
        [networking AFNPOST:[NSString stringWithFormat:@"%@", CREATEUSER] withparameters:para success:^(NSMutableDictionary *dic) {
            
            NSLog(@"dic:%@  para:%@",dic,para);
            
            if ([dic[@"status"] integerValue] == 200) {

                NSDictionary *responseDic = dic[@"lianjiuData"];
                [MBProgressHUD showSuccess:@"登录成功" toView:self.view.window];
                NSLog(@"%@   %@ %@ ",dic,responseDic[@"userId"],responseDic[@"userPhone"]);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:responseDic[@"username"] forKey:@"username"];
                [defaults setObject:responseDic[@"userPhone"] forKey:@"userPhone"];
                [defaults setObject:responseDic[@"userId"] forKey:@"userId"];
                
                [defaults setBool:YES forKey:@"islogin"];
                [defaults setObject:[NSDate date] forKey:@"loginDate"];
                [defaults synchronize];
            
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }
            
        } error:^(NSError *error) {
            
        } HUDAddView:self.view];
        
    
}
- (IBAction)getCodeAction:(UIButton *)sender {
    if (![PhoneTool isMobileNumber:self.phoneTextField.text])
        [self alertWithTitle:@"提示" msg:@"请输入正确的手机号码！"];
    else {
//        self.hud = [MBProgressHUD showHUDAddedTo:self.view   animated:YES];
        
        __weak BindingUser_ViewController *weakSelf = self;
        
        [networking AFNRequest:[NSString stringWithFormat:@"%@/%@", SENDSMSBYBINGDING, self.phoneTextField.text] withparameters:nil success:^(NSMutableDictionary *dic) {
            NSLog(@"%@",dic);
            
            if ([dic[@"status"] integerValue] == 200) {
                //self.codeStr = dic[@"lianjiuData"];
                
                
                
                
                time = 300;
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"ForgetTime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self timerStart];

                
                
                
                
                
                
            }
        } error:^(NSError *error) {
            
        } HUDAddView:weakSelf.view];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
