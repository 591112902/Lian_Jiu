//
//  CreditContenModel.h
//  zaiShang
//
//  Created by cnmobi on 15/12/24.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiaoLiangModel : NSObject
@property (nonatomic,copy)NSString *excellentId;
@property (nonatomic,copy)NSString *excellentName;

@property (nonatomic,copy)NSString *excellentPrice;
@property (nonatomic,copy)NSString *excellentAttributePicture;
@property (nonatomic,copy)NSString *excellentParamData;


+(instancetype)ModelWith:(NSDictionary *)dic;
@end
