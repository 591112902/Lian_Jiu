//
//  ForgotViewController.h
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//
#import "XWCountryCodeController.h"
#import "KeyboardViewController.h"

@interface zfForgotViewController2 : KeyboardViewController<XWCountryCodeControllerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *quhaoForgotBtn;




// 修改密码成功
@property(nonatomic,strong)NSNumber *number;//忘记支付密码
typedef void (^SetSeccess)( NSString *passPwd);
- (void)addRightView:(UITextField *)textField;
- (void)addRightViewSJ:(UITextField *)textField;


- (IBAction)quhaoForgot:(id)sender;


@end
