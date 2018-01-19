//
//  EvaluateViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/12.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComeDoorRecycleCarViewController.h"
#import "RecycleCarViewController.h"
#import "KuaiDiOrderViewController.h"
#import "JinQiJiaModel.h"
#import "ShangMenFillinOrderVC.h"
#import "ExpressRecycleOrderVC.h"
#import "CallBackCarViewController.h"
#import "PLSegmentViewController.h"
#import "ProductModel.h"
#import "LoginViewController.h"
#import "JDEvaluateHeadView.h"
@interface EvaluateViewController : UIViewController


@property (nonatomic, assign) BOOL isPhoneNotJD;


//@property(nonatomic ,strong) NSString *isJiaDianOrPhone;
@property(nonatomic ,strong) NSString *titleStr;
//@property(nonatomic ,strong) NSString *orItemsParam;
@property(nonatomic ,strong) NSString *tokenStr;


//@property(nonatomic ,strong) NSString *productId;
//@property(nonatomic ,strong) NSString *picture;
//@property(nonatomic ,strong) NSString *priceS;
@end
