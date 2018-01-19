//
//  ZJNetworkRequest.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ZJNetworkRequest.h"
#import "ZJNetworking.h"


static NSString *const productElectronicURL = @"http://101.132.38.30:8085/rest/index/productElectronic";
static NSString *const electronicSwitchURL  = @"http://101.132.38.30:8085/rest/product/electronicSwitch";
static NSString *const brandSwitchURL  = @"http://101.132.38.30:8085/rest/product/brandSwitch";
static NSString *const znbrandSwitchURL  = @"http://101.132.38.30:8085/rest/product/categorySwitch";
static NSString *const selectProductURL  = @"http://101.132.38.30:8085/rest/product/selectProduct";

@implementation ZJNetworkRequest

+ (void)getMainPhoneInfos:(void(^)(MainModal *modal))success
                  failure:(void(^)(NSError *error))failure{
    
    [ZJNetworking requestWithURLByGet:productElectronicURL parameters:nil success:^(id responseObject) {
        MainModal *modal = [MainModal toModelWithDict:responseObject];
        success(modal);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)switchElectronic:(NSString *)categoryId order:(NSInteger)order success:(void(^)(MainModal *modal))success failure:(void(^)(NSError *error))failure{
    
    //NSDictionary *parameters = @{@"categoryId":categoryId};
    //order:对应的值顺序为：手机 1，平板电脑 2，笔记本 3，摄影摄像 4，智能数码 5，卖家电 6  传对应的数字

    [ZJNetworking requestWithURLByGet:[NSString stringWithFormat:@"%@/%@/%ld",electronicSwitchURL,categoryId,(long)order] parameters:nil success:^(id responseObject) {
        
        MainModal *modal = [MainModal toModelWithDict:responseObject];
        
        success(modal);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)switchZNBrand:(NSString *)categoryId success:(void(^)(MainModal *modal))success failure:(void(^)(NSError *error))failure{
    
    [ZJNetworking requestWithURLByGet:[NSString stringWithFormat:@"%@/%@",znbrandSwitchURL,categoryId] parameters:nil success:^(id responseObject) {
        
        MainModal *modal = [MainModal toModelWithDict:responseObject];
        
        success(modal);
    } failure:^(NSError *error) {
        failure(error);
    }];

    
}

+ (void)switchBrand:(NSString *)categoryId pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(MainModal *modal))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%ld",brandSwitchURL,categoryId,(long)pageNumber,(long)pageSize];
    
    [ZJNetworking requestWithURLByGet: url parameters:nil success:^(id responseObject) {
        
        MainModal *modal = [MainModal toModelWithDict:responseObject];
        
        success(modal);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getProductInfo:(NSString *)productID success:(void(^)(ModalProduct *modal))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/%@/id=126",ZRSelectProduct,productID];
    
    [ZJNetworking requestWithURLByGet: url parameters:nil success:^(id responseObject) {
        
        ModalProduct *modal = [ModalProduct toModelWithDict:responseObject];
        
        success(modal);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

@end
