//
//  Product.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property(nonatomic,copy)NSString    * productId;
@property(nonatomic,copy)NSString    * productName;

@property(nonatomic,copy)NSString    * productStatus;
@property(nonatomic,copy)NSString    * productBarcode;

@property(nonatomic,copy)NSString    * productMasterPicture;
@property(nonatomic,copy)NSString    * productSubPicture;
@property(nonatomic,copy)NSString    * productParamData;
@property(nonatomic,copy)NSString    * productPrice;
@property(nonatomic,copy)NSString    * productPriceAlliance;
@property(nonatomic,copy)NSString    * categoryId;
@property(nonatomic,copy)NSString    * productVolume;
@property(nonatomic,copy)NSString    * productCreated;
@property(nonatomic,copy)NSString    * productUpdated;
@property(nonatomic,copy)NSString    * productRetriType;
@property(nonatomic,copy)NSString    * maxrecyclePrice;

@end
