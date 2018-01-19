//
//  PingJiaTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/26.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PingJiaModel.h"
@interface PingJiaTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *usernameL;

@property (strong, nonatomic) IBOutlet UILabel *timeL;


@property (strong, nonatomic) IBOutlet UILabel *detailL;


-(void)fillCellWithModel:(PingJiaModel*)model;


@end
