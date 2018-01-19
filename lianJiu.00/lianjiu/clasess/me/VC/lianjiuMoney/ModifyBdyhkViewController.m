//
//  BdyhkViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/10/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ModifyBdyhkViewController.h"

@interface ModifyBdyhkViewController ()<GraphCodeViewDelegate>


@property(nonatomic,copy)NSString * str;



@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation ModifyBdyhkViewController
//图形验证码
- (GraphCodeView *)graphCodeView{
    if (!_graphCodeView) {
    
    }
    return _graphCodeView;
}

#pragma mark - action
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    //动态验证码
    _str =[NSString randomStringWithLength:4];
    [_graphCodeView setCodeStr:_str];//设置验证码
    [_graphCodeView setDelegate:self];

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

- (IBAction)bangdingAction:(id)sender {
    
    
    //    不区分大小写
    BOOL result = [_str compare:_codeTextField.text
                        options:NSCaseInsensitiveSearch |NSNumericSearch] == NSOrderedSame;
    // 区分大小写
    //   BOOL result2 = [_str isEqualToString:_codeTextField.text];
    if (result) {
        
        
        [MBProgressHUD showNotPhotoError:@"验证成功" toView:self.view];
       
        //_verifyLabel.text = @"验证成功";
        
        
    }else{
        
      [MBProgressHUD showNotPhotoError:@"验证码错误" toView:self.view];
        
    }

    
}

- (IBAction)getCode:(id)sender {
    
    _str =[NSString randomStringWithLength:4];
    [_graphCodeView setCodeStr:_str];
    [_graphCodeView setNeedsDisplay];

    
}
@end
