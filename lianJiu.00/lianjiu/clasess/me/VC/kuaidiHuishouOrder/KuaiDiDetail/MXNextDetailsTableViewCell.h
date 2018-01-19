//
//  DetailsTableViewCell.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JinQiJiaModel.h"


@interface MXNextDetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orItemsNameL;





@property (strong, nonatomic) IBOutlet UILabel *orItemsPriceL;




@property (strong, nonatomic) IBOutlet UIButton *zjbgBtn;


@property (strong, nonatomic) IBOutlet UIImageView *headIV;





-(void)fillCellWithModel:(JinQiJiaModel*)model;


@end
