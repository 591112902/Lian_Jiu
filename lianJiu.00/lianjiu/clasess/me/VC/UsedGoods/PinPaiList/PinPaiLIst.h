//
//  
//  zaiShang
//
//  Created by cnmobi on 17/5/24.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLSlideMenu.h"

//#import "AccountModel.h"
//#import "MeVC.h"

#import "XiaoLiangModel.h"
#import "LLSearchViewController.h"
#import "UsedGoodsDetailVC.h"

@interface PinPaiLIst : UIViewController


@property(nonatomic,strong)NSString *mingcheng;


//@property (nonatomic,strong)AccountModel *userModel;
//@property (nonatomic,strong)MeVC *preVC;
@property(nonatomic,strong)UITableView *tableView;


@property (nonatomic,strong)NSMutableDictionary *parameters1;
@property (nonatomic,strong)NSMutableDictionary *parameters2;
@property (nonatomic,strong)NSMutableDictionary *parameters3;


@property (nonatomic,strong)NSMutableArray *dataSouc;
@property (nonatomic,strong)UIButton *currBtn;
@property (nonatomic,strong)NSMutableArray *TenderVo;//招标数据源 tag 400
@property (nonatomic,strong)NSMutableArray *PurchaseVo;//供应数据源 tag 401
@property (nonatomic,strong)NSMutableArray *SupplyVo;//采购数据源


@property(nonatomic,strong)UIView *secondView;

@end
