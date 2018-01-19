//
//  MainCollectionViewCell.h
//  zaiShang
//
//  Created by cnmobi on 15/8/20.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneMaintainModel.h"
@interface PhoneMaintainCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImage;



@property (strong, nonatomic) IBOutlet UIButton *nameBtn;




-(void)fillCellWithModel:(PhoneMaintainModel*)model;
@end
