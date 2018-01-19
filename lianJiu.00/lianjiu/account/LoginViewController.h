//
//  LoginViewController.h
//  zaiShang
//
//  Created by cnmobi on 15/12/5.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "DXLoginViewController.h"

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"

#import "SetUpMimaViewController.h"
@interface LoginViewController : KeyboardViewController
@property (nonatomic)BOOL isBackMain;//是否返回首页


//@property (nonatomic)BOOL isXiuMiMa;//是否xiuggimima

@property (strong, nonatomic) IBOutlet UIImageView *loginIV;






@property (strong, nonatomic) IBOutlet UIButton *duanxindlBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;



- (IBAction)dxLoginAction:(id)sender;

- (IBAction)qqLoginAction:(id)sender;

- (IBAction)wxLoginAction:(id)sender;

@end
