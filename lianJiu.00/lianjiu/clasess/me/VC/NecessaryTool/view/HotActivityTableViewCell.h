//
//  HotActivityTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/11/6.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotActivityModel.h"
#import "UIImageView+WebCache.h"

@interface HotActivityTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *hotTitleL;

@property (strong, nonatomic) IBOutlet UIImageView *hotIV;

@property (strong, nonatomic) IBOutlet UILabel *hotTimeL;




-(void)fillCellWithModel:(HotActivityModel*)model;


@end
