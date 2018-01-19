//
//  ModifyPassWordVC.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "validate.h"
#import "LoginViewController.h"

@interface ModifyPassWordVC : UIViewController


@property(nonatomic,strong) NSString *phoneStr;


@property (strong, nonatomic) IBOutlet UILabel *phoneL;


@property (strong, nonatomic) IBOutlet UIButton *getCodeBtn;


@property (strong, nonatomic) IBOutlet UITextField *password;


@property (strong, nonatomic) IBOutlet UITextField *passwordAgain;


@property (strong, nonatomic) IBOutlet UITextField *codeTF;



- (IBAction)getCodeBtnClick:(id)sender;



- (IBAction)sureAction:(id)sender;



@end
