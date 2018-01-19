//
//  ShoppingCarCell.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingModel.h"



//@protocol BWYShoppingCarDelegate <NSObject>
//
//
//
//@end


@protocol ShoppingCarCellDelegate

- (void)isDelet:(UITableViewCell *)cell andDeletButtonTag:(NSInteger)deletTag;

@end


@interface ShoppingCarCell : UITableViewCell



@property (nonatomic,strong) UILabel *numberTitleLab;//商品数量



@property (nonatomic,strong) UIImageView *checkImg;

@property (nonatomic,strong) UIImageView *shopImageView;

@property (nonatomic,strong) UILabel *shopNameLab;

@property (nonatomic,strong) UILabel *priceLab;




@property (nonatomic,strong) UILabel *shopTypeLab;//商品型号

@property (nonatomic,strong) UIButton *jianBtn;//减数量按钮

@property (nonatomic,strong) UIButton *addBtn;//加数量按钮

@property (nonatomic,strong) UILabel *numberLab;//显示数量

@property (nonatomic,strong) ShoppingModel *shoppingModel;

@property (assign,nonatomic) BOOL selectState;//选中状态





@property (nonatomic,strong)UIButton * deletButton;
@property (nonatomic,assign)id<ShoppingCarCellDelegate>delegate;


@end


