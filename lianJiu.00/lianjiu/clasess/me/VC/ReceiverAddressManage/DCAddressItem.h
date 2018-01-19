//
//  DCAddressItem.h
//  CDDMall
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCAddressItem : NSObject

//@property (nonatomic, copy) NSString *adName;
//
//@property (nonatomic, copy) NSString *adPhone;
//
//@property (nonatomic, copy) NSString *adCity;
//
//@property (nonatomic, copy) NSString *adDetail;

@property (nonatomic, copy) NSString *userSite;

@property (nonatomic, copy) NSString *userAddressId;
@property (nonatomic, copy) NSString *userId;


@property (nonatomic, copy) NSString *userAddressName;
@property (nonatomic, copy) NSString *userAddressPhone;

@property (nonatomic, copy) NSString *userProvince;
@property (nonatomic, copy) NSString *userCity;
@property (nonatomic, copy) NSString *userDistrict;
@property (nonatomic, copy) NSString *userLocation;

@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
///** 是否是默认地址 */
@property (nonatomic, assign) BOOL userDefault;




///** 是否是默认地址 */
//@property (nonatomic,assign)BOOL isDefault;


/** cell行高 */
@property (nonatomic , assign) CGFloat cellHeight;





+(instancetype)ModelWith:(NSDictionary *)dic;


@end
