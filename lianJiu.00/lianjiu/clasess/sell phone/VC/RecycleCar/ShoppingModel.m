//
//  ShoppingModel.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel



-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
    
    self.orItemsId = dict[@"orItemsId"];
    
        self.orItemsPicture = dict[@"orItemsPicture"];
        self.orItemsName = dict[@"orItemsName"];
        self.orItemsPrice = dict[@"orItemsPrice"];
        self.orItemsNum = dict[@"orItemsNum"];
         self.orItemsProductId = dict[@"orItemsProductId"];
    
        self.selectState = [dict[@"selectState"]boolValue];
    
     self.orItemsParam = dict[@"orItemsParam"];
    
    return self;
}





@end
