//
//  CommitSuccseViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/9/21.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import "CommitSuccseViewController.h"

@interface CommitSuccseViewController ()

@end

@implementation CommitSuccseViewController
-(void)backBtn{
     [self.navigationController popViewControllerAnimated:NO];
//    if ([_zhuangtai isEqualToString:@"我是修改现货交易过来的"]) {
//            UIViewController *viewCtl = self.navigationController.viewControllers[2];
//            [self.navigationController popToViewController:viewCtl animated:YES];
//
//    }else{
//        [self.navigationController popViewControllerAnimated:NO];
//    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomLocalizedString(@"返回", nil);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain
                                             
                                                                            target:self action:@selector(backBtn)];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat H = 30+64;
    CGFloat imageViewH = 70;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((BOUND_WIDTH-imageViewH)/2, H, imageViewH, imageViewH)];
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
    H +=imageViewH+30;
    self.contenLable = [[UILabel alloc] initWithFrame:CGRectMake(0, H, BOUND_WIDTH, 20)];
    self.contenLable.text = self.contenValue;
    self.contenLable.textAlignment = NSTextAlignmentCenter;
    self.contenLable.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.contenLable];
    
    H +=20;
    self.subLable = [[UILabel alloc] initWithFrame:CGRectMake(10, H, BOUND_WIDTH-20, 90)];
    self.subLable.text = self.subValue;
    self.subLable.numberOfLines = 0;
    self.subLable.textAlignment = NSTextAlignmentCenter;
    self.subLable.font = [UIFont systemFontOfSize:15];
    self.subLable.textColor = [UIColor grayColor];
    [self.view addSubview:self.subLable];
    // Do any additional setup after loading the view.
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
