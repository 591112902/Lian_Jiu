//
//  EvaluateLeftCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/12.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JinQiJiaModel.h"
@interface EvaluateLeftCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UIImageView *headIV;

@property (strong, nonatomic) IBOutlet UILabel *nameL;

@property (strong, nonatomic) IBOutlet UILabel *userL;

@property (strong, nonatomic) IBOutlet UILabel *hiuhsouTypeL;


@property (strong, nonatomic) IBOutlet UILabel *timeL;



@property (strong, nonatomic) IBOutlet UILabel *priceL;



@property (strong, nonatomic) IBOutlet UIButton *zjbgBtn;






-(void)fillCellWithModel:(JinQiJiaModel*)model;


@end
