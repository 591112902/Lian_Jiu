//
//  GoodsRefundVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "GoodsRefundVC.h"
#import "OnlyTuiKuanViewController.h"
#import "UIImageView+WebCache.h"
#import "TuihouAndkuanViewController.h"
@interface GoodsRefundVC ()

@end

@implementation GoodsRefundVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isBackPreView) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款";
    
    
    self.titleL.text = _model.orItemsNamePreview;
    self.contentTV.text = _model.orItemsParam;
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:_model.orItemsPictruePreview]];
    
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

- (IBAction)onlyTuiKuanAction:(id)sender {
    OnlyTuiKuanViewController *oo = [[OnlyTuiKuanViewController alloc] init];
    oo.model = _model;
    //返回上级页面
    self.isBackPreView = YES;
    [self.navigationController pushViewController:oo animated:YES];
    
}

- (IBAction)tuihouAndkuanAction:(id)sender {
    
    TuihouAndkuanViewController *oo = [[TuihouAndkuanViewController alloc] init];
    //返回上级页面
    self.isBackPreView = YES;
    oo.model = _model;
    oo.preVc = _preVc;
    [self.navigationController pushViewController:oo animated:YES];

}
@end
