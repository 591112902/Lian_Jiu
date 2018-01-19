//
//  RegisterVC.m
//  zaiShang
//
//  Created by LIHONG on 16/6/24.
//  Copyright © 2016年 CNMOBI. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterViewController2.h"
#import "RegisterViewController.h"
@interface RegisterVC ()
@property(nonatomic,strong)RegisterViewController2 *regVC2;
@property(nonatomic,strong)RegisterViewController *regVC;
@end

@implementation RegisterVC{
    UIButton *currBtn;
}
- (void)back
{
//    [countDownTimer invalidate];
//    countDownTimer= nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:CustomLocalizedString(@"登录", nil) forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.backBarButtonItem = item;

    [self addNavigationItem];
    self.regVC2 = [[RegisterViewController2 alloc] init];
    //self.presonVc.userModel =self.userModel;
    [self addChildViewController:self.regVC2];
    self.regVC2.view.frame = self.view.frame;
    [self.view addSubview:self.regVC2.view];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
- (RegisterViewController *)regVC
{
    if (!_regVC) {
        _regVC = [[RegisterViewController alloc] init];
       // _conpanyVc.userModel =self.userModel;
        _regVC.view.frame = CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT);
        [self addChildViewController:_regVC];
    }
    return _regVC;
}

- (void)addNavigationItem
{
    
//    NSArray *items = @[CustomLocalizedString(@"手机注册", nil),CustomLocalizedString(@"邮箱注册",nil)];
//    //指定每一个分段的标题,来初始化一个分段控件
//    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
//    [segment setFrame:CGRectMake(3000, 5000, 200, 32)];
//    //设置UIsegmentedcontrol的字体大小,颜色
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"SnellRoundhand-Bold"size:14],NSFontAttributeName ,nil];
//
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
    NSArray *arr = @[@"手机注册",@"邮箱注册"];
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
        
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
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
    
//    if (btn.selectedSegmentIndex==0) {
//        [self transitionFromViewController:self.regVC toViewController:self.regVC2 duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
//            
//        }];
//        
//    }else if (btn.selectedSegmentIndex==1){
//        [self transitionFromViewController:self.regVC2 toViewController:self.regVC duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
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
        [self transitionFromViewController:self.regVC toViewController:self.regVC2 duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
            
        }];
        
    }else{
        [self transitionFromViewController:self.regVC2 toViewController:self.regVC duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:^(BOOL finished) {
            
        }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
