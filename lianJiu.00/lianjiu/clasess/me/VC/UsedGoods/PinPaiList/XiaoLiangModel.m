//
//  CreditContenModel.m
//  zaiShang
//
//  Created by cnmobi on 15/12/24.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "XiaoLiangModel.h"

@implementation XiaoLiangModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    XiaoLiangModel *model = [[self alloc] init];
    model.excellentId = dic[@"excellentId"];
    model.excellentName = dic[@"excellentName"];
    model.excellentPrice = dic[@"excellentPrice"];
    model.excellentAttributePicture = dic[@"excellentAttributePicture"];
    model.excellentParamData = dic[@"excellentParamData"];
  
    return model;
}
@end
