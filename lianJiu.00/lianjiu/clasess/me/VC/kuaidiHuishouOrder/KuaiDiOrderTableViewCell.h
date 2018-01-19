//
//  MyOrderTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KuaiDiOrderModel.h"
@interface KuaiDiOrderTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *orExpressIdL;

@property (strong, nonatomic) IBOutlet UILabel *orExpressStatusLL;


@property (strong, nonatomic) IBOutlet UIImageView *imageIV;

@property (strong, nonatomic) IBOutlet UITextView *productNameTV;


@property (strong, nonatomic) IBOutlet UILabel *pinggujiaLL;

@property (strong, nonatomic) IBOutlet UILabel *orExpressEvaluatedPriceL;

@property (strong, nonatomic) IBOutlet UILabel *productNumLL;


@property (strong, nonatomic) IBOutlet UILabel *orExpressCreatedL;


@property (strong, nonatomic) IBOutlet UIButton *firstBtn;



@property (strong, nonatomic) IBOutlet UIButton *secondBtn;





@property (strong, nonatomic) IBOutlet UILabel *dhL;


@property (strong, nonatomic) IBOutlet UILabel *leftpingGUL;


@property (strong, nonatomic) IBOutlet UILabel *leftPingGPriceL;








-(void)fillCellWithModel:(KuaiDiOrderModel *)model;



@end
