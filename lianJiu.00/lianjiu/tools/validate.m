//
//  validate.m
//  YiShiDaiIos
//
//  Created by cnmobi on 15/10/13.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
/**检查输入的邮箱*/

#import "validate.h"

@implementation validate

//检查两个字符串是否一样  2注册
+ (BOOL)CheckInput:(NSString *)name withString:(NSString *)string wihtString2:(NSString *)string2 {

    
    BOOL basicTest = [string isEqualToString:string2];
    if (!basicTest) {
        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,@"不一致"] toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
    return basicTest;
    
}
// 3注册
+ (BOOL)CheckInput2:(NSString *)name withString:(NSString *)string wihtString2:(NSString *)string2 {
    
    
    
    if (string.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入验证码" toView:[UIApplication sharedApplication].keyWindow];
        return NO;

    }
    
    BOOL basicTest = [string isEqualToString:string2];
    if (!basicTest) {
        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,@"不正确"] toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
    return basicTest;
    
}
//2、判断用户名，在2－16位

+ (BOOL)CheckInputAccount:(NSString *)name withText:(NSString *)text withminNum:(NSInteger)min withMaxNum:(NSInteger)max{
    
    
    
    
    if (text.length==0) {
        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",@"请输入",name] toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
    if (text.length < 6) {
        
        [MBProgressHUD showNotPhotoError:@"密码长度至少6位" toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }

    
    
//    if (text.length<min) {
//        NSMutableString *promtlText = [NSMutableString stringWithString:CustomLocalizedString(@"不能小于100位", nil)];
//        NSRange range =[promtlText rangeOfString:@"100"];
//        [promtlText replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%li",(long)min]];
//        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,promtlText] toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }else if (text.length>max){
//        NSMutableString *promtlText = [NSMutableString stringWithString:CustomLocalizedString(@"不能大于100位", nil)];
//        NSRange range =[promtlText rangeOfString:@"100"];
//        [promtlText replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%li",(long)max]];
//        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,promtlText] toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
    
    
//    NSString*Regex = [NSString stringWithFormat:@"^\\w{%li,%li}",(long)min, (long)max];
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    if (![emailTest evaluateWithObject:text]) {
////#warning   注册时输入特殊符号 出现密码不正确 Regex
//        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,CustomLocalizedString(@"不正确", nil)] toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
//    return [emailTest evaluateWithObject:text];
    
    return YES;
}

//3、判断手机号码，1开头的十一位数字

+ (BOOL)CheckInputPhone:(NSString *)name withText:(NSString *)text {
    
    if (text.length==0) {
        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,@"不能为空"] toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
    //联系电话不做限制 银行卡不做限制 
//    NSString *Regex = @"1\\d{10}";
    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    if (![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,CustomLocalizedString(@"不正确", nil)] toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
//    return [emailTest evaluateWithObject:text];
    return YES;
    
}
//全部电话号码,包括固话
+ (BOOL)CheckInputALLPhone:(NSString *)name withText:(NSString *)text {
    
    if (text.length==0) {
        
        
        
        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",@"请输入",name] toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
    
    
//    NSString *Regex = @"(^(\\(\\d{3,4}\\)|\\d{3,4}-)?\\d{7,8})｜(1\\d{10})";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    if (![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"请务必正确填写手机号"] toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
//    return [emailTest evaluateWithObject:text];
    
    return YES;
    
}
//数字最小-最大位
+ (BOOL)CheckInputOnlyNum:(NSString *)name withText:(NSString *)text withminNum:(NSInteger)min withMaxNum:(NSInteger)max{
    
    if (text.length==0) {
        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,@"不能为空"] toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
//    NSString*Regex = [NSString stringWithFormat:@"^\\d{%ld,%ld}$",(long)min,(long)max];
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    if (![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,CustomLocalizedString(@"不正确", nil)] toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
//    return [emailTest evaluateWithObject:text];
    
    return YES;
    
}


//4、判断邮箱

+ (BOOL)CheckInputEail:(NSString *)text {
    
//    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    
    if (text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入手机号" toView:[UIApplication sharedApplication].keyWindow];
        
        return NO;
    }
    
    
//    else if (![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请务必输入正确的邮箱", nil) toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
    return YES;
    
}

//5、判断密码，6－16位

+ (BOOL)CheckInputPassword:(NSString *)text

{
    
//    NSString *Regex = @"\\w{6,16}";
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    
//    return [emailTest evaluateWithObject:text];
    return YES;
    
}
//检查电话号码与邮箱
+ (BOOL)CheckInputALLPhoneAndEmail:(NSString *)name withText:(NSString *)text {
    
    if (text.length==0) {
        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,@"不能为空"] toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
//    NSString *phoneRegex = @"(^(\\(\\d{3,4}\\)|\\d{3,4}-)?\\d{7,8})｜(1\\d{10})";
//    
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
//    
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    
//    if (![phoneTest evaluateWithObject:text]&&![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%@%@",name,CustomLocalizedString(@"不正确", nil)] toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
    return YES;
    
    
}
//检查后面两位小数的金额
+(BOOL)CheckInputMoney:(NSString *)text
{
   // NSLog(@"金额:%ld",(long)[text integerValue]);
    if (text.length==0||[text doubleValue]<=0) {
        [MBProgressHUD showNotPhotoError:@"金额不能为空" toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
//    NSString *Regex = @"^(([1-9]\\d*)|0)(\\.\\d{2})?$";
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//
//    if (![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"金额不正确", nil) toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
    return YES;
}
//身份证号
+ (BOOL) CheckInputIdentityCard: (NSString *)text
{
    if (text.length==0) {
        [MBProgressHUD showNotPhotoError:@"有效证件号码不能为空" toView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    
//    if (![identityCardPredicate evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请输入正确的身份证号码", nil) toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
    return YES;
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
//    NSString *userNameRegex = @"^[A-Za-z0-9]{2,20}+$";
//    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
//    BOOL B = [userNamePredicate evaluateWithObject:name];
//    return B;
    return YES;
}
//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
//    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
//    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
//    return [passWordPredicate evaluateWithObject:passWord];
    return YES;
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
//    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
//    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
//    return [passWordPredicate evaluateWithObject:nickname];
    return YES;
}



@end
