//
//  LianjiuData.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "LianjiuData.h"
#import "MJExtension.h"

@implementation LianjiuData
/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"electronics" : @"Brand",
              @"product" : @"Product",
              @"brands" : @"Brand",
              @"ZNbrands" : @"Brand",
              };
}
@end
