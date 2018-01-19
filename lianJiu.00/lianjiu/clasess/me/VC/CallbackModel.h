//
//  CallbackModel.h
//  lianjiu
//
//  Created by 123 on 17/11/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallbackModel : NSObject

@property (nonatomic, strong) NSString *orItemsRecycleType;

@property (nonatomic, strong) NSString *orItemsName;
@property (nonatomic, strong) NSString *orItemsPicture;
@property (nonatomic, strong) NSString *orItemsNum;
@property (nonatomic, strong) NSString *orItemsPrice;
@property (nonatomic, strong) NSString *orItemsId;

@property (nonatomic, strong) NSString *orItemsStatus;
@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)ModelWith:(NSDictionary *)dic;

@end
