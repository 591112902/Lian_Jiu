//
//  SetUpMimaViewController.h
//  lianjiu
//
//  Created by LIHONG on 2018/1/3.
//  Copyright © 2018年 CNMOBI. All rights reserved.
//

#import "KeyboardViewController.h"

@interface SetUpMimaViewController : KeyboardViewController
@property (strong, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic)BOOL isTiaoGou;//是否返回首页

@end
