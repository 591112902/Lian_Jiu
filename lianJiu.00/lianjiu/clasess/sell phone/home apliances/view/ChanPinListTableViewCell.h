//
//  ChanPinListTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChanPinListModel.h"
#import "UIImageView+WebCache.h"
@interface ChanPinListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftIV;


@property (strong, nonatomic) IBOutlet UILabel *nameL;


@property (strong, nonatomic) IBOutlet UILabel *priceL;





-(void)fillCellWithModel:(ChanPinListModel*)model;

@end
