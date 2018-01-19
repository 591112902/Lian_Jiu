//
//  SetUpViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/10/11.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SetUpMimaViewController.h"

#import "ModifyPhoneVC.h"
#import "ModifyPassWordVC.h"

@interface SetUpViewController : UIViewController

@property (nonatomic)  BOOL isSetUpMiMa;

@property (strong, nonatomic)  NSString *phoneStr;

@property (strong, nonatomic) IBOutlet UIButton *setMIMaBtn;






- (IBAction)tuichudengluAction:(id)sender;



- (IBAction)setMimaAction:(id)sender;

- (IBAction)xiugaiPhoneAction:(id)sender;



- (IBAction)lianxiKefuAction:(id)sender;





@end
