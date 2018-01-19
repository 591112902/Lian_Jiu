//
//  OnlyTuiKuanViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodOrderManageTVController.h"
#import "GoodsOrderModel.h"

#import "KeyboardViewController.h"
#import "TuiMulPhotoCollectionViewController.h"
#import "UIImageView+WebCache.h"
#import "PhotoMultModel.h"
@interface TuihouAndkuanViewController : KeyboardViewController

@property(nonatomic,strong)TuiMulPhotoCollectionViewController *askPhotoVC;
@property (strong, nonatomic)GoodsOrderModel *model;


@property (nonatomic,strong) GoodOrderManageTVController *preVc;
@end
