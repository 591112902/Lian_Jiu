//
//  ModifyPhoneVC.h
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyNewPhoneVC : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *getCodeBtn;



@property (strong, nonatomic) IBOutlet UITextField *phoneTF;

@property (strong, nonatomic) IBOutlet UITextField *codeTF;






- (IBAction)sureBtnAction:(id)sender;





- (IBAction)codeBtnAction:(UIButton *)sender;




@end
