//
//  SuccessToNViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/9/23.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import "SuccessToNViewController.h"

@interface SuccessToNViewController ()

@end

@implementation SuccessToNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat contenH = 150;
   
    self.contenLable = [[UILabel alloc] initWithFrame:CGRectMake(40,64, BOUND_WIDTH-80, contenH)];
    self.contenLable.text = self.contenValue;
    self.contenLable.numberOfLines = 0;
    self.contenLable.textAlignment = NSTextAlignmentCenter;
    self.contenLable.font = [UIFont systemFontOfSize:15];
    self.contenLable.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.contenLable];
    
    UIButton *outBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 64+contenH+10, BOUND_WIDTH-20, 50)];
    [outBtn setTitle:self.nextValue forState:UIControlStateNormal];
    [outBtn setBackgroundImage:[UIImage imageNamed:@"fr_three_img_but"] forState:UIControlStateNormal];
    outBtn.layer.cornerRadius = 5;
    outBtn.clipsToBounds = YES;
    [outBtn addTarget:self action:@selector(ToNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outBtn];
    
}
-(void)ToNext
{
    
    //    删除userdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *vip = [defaults stringForKey:@"vip"];
    NSDictionary *parameters = @{@"vip":vip};
//    [networking AFNPOSTNotHUD:ELIMINATETOKEN withparameters:parameters success:^(NSMutableDictionary *dic) {
//    } error:nil];
    [defaults removeObjectForKey:@"vip"];
    
    [defaults setBool:NO forKey:@"islogin"];
    
    [defaults setBool:NO forKey:@"isRealName"];
    [defaults synchronize];
    //    删除归档模型
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:ACCOUNTPATH]) {
        [defaultManager removeItemAtPath:ACCOUNTPATH error:nil];
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [MBProgressHUD showNotPhotoError:@"请输入新密码,重新登录" toView:[UIApplication sharedApplication].keyWindow];
    
    
//     self.view.window.rootViewController = [self.view.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"LoginIdentifier"];
   // [self.navigationController popViewControllerAnimated:YES];
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
