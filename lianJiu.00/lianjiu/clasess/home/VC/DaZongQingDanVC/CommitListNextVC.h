//
//  CommitListNextVC.h
//  lianjiu
//
//  Created by LIHONG on 2018/1/15.
//  Copyright © 2018年 CNMOBI. All rights reserved.
//

#import "KeyboardViewController.h"
#import "DaZongOrderViewController.h"
@interface CommitListNextVC : KeyboardViewController

@property(nonatomic,strong) NSString *allPrice;




@property (strong, nonatomic) IBOutlet NSLayoutConstraint *readBtnLeft;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *readLabelLetf;


@property (strong, nonatomic) IBOutlet UILabel *allPriceL;

@property (strong, nonatomic) IBOutlet UITextField *lxrNameTF;

@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UIButton *readBtn;

@property (strong, nonatomic) IBOutlet UIView *roundView;

@property (strong, nonatomic) IBOutlet UILabel *ckAddressL;










- (IBAction)commitAction:(id)sender;



- (IBAction)readBtnAction:(UIButton *)sender;


@end
