//
//  YhkTxViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YhkTxViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSDictionary *lianjiuData;

@property (strong, nonatomic) IBOutlet UITextField *jineTF;

@property (strong, nonatomic) IBOutlet UILabel *userNameL;

@property (strong, nonatomic) IBOutlet UILabel *udetailsIdCardL;

@property (strong, nonatomic) IBOutlet UILabel *udetailsCardBankL;


@property (strong, nonatomic) IBOutlet UILabel *udetailsCardNoL;














- (IBAction)TxCommitAction:(id)sender;


@end
