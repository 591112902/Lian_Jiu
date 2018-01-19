//
//  CouponTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/11/6.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"
@interface CouponTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *couponTitleL;


@property (strong, nonatomic) IBOutlet UILabel *couponMoneyL;


@property (strong, nonatomic) IBOutlet UILabel *endTimeL;



-(void)fillCellWithModel:(CouponModel*)model;

@end
