
//
//  Tools.m
//  cell倒计时
//
//  Created by lihongliang on 16/1/11.
//  Copyright © 2016年 comdosoft. All rights reserved.
//

#import "Tools.h"

@implementation Tools
//根据key返回字典对应的字符串信息
+(NSString*)getStringWith:(NSDictionary*)dict forKey:(NSString*)key{
    NSString *value=@"";
    if (dict!=nil) {
        value=([NSString stringWithFormat:@"%@",[dict objectForKey:key]]==nil||[[NSString stringWithFormat:@"%@",[dict objectForKey:key]] isEqualToString:@"(null)"])?@"":[NSString stringWithFormat:@"%@",[dict objectForKey:key]];
    }
    return value;
}

//返回当前时间的字符串信息
+(NSString*)getStringWithNowTime{
    //得到当前系统日期
    NSDate *date1 = [NSDate date];
    //然后您需要定义一个NSDataFormat的对象
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    //然后设置这个类的dataFormate属性为一个字符串，系统就可以因此自动识别年月日时间
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //之后定义一个字符串，使用stringFromDate方法将日期转换为字符串
    NSString * dateToString = [dateFormat stringFromDate:date1];
    return dateToString;
}

//返回time时间的date类型
+(NSDate*)getDateWithString:(NSString *)time{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:time];
    return date;
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

@end
