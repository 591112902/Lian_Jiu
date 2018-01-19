//
//  CommentTableViewCell.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/31.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentModel.h"
@interface EValuateRightCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *userL;

@property (strong, nonatomic) IBOutlet UILabel *timeL;

@property (strong, nonatomic) IBOutlet UILabel *cLabel1;

@property (strong, nonatomic) IBOutlet UILabel *cLabel2;

@property (strong, nonatomic) IBOutlet UILabel *cLabel3;

@property (strong, nonatomic) IBOutlet UIImageView *cImageView;

@property (strong, nonatomic) IBOutlet UILabel *contentL;





-(void)fillCellWithModel:(commentModel*)model;

@end
