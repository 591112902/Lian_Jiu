//
//  JMSApplyViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/11/23.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "KeyboardViewController.h"


@interface JMSApplyViewController : KeyboardViewController


@property (strong, nonatomic) IBOutlet UITextField *nameTF;

@property (strong, nonatomic) IBOutlet UITextField *lxfsTF;

@property (strong, nonatomic) IBOutlet UITextField *lxAddressTF;

@property (strong, nonatomic) IBOutlet UITextView *khsRangeTV;

@property (strong, nonatomic) IBOutlet UITextField *khsKindTF;


- (IBAction)lxAddressBtnAction:(id)sender;


- (IBAction)sqJoinAction:(id)sender;



@end
