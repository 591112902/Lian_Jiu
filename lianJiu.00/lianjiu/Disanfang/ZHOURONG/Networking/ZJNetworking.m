//
//  ZJNetworking.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ZJNetworking.h"


@implementation ZJNetworking

+ (void)requestWithURLByGet:(NSString *)url
                 parameters:(NSDictionary *)parameters
                    success:(void(^)(id responseObject))success
                    failure:(void(^)(NSError *error))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        success(responseObject);
        NSLog(@"JSON: %@", url);
        //NSLog(@"JSON: %@", responseObject);
        NSLog(@"------------------");
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        failure(error);
    }];
}


@end
