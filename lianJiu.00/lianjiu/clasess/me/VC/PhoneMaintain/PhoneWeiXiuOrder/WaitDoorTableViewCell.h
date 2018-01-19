//
//  WaitDoorTableViewCell.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/1.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiXiuOrderModel.h"
@interface WaitDoorTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orRepairCreatedL;

@property (strong, nonatomic) IBOutlet UILabel *orRepairUserPhoneL;

@property (strong, nonatomic) IBOutlet UILabel *priceL;


@property (strong, nonatomic) IBOutlet UILabel *orRepairSchemeL;


@property (strong, nonatomic) IBOutlet UILabel *orRepairIdL;


@property (strong, nonatomic) IBOutlet UILabel *orRepairStatusL;






@property (strong, nonatomic) IBOutlet UIButton *paymentBtn;



-(void)fillCellWithModel:(WeiXiuOrderModel*)model;


@end
