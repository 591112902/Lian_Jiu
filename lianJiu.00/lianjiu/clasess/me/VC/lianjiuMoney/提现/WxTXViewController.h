//
//  WxTXViewController.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/29.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"


@interface WxTXViewController : UIViewController<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *nameTF;

@property (strong, nonatomic) IBOutlet UITextField *moneyTF;



- (IBAction)commitAction:(UIButton *)sender;

@end
