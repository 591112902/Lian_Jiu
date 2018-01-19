//
//  DetailsTableViewCell.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MingXiDanModel.h"


@interface DetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orItemsNameL;


@property (strong, nonatomic) IBOutlet UILabel *orItemsNumL;


@property (strong, nonatomic) IBOutlet UILabel *orItemsBeforePriceL;




@property (strong, nonatomic) IBOutlet UIButton *zjmxBtn;







-(void)fillCellWithModel:(MingXiDanModel*)model;


@end
