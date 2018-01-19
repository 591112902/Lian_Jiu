//
//  SmrzViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmrzViewController : UIViewController


@property ( nonatomic)  BOOL isSMRZ;
@property (strong, nonatomic)  NSDictionary *smrzDic;



@property (strong, nonatomic) IBOutlet UITextField *nameTF;

@property (strong, nonatomic) IBOutlet UITextField *idTF;

@property (strong, nonatomic) IBOutlet UILabel *promtL;

@property (strong, nonatomic) IBOutlet UIButton *comitBtn;




- (IBAction)commitAction:(id)sender;



@end
