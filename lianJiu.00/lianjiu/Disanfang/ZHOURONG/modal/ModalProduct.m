//
//  ModalProduct.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ModalProduct.h"
#import "MJExtension.h"


@implementation ModalProduct
+ (instancetype)toModelWithDict:(NSDictionary *)dict{
    
    return [self mj_objectWithKeyValues:dict];
}
@end
