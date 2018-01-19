//
//  AppDelegate.m
//  lianjiu
//
//  Created by cnmobi on 17/8/17.
//  Copyright (c) 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@protocol WXDelegate <NSObject>

-(void)loginSuccessByCode:(NSString *)code;
-(void)shareSuccessByCode:(int) code;
@end


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) id<WXDelegate> wxDelegate;


@end
//修改过SDwebImage  connectionDidFinishLoading:方法
//修改MJRefrsh框架，给footer、header添加通知

//换语言
//文件上传
//bitcode已改为no
