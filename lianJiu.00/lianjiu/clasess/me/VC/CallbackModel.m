//
//  CallbackModel.m
//  lianjiu
//
//  Created by 123 on 17/11/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "CallbackModel.h"

@implementation CallbackModel

+ (instancetype)ModelWith:(NSDictionary *)dic{
    CallbackModel *model = [[self alloc] init];
    model.orItemsRecycleType = dic[@"orItemsRecycleType"];
    model.orItemsStatus = dic[@"orItemsStatus"];
    model.orItemsPicture = dic[@"orItemsPicture"];
    model.orItemsName = dic[@"orItemsName"];
    model.orItemsPrice = dic[@"orItemsPrice"];
    model.orItemsId = dic[@"orItemsId"];
    if (![dic objectForKey:@"orItemsNum"]) {
        model.orItemsNum = @"1";
    } else {
        model.orItemsNum = dic[@"orItemsNum"];
    }
    model.isSelected = NO;
    return model;
}

@end
