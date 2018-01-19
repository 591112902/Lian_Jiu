//
//  CalculateManager.m
//  盒家健康(新版)
//
//  Created by 洪铭翔 on 17/10/11.
//  Copyright © 2017年 洪铭翔. All rights reserved.
//

#import "CalculateManager.h"

#define UI_Width 750.0000
#define UI_Height 1334.0000

@implementation CalculateManager
+ (CGFloat)calculate_WidthWithWidth:(CGFloat)width {
    return  width / UI_Width * WIDTH;
}
+ (CGFloat)calculate_HeghtWithHeight:(CGFloat)height {
    return height / UI_Height * HEIGHT;
}
+ (UIFont *)calculate_FontWithHeight:(CGFloat)height {
    CGFloat size = height / UI_Height * HEIGHT;
    return [UIFont systemFontOfSize:size];
}
+ (UIFont *)calculate_BoldFontWithHeight:(CGFloat)height weight:(CGFloat)weight {
    CGFloat size = height / UI_Height * HEIGHT;
    return [UIFont systemFontOfSize:size weight:weight];
}
@end
