//
//  YetBdyhkViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BdyhkViewController.h"
#import "ModifyBdyhkViewController.h"
@interface YetBdyhkViewController : UIViewController

@property ( nonatomic)  BOOL isBdyhk;
@property (strong, nonatomic)  NSDictionary *bdyhkDic;


@property ( nonatomic)  BOOL isSMRZ;
@property (strong, nonatomic)  NSDictionary *smrzDic;


@property (strong, nonatomic) IBOutlet UILabel *nameL;

@property (strong, nonatomic) IBOutlet UILabel *idLabel;

@property (strong, nonatomic) IBOutlet UILabel *kaifuhL;

@property (strong, nonatomic) IBOutlet UILabel *kaHaoL;











@property (strong, nonatomic) IBOutlet UIButton *DeleteBdyhkBtn;


- (IBAction)ModifyBdyhkAction:(id)sender;


- (IBAction)DeleteBdyhkAction:(id)sender;






@end
