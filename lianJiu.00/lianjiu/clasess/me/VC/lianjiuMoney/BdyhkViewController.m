//
//  BdyhkViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "BdyhkViewController.h"

@interface BdyhkViewController ()<UITextFieldDelegate>
//<GraphCodeViewDelegate>


@property(nonatomic,copy)NSString * str;



@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation BdyhkViewController{
    
        NSString *accout;
        NSString *code;
        NSInteger secondsCountDown;
        NSTimer *countDownTimer;
    

}
////图形验证码
//- (GraphCodeView *)graphCodeView{
//    if (!_graphCodeView) {
//    
//    }
//    return _graphCodeView;
//}

#pragma mark - action
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    BOOL returnValue = YES;
    
    NSMutableString* newText = [NSMutableString stringWithCapacity:0];
    
    [newText appendString:textField.text];// 拿到原有text,根据下面判断可能给它添加" "(空格);
    
    
    
    NSString * noBlankStr = [textField.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    NSInteger textLength = [noBlankStr length];
    
    
    
    
    
    if (string.length) {
        
        if (textLength < 45) {//这个25是控制实际字符串长度,比如银行卡号长度
            
            if (textLength > 0 && textLength %4 == 0) {
                
                newText = [NSMutableString stringWithString:[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                
                [newText appendString:@" "];
                
                [newText appendString:string];
                
                textField.text = newText;
                
                returnValue = NO;//为什么return NO?因为textField.text = newText;text已经被我们替换好了,那么就不需要系统帮我们添加了,如果你ruturnYES的话,你会发现会多出一个字符串
                
            }else {
                
                [newText appendString:string];
                
            }
            
        }else { // 比25长的话 return NO这样输入就无效了
            
            returnValue =NO;
            
        }
        
    }else { // 如果输入为空,该怎么地怎么地
        
        [newText replaceCharactersInRange:range withString:string];
        
    }
    
    
    
    return returnValue;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _udetailsCardNoTF.delegate = self;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    if (_genxinYHK.length>0) {
        self.title = @"修改绑定银行卡";
        [self.bdyhkButton setTitle:@"修改" forState:UIControlStateNormal];
        
    }else{
        self.title = @"绑定银行卡";
         [self.bdyhkButton setTitle:@"绑定" forState:UIControlStateNormal];
    }
    
    
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *username = [def objectForKey:@"username"];
    if (username.length>9) {
        
        NSString *tel = [username stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.phoneLabel.text = [NSString stringWithFormat:@"%@",tel];
    }else{
        
        self.phoneLabel.text =  [NSString stringWithFormat:@"%@",username];
        
    }

    
    if (_isSMRZ) {
       
        NSString *userName = _smrzDic[@"userName"];
        if (userName.length>1) {
            NSString *tel = [userName stringByReplacingCharactersInRange:NSMakeRange(1, userName.length-1) withString:@"**"];
            self.nameL.text = [NSString stringWithFormat:@"%@",tel];
        }else{
            self.nameL.text =  [NSString stringWithFormat:@"%@",userName];
        }

        
        
        
        
        
        NSInteger startLocation =1;
        NSString *replaceStr = _smrzDic[@"udetailsIdCard"]?_smrzDic[@"udetailsIdCard"]:@"";
        if (replaceStr.length<2) {
            self.idLabel.text = replaceStr?replaceStr:@"";
            return;
        }
        for (NSInteger i = 0; i < replaceStr.length-2; i++) {
            NSRange range = NSMakeRange(startLocation, 1);//为加密的起始位置和几位数字
            replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
            startLocation ++;
        }
        self.idLabel.text = replaceStr?replaceStr:@"";
        
        
    }
    
    
    
    
    
    
    
   // self.udetailsCardBankTF.text = _bdyhkDic[@"udetailsCardBank"]?_bdyhkDic[@"udetailsCardBank"]:@"";//建设银行
//    NSInteger startLocationY =0;
//    NSString *replaceStrY = _bdyhkDic[@"udetailsCardNo"]?_bdyhkDic[@"udetailsCardNo"]:@"";
//    if (replaceStrY.length<4) {
//        self.udetailsCardNoTF.text = replaceStrY?replaceStrY:@"";
//        return;
//    }
//    
//    for (NSInteger i = 0; i < replaceStrY.length-4; i++) {
//        NSRange range = NSMakeRange(startLocationY, 1);//为加密的起始位置和几位数字
//        replaceStrY = [replaceStrY stringByReplacingCharactersInRange:range withString:@"*"];
//        startLocationY ++;
//    }
//    self.udetailsCardNoTF.text = replaceStrY?replaceStrY:@"";
    
    
    
    
    
    
    
    
    
    
    
    
//    //动态验证码
//    _str =[NSString randomStringWithLength:4];
//    [_graphCodeView setCodeStr:_str];//设置验证码
//    [_graphCodeView setDelegate:self];

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

- (IBAction)bangdingAction:(id)sender {
     NSString *udetailsCardNo = [_udetailsCardNoTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
   
     NSLog(@"_udetailsCardNoTF.text:%@ udetailsCardNo%@",_udetailsCardNoTF.text,udetailsCardNo);
    
    
    
    if ( _udetailsCardBankTF.text.length ==0) {
        [MBProgressHUD showNotPhotoError:@"请输入开户支行" toView:self.view];
        return;
    }

    if (_udetailsCardNoTF.text.length ==0) {
        [MBProgressHUD showNotPhotoError:@"请输入银行卡号" toView:self.view];
        return;
    }
    
    if (_codeTextField.text.length ==0) {
        [MBProgressHUD showNotPhotoError:@"请输入验证码" toView:self.view];
        return;
    }

    
    
    
    if (_udetailsCardNoTF.text.length !=0 && _udetailsCardBankTF.text.length !=0) {
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *userID = [def objectForKey:@"userId"];
        
        NSString *urlStr;
        
        NSDictionary *para;
        if (_genxinYHK.length>0) {
            
            urlStr = UPDATEUSERBANKCARD;
            para = @{@"udetailsCardNo":udetailsCardNo,@"udetailsCardBank":_udetailsCardBankTF.text,@"udetailsId":_udetailsId,@"code":_codeTextField.text} ;
        }else{
            
            urlStr = MODIFYUSERBANKCARD;
            para = @{@"udetailsCardNo":udetailsCardNo,@"udetailsCardBank":_udetailsCardBankTF.text,@"userId":userID,@"code":_codeTextField.text} ;
        }
        
        
        [networking AFNPOST:urlStr withparameters:para success:^(NSMutableDictionary *dic) {
            
           
            
           // [self.navigationController popToRootViewControllerAnimated:YES];
            
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
             [MBProgressHUD showNotPhotoError:@"绑定成功" toView:self.navigationController.viewControllers[1].view];
           //  [self.navigationController popViewControllerAnimated:YES];
            
        } error:nil HUDAddView:self.view];
        
    }else{
        [MBProgressHUD showNotPhotoError:@"银行卡号和名称不能为空" toView:self.view];
    }

    
    
    
//    //    不区分大小写
//    BOOL result = [code compare:_codeTextField.text
//                        options:NSCaseInsensitiveSearch |NSNumericSearch] == NSOrderedSame;
//    // 区分大小写
//    //   BOOL result2 = [_str isEqualToString:_codeTextField.text];
//    if (result) {
//        
//        
//       // [MBProgressHUD showNotPhotoError:@"验证成功" toView:self.view];
//        //_verifyLabel.text = @"验证成功";
//
//    }else{
//        
//      [MBProgressHUD showNotPhotoError:@"验证码错误" toView:self.view];
//        
//    }

    
}

//- (IBAction)getCode:(id)sender {
//    
//    _str =[NSString randomStringWithLength:4];
//    [_graphCodeView setCodeStr:_str];
//    [_graphCodeView setNeedsDisplay];
//
//    
//}
- (IBAction)getCodeAction:(id)sender {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *username = [def objectForKey:@"username"];
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",BDYHKSENDSMS,username] withparameters:nil success:^(NSMutableDictionary *dic) {
        code = dic[@"lianjiuData"];
        NSLog(@"获取验证码:%@",dic);
        [MBProgressHUD showSuccess:@"验证码已发送成功" toView:[UIApplication sharedApplication].keyWindow];
        accout = self.phoneLabel.text;
        self.getCodeBtn.enabled = NO;
        self.getCodeBtn.alpha = 0.7;
        secondsCountDown = 300;//60秒倒计时
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    } error:^(NSError *error) {
        
    } HUDAddView:self.view];
}
-(void)timeFireMethod{
    secondsCountDown--;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)secondsCountDown] forState:UIControlStateNormal];
   // [self.getCodeBtn setBackgroundColor:[UIColor whiteColor]];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [self.getCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.enabled = YES;
        self.getCodeBtn.alpha = 1;
    }
}

@end
