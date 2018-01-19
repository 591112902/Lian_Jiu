//
//  InternationalControl.m
//  location
//
//  Created by cnmobi on 15/12/2.
//  Copyright © 2015年 cnmobi. All rights reserved.
#import "InternationalControl.h"

@implementation InternationalControl
static NSBundle *LanguagesBundle = nil;

+ ( NSBundle * )LanguagesBundle{
    
    return LanguagesBundle;
    
}
+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:@"userLanguage"];
    
    if(string.length == 0){
        
        
//        在iOS9之后就会有问题，可使用
//        
//        [curLanguage hasPrefix:@"zh-Hans"]
        //判断系统语言
//#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex:0])
//#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])
        //获取系统当前语言版本(中文zh-Hans,英文en)
        
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        
        NSString *current = [languages objectAtIndex:0];
        
        string = current;
        
        [def setValue:current forKey:@"userLanguage"];
        
        [def synchronize];//持久化，不加的话不会保存
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    LanguagesBundle = [NSBundle bundleWithPath:path];//生成bundle
}

+(void)setUserlanguage:(NSString *)language{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    LanguagesBundle = [NSBundle bundleWithPath:path];
    NSLog(@"%@",path);
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    [def synchronize];
}
+(NSString *)userLanguage{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:@"userLanguage"];
}
@end
