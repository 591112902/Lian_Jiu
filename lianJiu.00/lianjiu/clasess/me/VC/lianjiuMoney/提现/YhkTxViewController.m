//
//  YhkTxViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "YhkTxViewController.h"
#import "CommitSuccseViewController.h"
@interface YhkTxViewController ()
@property(nonatomic)BOOL isBackPreView;//返回上级页面
@end

@implementation YhkTxViewController
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
    self.title = @"银行卡提现";
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _jineTF.delegate = self;
    
    //_userNameL.text = _lianjiuData[@"userName"];
    //_udetailsIdCardL.text = _lianjiuData[@"udetailsIdCard"];
  //  _udetailsCardNoL.text = _lianjiuData[@"udetailsCardNo"];
    
    
    
    NSString *userName = _lianjiuData[@"userName"];
    if (userName.length>1) {
        NSString *tel = [userName stringByReplacingCharactersInRange:NSMakeRange(1, userName.length-1) withString:@"**"];
        _userNameL.text = [NSString stringWithFormat:@"%@",tel];
    }else{
        _userNameL.text =  [NSString stringWithFormat:@"%@",userName];
    }

    
    
    
    
    NSInteger startLocation =1;
    NSString *replaceStr = _lianjiuData[@"udetailsIdCard"]?_lianjiuData[@"udetailsIdCard"]:@"  ";
    if (replaceStr.length<2) {
        _udetailsIdCardL.text = replaceStr?replaceStr:@"";
        return;
    }
    for (NSInteger i = 0; i < replaceStr.length-2; i++) {
        NSRange range = NSMakeRange(startLocation, 1);//为加密的起始位置和几位数字
        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    _udetailsIdCardL.text = replaceStr?replaceStr:@"";

    
    
    
    
    
    NSInteger startLocationY =0;
    NSString *replaceStrY = _lianjiuData[@"udetailsCardNo"]?_lianjiuData[@"udetailsCardNo"]:@"  ";
    
    if (replaceStrY.length<4) {
        _udetailsCardNoL.text = replaceStrY?replaceStrY:@"";
        return;
    }
    
    for (NSInteger i = 0; i < replaceStrY.length-4; i++) {
        NSRange range = NSMakeRange(startLocationY, 1);//为加密的起始位置和几位数字
        replaceStrY = [replaceStrY stringByReplacingCharactersInRange:range withString:@"*"];
        startLocationY ++;
    }
    _udetailsCardNoL.text = replaceStrY?replaceStrY:@"";

    
    
    
    
    
    
    
    
    
    
    _udetailsCardBankL.text = _lianjiuData[@"udetailsCardBank"];

    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)TxCommitAction:(id)sender {
    if (_jineTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入金额" toView:self.view];
        return;
    }

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *vip = [def objectForKey:@"userId"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"userId":vip, @"money":_jineTF.text}];

    [networking AFNRequest:LJINSERT withparameters:parameters success:^(NSMutableDictionary *dic) {
        
        
        CommitSuccseViewController *CMVC = [[CommitSuccseViewController alloc] init];
        CMVC.title = self.title;
        CMVC.contenValue = @"提现成功";
        // CMVC.subValue = CustomLocalizedString(@"提现款项将原路退回到用户支付账户.零钱即时到账;银行卡(储蓄卡及信用卡)1-3个工作日", nil);
        CMVC.image = [UIImage imageNamed:@"sucsses"];
        [self.navigationController pushViewController:CMVC animated:YES];
        //返回上级页面
        self.isBackPreView = YES;

        
    } error:nil HUDAddView:self.view];
    
    
    
    

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
    
    if (textField ==_jineTF) {
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
