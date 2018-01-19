//
//  DCReceiverAddressCell.h
//  CDDMall
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCAddressItem.h"

@interface DCReceiverAddressCell : UITableViewCell
/* 地址数组 */
@property (strong , nonatomic)DCAddressItem *adItem;

/* 默认地址 */
@property (strong , nonatomic)UIButton *defaultAddressButton;
/* 编辑 */
@property (strong , nonatomic)UIButton *editButton;
/* 删除 */
@property (strong , nonatomic)UIButton *deleteButton;
@property (nonatomic, assign) BOOL isSelect;






/** 默认地址点击回调 */
@property (nonatomic, copy) void(^dSelectBlock)(BOOL choice,NSInteger btntag);


//@property (nonatomic, copy) dispatch_block_t defaultClickBlock;
/** 编辑点击回调 */
@property (nonatomic, copy) dispatch_block_t editClickBlock;
/** 删除点击回调 */
@property (nonatomic, copy) dispatch_block_t delectClickBlock;




-(void)fillCellWithModel:(DCAddressItem*)model;



@end
