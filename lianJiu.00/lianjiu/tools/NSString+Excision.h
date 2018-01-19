//
//  NSString+Excision.h
//  zaiShang
//
//  Created by cnmobi on 16/1/6.
//  Copyright © 2016年 CNMOBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Excision)
-(NSArray *)removeSymbol;//分解字符串
-(NSString *)excisionForFistString;//分解字符串，返回第一个
-(NSString *)filterEmoji;//过滤字符串
- (BOOL)correspondToPasswordRequirements;
@end
