//
//  KeyboardViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController
{
    //以下为键盘所用
    UIView *selctTF;
    BOOL iskeyboatdshow;
    CGFloat kbHeight;
    double duration;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    // Do any additional setup after loading the view.
}



- (void)addNotification
{
    // 监听键盘的即将显示事件. UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘即将消失的事件. UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
- (void) keyboardWillShow:(NSNotification *)notify {
    iskeyboatdshow = YES;
    //这里只写了关键代码，细节根据自己的情况来定，selctTF为弹出键盘的视图，UITextField
    kbHeight = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height+50;//获取键盘高度，在不同设备上，以及中英文下是不同的，很多网友的解决方案都把它定死了。
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self moveView];
}
- (void)moveView
{
    CGFloat screenHeight = self.view.bounds.size.height;
    HZLog(@"%f",screenHeight);
    CGPoint pt = [selctTF convertPoint:CGPointMake(0, selctTF.frame.size.height) toView:self.view];
    CGFloat viewBottom = pt.y;
    CGFloat delta = viewBottom + kbHeight - screenHeight;
    if (delta<0) return;//若键盘没有遮挡住视图则不进行整个视图上移
    if (delta+selctTF.frame.size.width>screenHeight-self.navigationController.navigationBar.frame.size.height) {
        delta = screenHeight-self.navigationController.navigationBar.frame.size.height-kbHeight;
    }
    [UIView animateWithDuration:duration animations:^void(void){
        // superView来重新布局
        self.view.frame = CGRectMake(0.0f, -delta, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    selctTF = textField;
    if (iskeyboatdshow) {
        [self moveView];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    selctTF = textView;
    if (iskeyboatdshow) {
        [self moveView];
    }
}
- (void) keyboardWillHidden:(NSNotification *)notify {//键盘消失
    // 键盘动画时间
    
    double duration2 = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration2 animations:^{
        self.view.frame = CGRectMake(0.0f, 0, self.view.frame.size.width, self.view.frame.size.height);
        iskeyboatdshow = NO;
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIView *tf ;
    BOOL isstar = NO;
    for (UIView *view in self.view.subviews) {
        if (textField==view) {
            isstar =YES;
            continue;
        }
        if (isstar) {
            if ([view isKindOfClass:[UITextField class]]||[view isKindOfClass:[UITextView class]]) {
                tf = view;
                break;
            }
        }
    }
    if (tf) {
        [tf becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    HZLog(@"%@---dealloc",self.class);
}
@end
