//
//  DCClassCategoryCell.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClassGoodsItem;

@interface DCClassCategoryCell : UITableViewCell

/* 标题数据 */
@property (strong , nonatomic)DCClassGoodsItem *titleItem;


/* 标题 */
@property (strong , nonatomic)UILabel *titleLabel;



@end
