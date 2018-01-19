//
//  ZJNetworking.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ZJNetworking : NSObject

+ (void)requestWithURLByGet:(NSString *)url
            parameters:(NSDictionary *)parameters
               success:(void(^)(id responseObject))success
               failure:(void(^)(NSError *error))failure;

@end
