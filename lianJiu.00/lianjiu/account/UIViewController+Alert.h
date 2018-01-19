//
//  UIViewController+Alert.h
//  盒家健康(新版)
//
//  Created by 洪铭翔 on 17/10/9.
//  Copyright © 2017年 洪铭翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg;
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg handler:(void(^)())handler;
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg Register:(void(^)())Register Binding:(void(^)())Binding;
@end
