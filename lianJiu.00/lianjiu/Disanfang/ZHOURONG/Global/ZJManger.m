//
//  ZJManger.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ZJManger.h"

@interface ZJManger()

@end

@implementation ZJManger



+ (instancetype)shared
{
    static ZJManger *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[ZJManger alloc] init];
        // Do any other initialisation stuff here
    });
    return shared;
}

@end
