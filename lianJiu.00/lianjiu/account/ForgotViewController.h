//
//  ForgotViewController.h
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "KeyboardViewController.h"

@interface ForgotViewController : KeyboardViewController

// 修改密码成功
//@property(nonatomic,strong)NSNumber *number;//忘记支付密码
typedef void (^SetSeccess)( NSString *passPwd);

- (void)addRightView:(UITextField *)textField;
- (void)addRightViewSJ:(UITextField *)textField;
- (void)addRightViewSJ2:(UITextField *)textField;

@end