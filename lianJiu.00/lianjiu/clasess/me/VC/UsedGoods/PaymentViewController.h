//
//  PaymentViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/28.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@interface PaymentViewController : UIViewController


@property(nonatomic,strong) NSString *goodImageViewStr;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *nameDetail;
@property (strong, nonatomic) NSString *orderID;



@property (strong, nonatomic) IBOutlet UIImageView *goodImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameL;


@property (strong, nonatomic) IBOutlet UILabel *nameDetailL;

@property (strong, nonatomic) IBOutlet UILabel *priceL;






@property (strong, nonatomic) IBOutlet UIButton *weixinPayBtn;

@property (strong, nonatomic) IBOutlet UIButton *aliPayBtn;

@property (strong, nonatomic) IBOutlet UIButton *lianjiuPayBtn;





- (IBAction)weixinPayAction:(id)sender;

- (IBAction)alipayAction:(id)sender;

- (IBAction)lianjiuPayAction:(id)sender;


@end
