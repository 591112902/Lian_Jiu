//
//  FaHuoViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
@interface FaHuoViewController : KeyboardViewController


@property (strong, nonatomic)  NSString *isME;



@property (strong, nonatomic)  NSString *ordersId;

@property (strong, nonatomic) IBOutlet UIButton *sureBtn;


@property (strong, nonatomic) IBOutlet UITextField *kdDanHaoTF;



@end
