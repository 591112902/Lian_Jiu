//
//  OnlyTuiKuanViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TuiMulPhotoCollectionViewController.h"
#import "KeyboardViewController.h"

#import "GoodsOrderModel.h"
#import "UIImageView+WebCache.h"
#import "PhotoMultModel.h"
@interface OnlyTuiKuanViewController : KeyboardViewController


@property(nonatomic,strong)TuiMulPhotoCollectionViewController *askPhotoVC;




@property (strong, nonatomic)GoodsOrderModel *model;

@end
