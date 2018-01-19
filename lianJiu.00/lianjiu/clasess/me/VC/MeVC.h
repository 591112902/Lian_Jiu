//
//  ViewController.h
//  demo
//
//  Created by zhong on 17/1/16.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "SetUpViewController.h"
#import "AccountModel.h"
#import "UIImageView+WebCache.h"
#import "WeiOrderViewController.h"
#import "LianjiuMoneyVC.h"
#import "KuaiDiOrderViewController.h"
#import "ComeDoorRecycleCarViewController.h"
#import "ShangMenOrderViewController.h"
#import "CallBackCarViewController.h"
#import "HelpCenterVC.h"
#import "DaZongOrderViewController.h"

@interface MeVC : UIViewController
@property (nonatomic)BOOL isRequestData;//是否刷新数据

@property (nonatomic,strong)AccountModel *userModel;

@end

