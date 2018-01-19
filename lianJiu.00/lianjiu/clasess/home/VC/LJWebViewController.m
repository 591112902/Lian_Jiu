//
//  LJWebViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/10.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "LJWebViewController.h"
#import "MBProgressHUD.h"
@interface LJWebViewController ()

@end

@implementation LJWebViewController
{
    UIWebView *webView ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    webView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0.1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [webView setScalesPageToFit:YES];
    webView.delegate = self;
    [MBProgressHUD showSuccess:CustomLocalizedString(@"正在加载", nil) toView:[UIApplication sharedApplication].keyWindow ];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - web view delegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
}
//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
    
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
