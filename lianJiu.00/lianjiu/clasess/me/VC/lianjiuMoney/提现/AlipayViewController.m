//
//  WxTXViewController.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/29.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "AlipayViewController.h"
#import "CommitSuccseViewController.h"

@interface AlipayViewController ()

@property(nonatomic)BOOL isBackPreView;//返回上级页面

@end

@implementation AlipayViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isBackPreView) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝提现";
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    _moneyTF.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitAction:(UIButton *)sender {
    
    
    CommitSuccseViewController *CMVC = [[CommitSuccseViewController alloc] init];
    CMVC.title = @"提现成功";
    CMVC.contenValue = @"提现成功!";
    CMVC.subValue = @"款项将在24小时内到账";
    CMVC.image = [UIImage imageNamed:@"withdraw"];
    [self.navigationController pushViewController:CMVC animated:YES];
    //返回上级页面
    self.isBackPreView = YES;

  
}


#pragma mark - uitextFileDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]&&textField.text.length<1) {
        return NO;
    }
    
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    
    if (textField ==_moneyTF) {
        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toString.length > 0) {//(\\+|\\-)?
            //正则表达式，可输入正负，小数点前10位，小数点后2位，位数可控
            NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,9}(([.]\\d{0,2})?)))?";
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
            BOOL flag = [phoneTest evaluateWithObject:toString];
            if (!flag) {
                return NO;
            }
        }
        
    }
    
    return YES;
}








@end
