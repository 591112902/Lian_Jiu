//
//  ZJRateModal.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJRateRow.h"
#import "ZJRateValue.h"
#import "ZJRateHeader.h"

@interface ZJRateModal : NSObject
@property (strong, nonatomic) NSMutableArray * headers;

-(instancetype)initWithString:(NSString *)paramString;

@end
