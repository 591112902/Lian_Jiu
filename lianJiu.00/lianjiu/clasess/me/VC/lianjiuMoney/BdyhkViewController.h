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

@interface BdyhkViewController : UIViewController


@property (strong, nonatomic) NSString  *genxinYHK;
@property (strong, nonatomic) NSString  *udetailsId;



@property ( nonatomic)  BOOL isSMRZ;
@property (strong, nonatomic)  NSDictionary *smrzDic;



@property (strong, nonatomic)  NSDictionary *bdyhkDic;





@property (strong, nonatomic) IBOutlet UILabel *nameL;


@property (strong, nonatomic) IBOutlet UILabel *idLabel;




@property (strong, nonatomic) IBOutlet UITextField *udetailsCardBankTF;


@property (strong, nonatomic) IBOutlet UITextField *udetailsCardNoTF;





@property (strong, nonatomic) IBOutlet UIButton *getCodeBtn;





@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;





//@property (weak, nonatomic) IBOutlet GraphCodeView *graphCodeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;



@property (strong, nonatomic) IBOutlet UIButton *bdyhkButton;




- (IBAction)bangdingAction:(id)sender;



//- (IBAction)getCode:(id)sender;


- (IBAction)getCodeAction:(id)sender;




@end
