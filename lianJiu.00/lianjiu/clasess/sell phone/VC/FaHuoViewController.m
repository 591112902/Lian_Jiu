//
//  FaHuoViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "FaHuoViewController.h"
#import "KuaiDiOrderViewController.h"
@interface FaHuoViewController ()

@end

@implementation FaHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发货";
    [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
-(void)sureBtnAction{
    
    
    if (_kdDanHaoTF.text.length==0) {
        
        [MBProgressHUD showNotPhotoError:@"请填写快递单号" toView:self.view];
        return;
    }
    
    
    [networking AFNPOST:ADDEXPRESSSNUM withparameters:@{@"orExpressNum":_kdDanHaoTF.text,@"orExpressId":_ordersId?_ordersId:@""} success:^(NSMutableDictionary *dic) {
        
        
        if (_isME.length>0) {
            
            
            
//            KuaiDiOrderViewController* oneVC =nil;
//            for(UIViewController* VC in self.navigationController.viewControllers){
//                if([VC isKindOfClass:[KuaiDiOrderViewController class]]){
//                    oneVC =(KuaiDiOrderViewController*) VC;
////                    
//                    [self.navigationController popToViewController:oneVC animated:YES];
//                }
//            }
//
            NSNotification *notification = [NSNotification notificationWithName:@"FANHUI_SHUAXIN_NOTIFICATION" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];

            
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            KuaiDiOrderViewController *fvc = [[KuaiDiOrderViewController alloc] init];
            
            fvc.isPay = @"isPay";
            [self.navigationController pushViewController:fvc animated:YES];
            
            [MBProgressHUD showNotPhotoError:@"发货成功" toView:fvc.view];

        }
        
        
        
    } error:nil HUDAddView:self.view];
    
    
    
    
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

@end
