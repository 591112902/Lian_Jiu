//
//  BdyhkViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphCodeView.h"//图形验证码
#import "NSString+random.h"

@interface ModifyBdyhkViewController : UIViewController


@property ( nonatomic)  BOOL isBdyhk;
@property (strong, nonatomic)  NSDictionary *bdyhkDic;


@property ( nonatomic)  BOOL isSMRZ;
@property (strong, nonatomic)  NSDictionary *smrzDic;








@property (weak, nonatomic) IBOutlet GraphCodeView *graphCodeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;


- (IBAction)bangdingAction:(id)sender;



- (IBAction)getCode:(id)sender;



@end
