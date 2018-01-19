//
//  SegmentViewController.h
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "SegmentPageBaseViewController.h"
#import "commentModel.h"
#import "OderViewController.h"


@interface SegmentViewController : SegmentPageBaseViewController


@property (nonatomic, assign) BOOL isPhone;



@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSString *tokenS;


@property (nonatomic,strong) NSString *typeStr;

@property (nonatomic,strong) NSString *productId;






@property (nonatomic,strong)NSMutableArray *dataSourPL;
@property (nonatomic,strong)NSMutableArray *dataSour;


-(void)reloadJQTableView;

@end
