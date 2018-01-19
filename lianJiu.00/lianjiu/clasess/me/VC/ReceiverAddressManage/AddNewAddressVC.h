//
//  AddNewAddressVC.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/25.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCReceiverAdressViewController.h"
#import "DCAddressItem.h"
#import "KeyboardViewController.h"
#import "ShangMenFillinOrderVC.h"
#import "DCFillinOrderViewController.h"
#import "WeiXiuOrderViewController.h"
typedef void(^ReturnAddressBlock)(DCAddressItem *model);


@interface AddNewAddressVC : KeyboardViewController


@property (nonatomic,strong) DCReceiverAdressViewController *preVc;

@property (nonatomic,strong) DCAddressItem *addressEditModel;

@property (strong, nonatomic) IBOutlet UITextField *nameTF;

@property (strong, nonatomic) IBOutlet UITextField *phoneTF;

@property (strong, nonatomic) IBOutlet UIButton *addressBtn;

@property (strong, nonatomic) IBOutlet UITextView *menpaiTF;

@property (strong, nonatomic) IBOutlet UIView *morenView;

@property (strong, nonatomic) IBOutlet UIButton *saveBtn;

@property (strong, nonatomic) NSString *isEdit;



@property (nonatomic, copy) ReturnAddressBlock returnAddBlcok;

@property (nonatomic, assign) BOOL isNotJieSuan;



- (IBAction)addressBtnAction:(UIButton *)sender;


- (IBAction)saveBtnAction:(id)sender;

- (IBAction)morenSwitchAction:(id)sender;



@end
