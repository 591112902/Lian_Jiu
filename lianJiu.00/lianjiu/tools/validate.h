//
//  validate.h
//  YiShiDaiIos
//
//  Created by cnmobi on 15/10/13.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface validate : NSObject
//2、判断用户名，在2－16位
+ (BOOL)CheckInputAccount:(NSString *)name withText:(NSString *)text withminNum:(NSInteger)min withMaxNum:(NSInteger)max;
//3、判断手机号码，1开头的十一位数字
+ (BOOL)CheckInputPhone:(NSString *)name withText:(NSString *)text;
//5、判断密码，6－16位
+ (BOOL)CheckInputPassword:(NSString *)text;
//检查两个字符串是否一样
+ (BOOL)CheckInput:(NSString *)name withString:(NSString *)string wihtString2:(NSString *)string2;
+ (BOOL)CheckInput2:(NSString *)name withString:(NSString *)string wihtString2:(NSString *)string2;
//数字最小-最大位
+ (BOOL)CheckInputOnlyNum:(NSString *)name withText:(NSString *)text withminNum:(NSInteger)min withMaxNum:(NSInteger)max;
//全部电话号码,包括固话
+ (BOOL)CheckInputALLPhone:(NSString *)name withText:(NSString *)text;
//4、判断邮箱
+ (BOOL)CheckInputEail:(NSString *)text;
//检查后面两位小数的金额
+(BOOL)CheckInputMoney:(NSString *)text;
//检查电话号码与邮箱
+ (BOOL)CheckInputALLPhoneAndEmail:(NSString *)name withText:(NSString *)text;
//身份证号
+ (BOOL) CheckInputIdentityCard: (NSString *)identityCard;
@end
