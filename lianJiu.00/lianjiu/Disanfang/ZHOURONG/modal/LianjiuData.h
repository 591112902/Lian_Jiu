//
//  LianjiuData.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdElectronic.h"

@interface LianjiuData : NSObject

@property (strong, nonatomic) NSMutableArray *electronics;
@property (strong, nonatomic) NSMutableArray *product;
@property (strong, nonatomic) NSMutableArray *brands;
@property (strong, nonatomic) AdElectronic   *adElectronic;
@property (strong, nonatomic) NSMutableArray *ZNbrands;

@end
