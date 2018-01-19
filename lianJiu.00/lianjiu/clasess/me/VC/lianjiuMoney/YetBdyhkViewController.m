//
//  YetBdyhkViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "YetBdyhkViewController.h"

@interface YetBdyhkViewController ()

@end

@implementation YetBdyhkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定银行卡";
    
    self.DeleteBdyhkBtn.layer.borderColor = MAINColor.CGColor;
    self.DeleteBdyhkBtn.layer.borderWidth = 1;
    
    
    
   // self.nameL.text = _smrzDic[@"userName"]?_smrzDic[@"userName"]:@"";
    
    
//    NSString *userName = _smrzDic[@"userName"];
//    if (userName.length>9) {
//        NSString *tel = [userName stringByReplacingCharactersInRange:NSMakeRange(1, userName.length-1) withString:@"*"];
//        self.nameL.text = [NSString stringWithFormat:@"%@",tel];
//    }else{
//        self.nameL.text =  [NSString stringWithFormat:@"%@",userName];
//    }

    
    
    NSString *userName = _smrzDic[@"userName"];
    if (userName.length>1) {
        NSString *tel = [userName stringByReplacingCharactersInRange:NSMakeRange(1, userName.length-1) withString:@"**"];
        self.nameL.text = [NSString stringWithFormat:@"%@",tel];
    }else{
        self.nameL.text =  [NSString stringWithFormat:@"%@",userName];
    }

    
    
    
    
    
    
    
    
    
    
    NSInteger startLocation =1;
    NSString *replaceStr = _smrzDic[@"udetailsIdCard"]?_smrzDic[@"udetailsIdCard"]:@"  ";
    for (NSInteger i = 0; i < replaceStr.length-2; i++) {
        NSRange range = NSMakeRange(startLocation, 1);//为加密的起始位置和几位数字
        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    self.idLabel.text = replaceStr?replaceStr:@"";

    
    
    
    
    
    self.kaifuhL.text = _bdyhkDic[@"udetailsCardBank"]?_bdyhkDic[@"udetailsCardBank"]:@"";//建设银行
    NSInteger startLocationY =0;
    NSString *replaceStrY = _bdyhkDic[@"udetailsCardNo"]?_bdyhkDic[@"udetailsCardNo"]:@"  ";
    
    if (replaceStrY.length<4) {
        self.kaHaoL.text = replaceStrY?replaceStrY:@"";
        return;
    }
    for (NSInteger i = 0; i < replaceStrY.length-4; i++) {
        NSRange range = NSMakeRange(startLocationY, 1);//为加密的起始位置和几位数字
        replaceStrY = [replaceStrY stringByReplacingCharactersInRange:range withString:@"*"];
        startLocationY ++;
    }
    self.kaHaoL.text = replaceStrY?replaceStrY:@"";

    
    
    
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

- (IBAction)ModifyBdyhkAction:(id)sender {
    
//    ModifyBdyhkViewController *bvc = [[ModifyBdyhkViewController alloc] init];
//    bvc.smrzDic = _smrzDic;
//    bvc.isSMRZ = _isSMRZ;
//    bvc.isBdyhk = _isBdyhk;
//    bvc.bdyhkDic = _bdyhkDic;
//    [self.navigationController pushViewController:bvc animated:YES];
   
    BdyhkViewController *bvc = [[BdyhkViewController alloc] init];
    bvc.smrzDic = _smrzDic;
    bvc.isSMRZ = _isSMRZ;
    bvc.bdyhkDic = _bdyhkDic;
    
    bvc.genxinYHK = @"genxinYHK";
    bvc.udetailsId = _bdyhkDic[@"udetailsId"];
     [self.navigationController pushViewController:bvc animated:YES];
    
}

- (IBAction)DeleteBdyhkAction:(id)sender {
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除绑定银行卡？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSString *udetailsId = _bdyhkDic[@"udetailsId"]?_bdyhkDic[@"udetailsId"]:@"";
        [networking AFNPOST:REMOVEUSERBANKCARD withparameters:@{@"udetailsId":udetailsId} success:^(NSMutableDictionary *dic) {
            
            
            UIViewController *viewCtl = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:viewCtl animated:YES];
            
            [MBProgressHUD showNotPhotoError:@"删除成功" toView:viewCtl.view];

            
        } error:nil HUDAddView:self.view];

        
        
        
    }];
    [clear addAction:quXiao];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];
    

  
    
}
@end
