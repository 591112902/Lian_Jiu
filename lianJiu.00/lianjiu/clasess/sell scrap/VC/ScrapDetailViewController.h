//
//  ScrapDetailViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/8.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrapDetailModel.h"
#import "PPNumberButton.h"
#import "EvaluateFooterView.h"
#import "ComeDoorRecycleCarViewController.h"
#import "CallBackCarViewController.h"
#import "KeyboardViewController.h"
#import "ScrapDetailFooterView.h"
#import "LoginViewController.h"
@interface ScrapDetailViewController : KeyboardViewController

@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic,strong) NSString *wPriceId;
@property (nonatomic,strong) NSString *name;




@property (nonatomic,strong) NSString *wPriceSingle;
@property (nonatomic,strong) NSString *wPriceUnit;
@property (nonatomic,strong) NSString *wasteImage;


@end
