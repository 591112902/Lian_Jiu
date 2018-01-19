//
//  ForgotVC.m
//  zaiShang
//
//  Created by LIHONG on 16/6/27.
//  Copyright © 2016年 CNMOBI. All rights reserved.
//

#import "zfForgotVC.h"
#import "zfForgotViewController.h"
#import "zfForgotViewController2.h"

@interface zfForgotVC ()
{
    UIButton *currBtn;
   
    
}

@property(nonatomic,strong)zfForgotViewController2 *regVC2;
@property(nonatomic,strong)zfForgotViewController *regVC;

@end

@implementation zfForgotVC
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"找回密码";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.backBarButtonItem = item;
    
    [self addNavigationItem];
    self.regVC = [[zfForgotViewController alloc] init];
    [self addChildViewController:self.regVC];
    self.regVC.view.frame = self.view.frame;
    [self.view addSubview:self.regVC.view];
    
    // Do any additional setup after loading the view.
}
- (zfForgotViewController2 *)regVC2
{
    if (!_regVC2) {
        _regVC2 = [[zfForgotViewController2 alloc] init];
        _regVC2.view.frame = CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT);
        [self addChildViewController:_regVC2];
    }
    return _regVC2;
}
- (void)addNavigationItem
{
    
    
//    NSArray *items = @[CustomLocalizedString(@"邮箱", nil),CustomLocalizedString(@"手机",nil)];
//    //指定每一个分段的标题,来初始化一个分段控件
//    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
//    [segment setFrame:CGRectMake(3000, 5000, 200, 32)];
//    //设置UIsegmentedcontrol的字体大小,颜色
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"SnellRoundhand-Bold"size:14],NSFontAttributeName ,nil];
//
//    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIFont fontWithName:@"SnellRoundhand-Bold" size:14],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextShadowColor, nil];
//    [segment setTitleTextAttributes:dic forState:UIControlStateNormal];
//    //设置分段控件的颜色
//    [segment setTintColor:[UIColor whiteColor]];
//    [segment setSelectedSegmentIndex:0];
//    // 给分段控件绑定一个方法，事件是valueChanged
//    [segment addTarget:self action:@selector(chooseClass:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = segment;

    
    
    CGFloat segementedH = 30;
    NSArray *arr = @[CustomLocalizedString(@"邮箱", nil),CustomLocalizedString(@"手机", nil)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, segementedH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*200/arr.count, 0, 200/arr.count, segementedH)];
        [btn addTarget:self action:@selector(chooseClass:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:MAINColor forState:UIControlStateSelected];
        [btn setTitle:arr[i] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"wihle_bg"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"l_tb_bg"] forState:UIControlStateNormal];
        btn.tag = 70+i;
        [view addSubview:btn];
        if (i==0) {
            btn.selected =YES;
            currBtn = btn;
        }
    }
    self.navigationItem.titleView = view;
}
- (void)chooseClass:(UIButton *)btn
{
    self.regVC2.number  = @1;
    self.regVC.number  = @1;

    
    
//    if (btn.selectedSegmentIndex==0) {
//        [self transitionFromViewController:self.regVC2 toViewController:self.regVC duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
//            
//        }];
//        
//    }else if (btn.selectedSegmentIndex==1){
//        [self transitionFromViewController:self.regVC toViewController:self.regVC2 duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
//            
//        }];
//    }

    
    if (currBtn==btn) {
        return;
    }
    currBtn = btn;
    for (UIButton *button in btn.superview.subviews) {
        button.selected = NO;
    }
    btn.selected = YES;
    if (btn.tag==70) {
        [self transitionFromViewController:self.regVC2 toViewController:self.regVC duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
            
        }];
        
    }else{
        [self transitionFromViewController:self.regVC toViewController:self.regVC2 duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
            
        }];
    }
    
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
