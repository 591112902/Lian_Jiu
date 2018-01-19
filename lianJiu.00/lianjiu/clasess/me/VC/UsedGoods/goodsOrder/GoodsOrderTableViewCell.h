//
//  MyOrderTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
@interface GoodsOrderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orItemsNameL;

@property (strong, nonatomic) IBOutlet UILabel *stateL;


@property (strong, nonatomic) IBOutlet UIImageView *orItemsPictureIV;

@property (strong, nonatomic) IBOutlet UITextView *orItemsParamL;

@property (strong, nonatomic) IBOutlet UILabel *orItemsCreatedL;


@property (strong, nonatomic) IBOutlet UILabel *orItemsPriceL;



@property (strong, nonatomic) IBOutlet UIButton *firstBtn;


@property (strong, nonatomic) IBOutlet UIButton *secondBtn;


@property (strong, nonatomic) IBOutlet UIButton *threeBtn;



@property (strong, nonatomic) IBOutlet UILabel *kuaidiDanHaoL;




-(void)fillCellWithModel:(GoodsOrderModel *)model;



@end
