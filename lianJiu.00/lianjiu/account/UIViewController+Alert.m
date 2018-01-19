//
//  UIViewController+Alert.m
//  盒家健康(新版)
//
//  Created by 洪铭翔 on 17/10/9.
//  Copyright © 2017年 洪铭翔. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg handler:(void(^)())handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handler();
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg Register:(void(^)())Register Binding:(void(^)())Binding {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *registerAction = [UIAlertAction actionWithTitle:@"去注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Register();
    }];
    UIAlertAction *bindingAction = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Binding();
    }];
    [alert addAction:registerAction];
    [alert addAction:bindingAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
