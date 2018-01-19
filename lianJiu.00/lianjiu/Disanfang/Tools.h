//
//  Tools.h
//  cell倒计时
//
//  Created by lihongliang on 16/1/11.
//  Copyright © 2016年 comdosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

//根据key返回字典对应的字符串信息
+(NSString*)getStringWith:(NSDictionary*)dict forKey:(NSString*)key;
//返回当前时间的字符串信息
+(NSString*)getStringWithNowTime;
//返回time时间的date类型
+(NSDate*)getDateWithString:(NSString*)time;
//验证手机号
+ (BOOL) validateMobile:(NSString *)mobile;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
