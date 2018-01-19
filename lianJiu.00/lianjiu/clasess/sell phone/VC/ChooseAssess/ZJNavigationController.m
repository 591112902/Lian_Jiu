//
//  ZJNavigationController.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ZJNavigationController.h"
#import "ZJPublicConfig.h"

@interface ZJNavigationController ()

@end

@implementation ZJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = ZJColor_main;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor];
}


@end
