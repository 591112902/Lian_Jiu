//
//  ZJNetworkRequest.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainModal.h"
#import "ModalProduct.h"

@interface ZJNetworkRequest : NSObject

+ (void)getMainPhoneInfos:(void(^)(MainModal *modal))success
                  failure:(void(^)(NSError *error))failure;

+ (void)switchElectronic:(NSString *)categoryId
                   order:(NSInteger)order
                success:(void(^)(MainModal *modal))success
                failure:(void(^)(NSError *error))failure;

+ (void)switchZNBrand:(NSString *)categoryId
                 success:(void(^)(MainModal *modal))success
                 failure:(void(^)(NSError *error))failure;

+ (void)switchBrand:(NSString *)categoryId
            pageNumber:(NSInteger)pageNumber
            pageSize:(NSInteger)pageSize
                 success:(void(^)(MainModal *modal))success
                 failure:(void(^)(NSError *error))failure;

+ (void)getProductInfo:(NSString *)productID
               success:(void(^)(ModalProduct *modal))success
               failure:(void(^)(NSError *error))failure;
@end
