//
//  SmrzViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "SmrzViewController.h"

@interface SmrzViewController ()

@end

@implementation SmrzViewController


#pragma mark - action
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
    
    
    self.title = @"实名认证";
    
    self.nameTF.text = _smrzDic[@"userName"]?_smrzDic[@"userName"]:@"";
    if (_isSMRZ) {
        
        self.nameTF.enabled = NO;self.idTF.enabled = NO;
        
        _comitBtn.alpha = 0.5;
        _comitBtn.userInteractionEnabled = NO;
        _promtL.text = @"认证成功";
        
        
        NSInteger startLocation =1;
        NSString *replaceStr = _smrzDic[@"udetailsIdCard"]?_smrzDic[@"udetailsIdCard"]:@"  ";
        
        
        if (replaceStr.length<2) {
            self.idTF.text = replaceStr?replaceStr:@"";
            return;
        }

        
        
        
        for (NSInteger i = 0; i < replaceStr.length-2; i++) {
            NSRange range = NSMakeRange(startLocation, 1);//为加密的起始位置和几位数字
            replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
            startLocation ++;
        }

        self.idTF.text = replaceStr?replaceStr:@"";
        
        
    }
    
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)commitAction:(id)sender {
    
    
    if (_nameTF.text.length ==0) {
         [MBProgressHUD showNotPhotoError:@"请填写您的姓名" toView:self.view];
        return;
    }
    
    if (_idTF.text.length ==0) {
        [MBProgressHUD showNotPhotoError:@"请填写您的身份证号码" toView:self.view];
        return;
    }

    
    
    
            
            AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            UIView *superView = [UIApplication sharedApplication].keyWindow;
            
            [MBProgressHUD showHUDAddedTo:superView animated:YES];
            [manager POST:@"http://api.id98.cn/api/idcard" parameters:@{@"appkey":@"2384e15e471eb8b119f90c43045a22d1",@"cardno":_idTF.text,@"name":_nameTF.text} progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSNumber *code=dict[@"code"];
                NSNumber *isok=dict[@"isok"];
                int c = [code intValue];
                int isOK = [isok intValue];
                
                NSLog(@"smrz%@",dict);
                
                if (isOK==1) {//isok:1 查询成功，  isok:0 查询失败
                    if (c==1) {
                       // [MBProgressHUD showSuccess:@"一致" toView:superView];
                        
                        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                        NSString *userID = [def objectForKey:@"userId"];
                        
                        
                        [networking AFNPOST:SUBCERTIFICATION withparameters:@{@"username":_nameTF.text,@"idCard":_idTF.text,@"userId":userID} success:^(NSMutableDictionary *dic) {
                           
                            
                            [MBProgressHUD showNotPhotoError:@"认证成功" toView:[UIApplication sharedApplication].keyWindow];
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        } error:nil HUDAddView:self.view];

                        
                        
                        
                        
                        
                    }else if (c==2) {
                        [MBProgressHUD showSuccess:@"姓名与身份证号不一致" toView:superView];
                    }else if (c==3) {
                        [MBProgressHUD showSuccess:@"无此身份证号码" toView:superView];
                    }

                    
                }else if (isOK==0){
                    
                    
                    if (c==11) {
                         [MBProgressHUD showSuccess:@"参数不正确" toView:superView];
                    }else if (c==12) {
                        [MBProgressHUD showSuccess:@"商户余额不足" toView:superView];
                    }else if (c==13) {
                        [MBProgressHUD showSuccess:@"appkey不存在" toView:superView];
                    }else if (c==14) {
                        [MBProgressHUD showSuccess:@"IP被拒绝" toView:superView];
                    }else if (c==20) {
                        [MBProgressHUD showSuccess:@"身份证中心维护中" toView:superView];
                    }else {
                        [MBProgressHUD showSuccess:@"查询失败" toView:superView];
                    }

                    
                }else{
                    [MBProgressHUD showError:@"稍后再试" toView:superView];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                 [MBProgressHUD showError:@"网络不给力" toView:superView];
                
            }];

            
            
    
            
    
    
}
@end
