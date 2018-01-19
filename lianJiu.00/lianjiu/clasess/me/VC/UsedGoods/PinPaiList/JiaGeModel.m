//
//  CreditContenModel.m
//  zaiShang
//
//  Created by cnmobi on 15/12/24.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "JiaGeModel.h"

@implementation JiaGeModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    JiaGeModel *model = [[self alloc] init];
    model.i_date = dic[@"i_date"];
    model.i_id = dic[@"i_id"];
    model.i_integrals = dic[@"i_integrals"];
    model.i_source = dic[@"i_source"];
    model.user_id = dic[@"user_id"];
    model.i_recommend = dic[@"i_recommend"];
    return model;
}
@end
