//
//  Modify_PriceTableViewCell.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

@interface ScrapDetailTableViewCell : UITableViewCell<PPNumberButtonDelegate>


@property (nonatomic, strong) UILabel *danweiL;




@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UILabel *leftL1;
@property (nonatomic, strong) UILabel *rightL1;
@property (nonatomic, strong) UILabel *leftL2;
@property (nonatomic, strong) UILabel *rightL2;
@property (nonatomic, strong) UILabel *leftL4;
@property (nonatomic, strong) UILabel *rightL4;


@property (nonatomic, strong) UILabel *leftL;
//@property (nonatomic, strong) UILabel *rightL;
@property (nonatomic, strong) UIButton *assessBtn;
//@property (nonatomic, strong) PPNumberButton *numberButton;
@property (nonatomic, copy) void(^resultBlock)(NSInteger number);



@end
