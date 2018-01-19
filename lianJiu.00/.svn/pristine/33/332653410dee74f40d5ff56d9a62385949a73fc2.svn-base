//
//  IWTabBar.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRJTabBarButton.h"
@class PRJTabBar;

@protocol PRJTabBarDelegate <NSObject>

@optional
- (void)tabBar:(PRJTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface PRJTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<PRJTabBarDelegate> delegate;
- (void)buttonClick:(PRJTabBarButton *)button;
@end
