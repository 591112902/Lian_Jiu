//
//  NSString+Excision.m
//  zaiShang
//
//  Created by cnmobi on 16/1/6.
//  Copyright © 2016年 CNMOBI. All rights reserved.
//

#import "NSString+Excision.h"

@implementation NSString (Excision)
-(NSArray *)removeSymbol
{
    NSArray *photos =[self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";,"]];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:photos];
    [arr removeObject:@""];
    return  arr;
}
-(NSString *)excisionForFistString
{
    NSArray *photos =[self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";,"]];

    NSMutableArray *arr = [NSMutableArray arrayWithArray:photos];
    [arr removeObject:@""];
    if (arr.count>0) {
        return arr.firstObject;
    }else{
        return @"";
    }
}
/**
 * 过滤系统表情字符
 */
- (NSString *)filterEmoji {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

#pragma -mark 密码设置
- (BOOL)correspondToPasswordRequirements{
    if (self.length < 6) {
        return NO;
    }
    int digitCount = 0;//数字
    int capitalCount = 0;
    int lowercaseLetterCount = 0;
    int specialCharacterCount = 0;
    
    for (int i = 0; i < self.length; i++) {
        unichar subString = [self characterAtIndex:i];
        HZLog(@"%c", subString);
        if(subString >= '0' && subString <= '9'){
            digitCount++;
        }else if (subString >= 'a' && subString <= 'z') {
            lowercaseLetterCount++;
        }else if (subString >= 'A' && subString <= 'Z') {
            capitalCount++;
        }else{
            specialCharacterCount++;
        }
    }
    HZLog(@"%d %d %d %d", digitCount, capitalCount, lowercaseLetterCount, specialCharacterCount);

    if
//        ((digitCount != 0 && capitalCount != 0 && lowercaseLetterCount != 0 && specialCharacterCount != 0) ||
//        (digitCount == 0 && capitalCount != 0 && lowercaseLetterCount != 0 && specialCharacterCount != 0) ||
//        (digitCount != 0 && capitalCount == 0 && lowercaseLetterCount != 0 && specialCharacterCount != 0) ||
//        (digitCount != 0 && capitalCount != 0 && lowercaseLetterCount == 0 && specialCharacterCount != 0) ||
//        (digitCount != 0 && capitalCount != 0 && lowercaseLetterCount != 0 && specialCharacterCount == 0))
    
        (
         (digitCount!= 0 && capitalCount == 0 && lowercaseLetterCount == 0 && specialCharacterCount == 0) ||
         (digitCount== 0 && capitalCount == 0 && lowercaseLetterCount != 0 && specialCharacterCount == 0)
            ) {
        return YES;
    }else{
        return NO;}
}

@end
