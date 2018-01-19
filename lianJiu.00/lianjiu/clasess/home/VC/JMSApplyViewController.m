//
//  JMSApplyViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/23.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "JMSApplyViewController.h"
#import "NewViewController.h"
@interface JMSApplyViewController ()
@property (nonatomic, strong) AMapPOI *model;
@end

@implementation JMSApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加盟商申请";
    
    self.khsRangeTV.layer.cornerRadius = 1;
    self.khsRangeTV.layer.borderWidth = 1;
    self.khsRangeTV.layer.borderColor = BGColor.CGColor;
    
    
    self.lxAddressTF.layer.cornerRadius = 1;
    self.lxAddressTF.layer.borderWidth = 1;
    self.lxAddressTF.layer.borderColor = BGColor.CGColor;
    
    
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

- (IBAction)lxAddressBtnAction:(id)sender {
    
    
//    NewViewController *mapVC = [[NewViewController alloc] init];
//    
//    mapVC.sendAMapAPIBlock = ^(AMapPOI *poi) {
//        
//        self.model = poi;
//        
//        [_lxAddressTF setTitle:[NSString stringWithFormat:@"%@",poi.name] forState:UIControlStateNormal];
//
//    };
//    
//    
//    [self.navigationController pushViewController:mapVC animated:YES];
//    
    
}

- (IBAction)sqJoinAction:(id)sender {
    
    if (_nameTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"姓名未填写" toView:self.view];
        return;
    }
    if (_lxfsTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"联系方式未填写" toView:self.view];
        return;
    }

    if (_lxAddressTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"联系地址未填写" toView:self.view];
        return;
    }
    if (_khsRangeTV.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"可回收范围未填写" toView:self.view];
        return;
    }
    if (_khsKindTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"可回收种类未填写" toView:self.view];
        return;
    }

    
    
    [networking AFNPOST:APPLICATION withparameters:@{@"albnessApplicationName":_nameTF.text,@"albnessApplicationPhone":_lxfsTF.text,@"albnessApplicationLocation":_lxAddressTF.text,@"albnessApplicationRetrievalRange":_khsRangeTV.text,@"albnessApplicationType":_khsKindTF.text} success:^(NSMutableDictionary *dic) {
        
       // [MBProgressHUD showNotPhotoError:@"提交成功" toView:self.view];
        
        
        
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交申请成功" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _nameTF.text = @"";_lxfsTF.text = @"";_lxAddressTF.text = @"";_khsRangeTV.text = @"";_khsKindTF.text = @"";
            
            
            // [self.navigationController popViewControllerAnimated:YES];
            
        }];
       // [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];
        
       
    } error:nil HUDAddView:self.view];
    
}
@end
