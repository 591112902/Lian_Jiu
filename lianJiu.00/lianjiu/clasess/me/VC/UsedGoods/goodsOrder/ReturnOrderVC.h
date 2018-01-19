//
//  ReturnOrderVC.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
@interface ReturnOrderVC : UIViewController

@property (strong, nonatomic)GoodsOrderModel *model;


@property (strong, nonatomic) IBOutlet UITextField *kdPingTaiTF;

@property (strong, nonatomic) IBOutlet UITextField *danHaoTF;







- (IBAction)commitAction:(id)sender;


@end
