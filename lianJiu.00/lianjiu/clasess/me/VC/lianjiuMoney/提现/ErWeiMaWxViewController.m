//
//  ErWeiMaWxViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/12/25.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//
#import "WxTXViewController.h"
#import "ErWeiMaWxViewController.h"
#import "KeyboardViewController.h"
#import "UIImageView+WebCache.h"
@interface KeyboardViewController ()

@end

@implementation ErWeiMaWxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yanzhengBtn.layer.cornerRadius = 3;
    
    self.navigationItem.title = @"微信提现";
    
    
    UILongPressGestureRecognizer *lg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ivlgAction:)];
    [self.erweimaIV addGestureRecognizer:lg];
    self.erweimaIV.userInteractionEnabled = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)ivlgAction:(UILongPressGestureRecognizer *)tap
{
    
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"存储二维码图片至手机相册" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"不存储了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"存储图片至手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImageView *imageV = (UIImageView *)tap.view;
        UIImageWriteToSavedPhotosAlbum(imageV.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }];
    
    [clear addAction:queRen];
    [clear addAction:quXiao];
    [self presentViewController:clear animated:YES completion:nil];
  
}
//实现imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:方法
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message;
    if (!error) {
        message =@"成功存储到相册";//@"成功保存到相册";
        [MBProgressHUD showNotPhotoError:message toView:self.view];
    }else
    {
        //        message = [error description];
        [MBProgressHUD showNotPhotoError:@"存储失败" toView:self.view];
    }
    //    HZLog(@"message is %@",message);
}

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    [networking AFNPOST:TXWXCASHCODE withparameters:@{@"userId":uid?uid:@""} success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSString class]]) {
            NSString *imgS = dic[@"lianjiuData"];
            [self.erweimaIV sd_setImageWithURL:[NSURL URLWithString:imgS]];
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

- (IBAction)yanzehngAction:(UIButton *)sender {
    
    if (self.yanzhengmaTF.text.length == 0) {
        [MBProgressHUD showNotPhotoError:@"请输入验证码" toView:self.view];
        return;
    }
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];

    [networking AFNPOST:TXWXPAYCHECKCODE withparameters:@{@"userId":uid?uid:@"",@"checkCode":self.yanzhengmaTF.text} success:^(NSMutableDictionary *dic) {
        NSLog(@"checkCode:%@",dic);
//        if ([dic[@"lianjiuData"] isKindOfClass:[NSString class]]) {
//        }
        
        WxTXViewController *wx = [[WxTXViewController alloc] init];
        [self.navigationController pushViewController:wx animated:YES];
        
        
        
    } error:nil HUDAddView:self.view];

    
    
    
  
    
}
@end
