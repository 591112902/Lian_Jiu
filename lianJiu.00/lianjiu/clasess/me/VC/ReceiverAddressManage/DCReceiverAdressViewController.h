//
//  DCReceiverAdressViewController.h
//  CDDMall
//
//  Created by apple on 2017/9/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeVC.h"
#import "MJRefresh.h"
@class DCAddressItem;

@protocol DCReceiverAdressVCdelegate <NSObject>

/** 跑马灯view上的关闭按钮点击时回调 */
- (void)requestSelectAddress:(DCAddressItem *)model;

@end

typedef void(^ReturnAddressBlock)(DCAddressItem *model);


@interface DCReceiverAdressViewController : UIViewController


@property (nonatomic, weak) id <DCReceiverAdressVCdelegate> delegate;

@property (nonatomic)BOOL isRequestData;//是否刷新数据


@property (nonatomic, copy) ReturnAddressBlock returnAddBlcok;

@property (nonatomic, assign) BOOL isNotJieSuan;


@end
