//
//  ChooseConditionVC.h
//  lianjiu
//
//  Created by 123 on 17/11/6.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EvaluateViewController.h"

@interface ChooseConditionVC : UIViewController


@property (nonatomic, assign) BOOL isPhoneNotJD;

@property (strong,nonatomic)  NSString   *productID;
@property (strong,nonatomic)  NSString   *titleStr;

@property (nonatomic, strong) NSString *productPrice;

@property (nonatomic, strong) NSString *productMasterPicture;

@end
