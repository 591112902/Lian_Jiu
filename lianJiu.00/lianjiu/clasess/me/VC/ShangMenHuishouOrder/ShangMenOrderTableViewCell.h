//
//  MyOrderTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangMenOrderModel.h"
@interface ShangMenOrderTableViewCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel *orFacefaceIdL;


@property (strong, nonatomic) IBOutlet UILabel *orFacefaceStatusLL;


@property (strong, nonatomic) IBOutlet UIImageView *maxImageIV;


@property (strong, nonatomic) IBOutlet UILabel *orFfDetailsPriceL;


@property (strong, nonatomic) IBOutlet UILabel *orFfDetailsRetrPrice;


@property (strong, nonatomic) IBOutlet UILabel *usernamePhoneLL;

@property (strong, nonatomic) IBOutlet UILabel *orFacefaceUpdatedLL;










@property (strong, nonatomic) IBOutlet UIButton *firstBtn;



@property (strong, nonatomic) IBOutlet UIButton *secondBtn;






-(void)fillCellWithModel:(ShangMenOrderModel *)model;



@end
