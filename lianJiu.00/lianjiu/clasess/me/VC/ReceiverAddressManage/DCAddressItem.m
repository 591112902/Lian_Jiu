//
//  DCAddressItem.m
//  CDDMall
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCAddressItem.h"
#import "DCSpeedy.h"
#define DCMargin 10

@implementation DCAddressItem


+(instancetype)ModelWith:(NSDictionary *)dic
{
    DCAddressItem *model = [[self alloc] init];
    
    model.latitude = dic[@"latitude"];
    model.longitude = dic[@"longitude"];
    
    model.userAddressId = dic[@"userAddressId"];
    model.userId = dic[@"userId"];
    
    model.userAddressName = dic[@"userAddressName"];
    model.userAddressPhone = dic[@"userAddressPhone"];
    //model.username = dic[@"username"];
    model.userProvince = dic[@"userProvince"];
    model.userCity = dic[@"userCity"];
    model.userDistrict = dic[@"userDistrict"];
    
    model.userLocation = dic[@"userLocation"];
    //userSite
    model.userSite = dic[@"userSite"];
    
    model.userDefault = [dic[@"userDefault"] boolValue];
    
    return model;
}


- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",_userProvince,_userCity,_userDistrict,_userLocation,_userSite];
    CGSize titleSize = [DCSpeedy dc_calculateTextSizeWithText:str WithTextFont:13 WithMaxW:[UIScreen mainScreen].bounds.size.width - 4 *DCMargin];
    _cellHeight = 4 * DCMargin + titleSize.height + 35 + 30;
    
    return _cellHeight;
}

@end
