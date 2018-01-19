//
//  MainModal.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LianjiuData.h"

@interface MainModal : NSObject

@property(nonatomic,copy)NSNumber           * status;
@property(nonatomic,copy)NSString           * msg;
@property(nonatomic,copy)NSNumber           * total;
@property (strong, nonatomic) LianjiuData   * lianjiuData;

+ (instancetype)toModelWithDict:(NSDictionary *)dict;
@end
