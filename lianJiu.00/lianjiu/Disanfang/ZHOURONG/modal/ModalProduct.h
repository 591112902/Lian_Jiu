//
//  ModalProduct.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LianjiuDataP.h"

@interface ModalProduct : NSObject
@property(nonatomic,copy)NSNumber           * status;
@property(nonatomic,copy)NSString           * msg;
@property(nonatomic,copy)NSNumber           * total;
@property (strong, nonatomic) LianjiuDataP   * lianjiuData;

+ (instancetype)toModelWithDict:(NSDictionary *)dict;
@end

