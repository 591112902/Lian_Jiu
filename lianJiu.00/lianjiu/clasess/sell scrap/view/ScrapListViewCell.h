//
//  ScrapListViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/8.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrapListViewModel.h"
@interface ScrapListViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *leftIV;


@property (strong, nonatomic) IBOutlet UILabel *nameL;


@property (strong, nonatomic) IBOutlet UILabel *priceL;


-(void)fillCellWithModel:(ScrapListViewModel*)model;

@end
