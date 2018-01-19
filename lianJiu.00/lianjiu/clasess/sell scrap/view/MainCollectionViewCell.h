//
//  MainCollectionViewCell.h
//  zaiShang
//
//  Created by cnmobi on 15/8/20.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrapModel.h"
@interface MainCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UIImageView *v_typeImageView;





-(void)fillCellWithModel:(ScrapModel*)model;
@end
