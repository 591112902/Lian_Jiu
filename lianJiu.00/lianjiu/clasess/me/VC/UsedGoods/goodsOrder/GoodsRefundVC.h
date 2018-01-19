//
//  GoodsRefundVC.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodOrderManageTVController.h"
#import "GoodsOrderModel.h"
@interface GoodsRefundVC : UIViewController

@property (nonatomic,strong) GoodOrderManageTVController *preVc;


@property(nonatomic)BOOL isBackPreView;//返回上级页面


@property (strong, nonatomic)GoodsOrderModel *model;

@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UIImageView *headIV;


@property (strong, nonatomic) IBOutlet UITextView *contentTV;


- (IBAction)onlyTuiKuanAction:(id)sender;

- (IBAction)tuihouAndkuanAction:(id)sender;




@end
