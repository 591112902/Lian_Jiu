//
//  UsedGoodsDetailVC.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/19.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsedGDheadView.h"
#import "LoginViewController.h"
@interface UsedGoodsDetailVC : UIViewController

@property(nonatomic,strong)NSString*productId;

@property(nonatomic,strong) UsedGDheadView *headerView;
//@property (nonatomic) UsedGDheadView *headerView;

@end
