//
//  QuPingLunViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/11/15.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"

#import "ShangMenOrderViewController.h"

@interface YiPingLunViewController : KeyboardViewController

@property (strong, nonatomic)NSString *relativeId;






@property (strong, nonatomic) IBOutlet UIButton *fBtn;
@property (strong, nonatomic) IBOutlet UIButton *sBtn;

@property (strong, nonatomic) IBOutlet UIButton *tBtn;








@property (strong, nonatomic) IBOutlet UIButton *firstL;

@property (strong, nonatomic) IBOutlet UIButton *secondL;

@property (strong, nonatomic) IBOutlet UIButton *threeL;







@property (strong, nonatomic) IBOutlet UITextView *contentTV;



- (IBAction)xiaoLianAction:(id)sender;


- (IBAction)xiaoLianAction2:(id)sender;

- (IBAction)xiaoLianAction3:(id)sender;



- (IBAction)commentAction:(id)sender;



- (IBAction)biaoQianAction:(id)sender;



@end
