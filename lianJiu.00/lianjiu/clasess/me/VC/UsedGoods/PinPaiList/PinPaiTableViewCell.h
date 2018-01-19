//
//  PinPaiTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/10/10.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiaoLiangModel.h"


@interface PinPaiTableViewCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UIImageView *headIV;


@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UILabel *contentL;


@property (strong, nonatomic) IBOutlet UILabel *priceL;






-(void)fillCellWithModel:(XiaoLiangModel*)model;
@end
