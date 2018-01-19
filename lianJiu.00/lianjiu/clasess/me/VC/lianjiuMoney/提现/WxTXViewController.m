//
//  WxTXViewController.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/29.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WxTXViewController.h"
#import "CommitSuccseViewController.h"
@interface WxTXViewController ()
@property(nonatomic)BOOL isBackPreView;//返回上级页面


@end

@implementation WxTXViewController

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
    self.title = @"微信提现";
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
    
    if (_nameTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入姓名" toView:self.view];
        return;
    }
    if (_moneyTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入金额" toView:self.view];
        return;
    }
    
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *vip = [def objectForKey:@"userId"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"userId":vip, @"money":_moneyTF.text,@"openid":@"1",@"name":_nameTF.text}];
    
    [networking AFNPOST:TXPAYOTHER withparameters:parameters success:^(NSMutableDictionary *dic) {
        
        HZLog(@"%@",dic);
        CommitSuccseViewController *CMVC = [[CommitSuccseViewController alloc] init];
        CMVC.title = self.title;
        CMVC.contenValue = @"微信提现成功";
        // CMVC.subValue = CustomLocalizedString(@"提现款项将原路退回到用户支付账户.零钱即时到账;银行卡(储蓄卡及信用卡)1-3个工作日", nil);
        CMVC.image = [UIImage imageNamed:@"sucsses"];
        [self.navigationController pushViewController:CMVC animated:YES];
        //返回上级页面
        self.isBackPreView = YES;
        
    } error:^(NSError *error) {
        HZLog(@"%@", error.userInfo);
    } HUDAddView:self.view];

    
    
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
