//
//  CalculateManager.h
//  盒家健康(新版)
//
//  Created by 洪铭翔 on 17/10/11.
//  Copyright © 2017年 洪铭翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define Calculate_Width(width) [CalculateManager calculate_HeghtWithHeight:width]
#define Calculate_Height(height) [CalculateManager calculate_HeghtWithHeight:height]
#define Calculate_Font(height) [CalculateManager calculate_FontWithHeight:height]
#define Calculate_BoldFont(h,w) [CalculateManager calculate_BoldFontWithHeight:h weight:w]

//设备型号
#define IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )

@interface CalculateManager : NSObject

+ (CGFloat)calculate_WidthWithWidth:(CGFloat)width;
+ (CGFloat)calculate_HeghtWithHeight:(CGFloat)height;
+ (UIFont *)calculate_FontWithHeight:(CGFloat)height;
+ (UIFont *)calculate_BoldFontWithHeight:(CGFloat)height weight:(CGFloat)weight;
@end
