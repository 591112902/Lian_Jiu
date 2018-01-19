//
//  MainModal.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MainModal.h"
#import "MJExtension.h"

@implementation MainModal

+ (instancetype)toModelWithDict:(NSDictionary *)dict{
    
    return [self mj_objectWithKeyValues:dict];
}

@end
