//
//  KuaiDiAddrViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "KuaiDiAddrViewController.h"
#import "FaHuoViewController.h"
@interface KuaiDiAddrViewController ()

@end

@implementation KuaiDiAddrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"快递地址";
     [_faHuoBtn addTarget:self action:@selector(fhBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _jinELL.text = [NSString stringWithFormat:@"交易金额:%@元",_totalprice?_totalprice:@""];
    // Do any additional setup after loading the view from its nib.
}
-(void)fhBtnAction{
    FaHuoViewController *fvc = [[FaHuoViewController alloc] init];
    fvc.ordersId = _ordersId?_ordersId:@"";
    [self.navigationController pushViewController:fvc animated:YES];
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
