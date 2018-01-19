//
//  CommitListNextVC.m
//  lianjiu
//
//  Created by LIHONG on 2018/1/15.
//  Copyright © 2018年 CNMOBI. All rights reserved.
//

#import "CommitListNextVC.h"

@interface CommitListNextVC ()

@end

@implementation CommitListNextVC

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    if (BOUND_WIDTH>320) {
        
        self.readBtnLeft.constant = BOUND_WIDTH/320.0*60;
        self.readLabelLetf.constant =BOUND_WIDTH/320.0*100;
    }
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.title = @"提交订单";
    
    self.roundView.layer.borderColor = BGColor.CGColor;
    self.allPriceL.text = [NSString stringWithFormat:@"%@元",_allPrice?_allPrice:@""];
    
    
    [networking AFNRequest:B_GETBULKADDRESS withparameters:@{@"cid":@"264"} success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSString class]]) {
            NSString *addr = dic[@"lianjiuData"];
            
            self.ckAddressL.text = [NSString stringWithFormat:@"(1)仓库地址为:%@",addr];
            
        }
        
        
    } error:nil HUDAddView:self.view];
    
    
    
    
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
    
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [def boolForKey:@"islogin"];
    NSString *TAKEN  = [def objectForKey:@"BulkToken"];
    NSString *UID = [def objectForKey:@"userId"];
    if (!islogin) {
        [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }
    if (_lxrNameTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入联系人姓名" toView:self.view];
        return;
    }
    if (_phoneTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入联系电话" toView:self.view];
        return;
    }
    if (!_readBtn.selected) {
        [MBProgressHUD showNotPhotoError:@"请阅读并同意注意事项" toView:self.view];
        return;
    }

    
    NSLog(@"par:%@=",@{@"TAKEN":TAKEN?TAKEN:@"",@"userId":UID?UID:@"",@"userName":_lxrNameTF.text?_lxrNameTF.text:@"",@"userPhone":_phoneTF.text?_phoneTF.text:@""});
    [networking AFNPOST:BULKSUBMIT withparameters:@{@"TAKEN":TAKEN?TAKEN:@"",@"userId":UID?UID:@"",@"userName":_lxrNameTF.text?_lxrNameTF.text:@"",@"userPhone":_phoneTF.text?_phoneTF.text:@""} success:^(NSMutableDictionary *dic) {
        
        
        //大宗回收
        DaZongOrderViewController *uvc = [[DaZongOrderViewController alloc] init];
        uvc.title = @"大宗交易";
        uvc.isPay = @"ispay";
        uvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:uvc animated:YES];
        
//        if ([dic[@"lianjiuData"] isKindOfClass:[NSString class]]) {
//            
//            NSString *all_price = dic[@"lianjiuData"];
//            CommitListNextVC *cnVC = [[CommitListNextVC alloc] init];
//            cnVC.allPrice = all_price?all_price:@"";
//            [self.navigationController pushViewController:cnVC animated:YES];
//        }
    } error:nil HUDAddView:self.view];

    
    
    
}

- (IBAction)readBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}
@end
