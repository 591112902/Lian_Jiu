//
//  RegisterViewController.h
//  zaiShang
//
//  Created by cnmobi on 15/8/29.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//
#import "XWCountryCodeController.h"
#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"


@interface RegisterViewController2 : KeyboardViewController<XWCountryCodeControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *quHaoBtn;
@property(nonatomic,strong)NSString *quhaozhi;
- (IBAction)quHaoBtmClick:(id)sender;
@end
