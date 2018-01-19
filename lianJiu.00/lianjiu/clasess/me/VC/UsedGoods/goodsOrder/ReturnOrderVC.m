//
//  ReturnOrderVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ReturnOrderVC.h"

@interface ReturnOrderVC ()

@end

@implementation ReturnOrderVC
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

    
   self.title = @"输入退货单号";
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
    
    if (_kdPingTaiTF.text.length == 0) {
         [MBProgressHUD showNotPhotoError:@"请填写快递平台" toView:self.view];
        return;
    }
    if (_danHaoTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请填写退货单号" toView:self.view];
        return;
    }

    [networking AFNPOST:ORDERSEXCELLENTREFUNDEXP withparameters:@{@"orExcellentId":_model.ordersId,@"refundExpress":_kdPingTaiTF.text,@"refundExpressNum":_danHaoTF.text} success:^(NSMutableDictionary *dic) {
        
        //[MBProgressHUD showNotPhotoError:@"提交成功" toView:self.view];
        
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交退货单号成功，请等待退款" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSNotification *notification = [NSNotification notificationWithName:@"GOODORDER__NOTIFICATION" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];

            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        
        
        
    } error:nil HUDAddView:self.view];
    
    
    
}
@end
