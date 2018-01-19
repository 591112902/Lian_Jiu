//
//  TXVC.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/29.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YhkTxViewController.h"

#import "ErWeiMaWxViewController.h"
@interface TXVC : UIViewController


@property (strong, nonatomic) IBOutlet UIView *wxView;


@property (strong, nonatomic) IBOutlet UIView *alipayView;


@property (strong, nonatomic) IBOutlet UIButton *wxBtn;

@property (strong, nonatomic) IBOutlet UIButton *alipayBtn;


@property (strong, nonatomic) IBOutlet UIView *yhkView;


@property (strong, nonatomic) IBOutlet UIButton *yhkBtn;







- (IBAction)nextAction:(UIButton *)sender;

@end
