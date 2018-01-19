//
//  NewViewController.h
//  TestMap
//
//  Created by 123 on 17/12/11.
//  Copyright © 2017年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface NewViewController : UIViewController

@property (nonatomic, copy) void (^sendAMapAPIBlock)(AMapPOI *poi);

@end
