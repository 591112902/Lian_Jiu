//
//  ChanPinListTableViewCell.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetUpListModel.h"
#import "CommitListModel.h"
#import "UIImageView+WebCache.h"
@interface SetUpListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *headLine;

@property (strong, nonatomic) IBOutlet UILabel *rightLine;

@property (strong, nonatomic) IBOutlet UILabel *bottomLine;

@property (strong, nonatomic) IBOutlet UILabel *cneter1Line;

@property (strong, nonatomic) IBOutlet UILabel *leftLine;

@property (strong, nonatomic) IBOutlet UILabel *center2Line;

@property (strong, nonatomic) IBOutlet UILabel *h0L;


@property (strong, nonatomic) IBOutlet UILabel *h1L;


@property (strong, nonatomic) IBOutlet UILabel *h2L;










@property (strong, nonatomic) IBOutlet UILabel *nameL;
@property (strong, nonatomic) IBOutlet UILabel *priceSingleL;
@property (strong, nonatomic) IBOutlet UILabel *bulkNumL;
@property (strong, nonatomic) IBOutlet UITextField *bulkNumTF;
@property (strong, nonatomic) IBOutlet UILabel *bulkNum_UnitLL;




-(void)fillCellWithModel:(SetUpListModel*)model;

-(void)fillCellWithCModel:(CommitListModel*)model;
@end
