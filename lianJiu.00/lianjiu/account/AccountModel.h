//
//  AccountModel.h
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

@property(nonatomic,strong)NSString *isPwd;
@property(nonatomic,strong)NSString *userAsset;
@property(nonatomic,strong)NSString *accumulatedAmount;
@property(nonatomic,strong)NSString *grade;
@property(nonatomic,copy)NSString *userphoto;
@property(nonatomic,copy)NSString *username;//nickName
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSNumber *integral;

@property(nonatomic,strong)NSString *userPhone;

+(instancetype)ModelWith:(NSDictionary *)dic;
@end
