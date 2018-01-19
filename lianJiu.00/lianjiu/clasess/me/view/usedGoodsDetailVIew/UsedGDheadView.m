//
//  ZJLonginView.m
//  jianzhu
//
//  Created by iOS开发 on 15/11/11.
//  Copyright © 2015年 wanglinlei. All rights reserved.
//

#import "UsedGDheadView.h"
#import "UIImageView+WebCache.h"
@implementation UsedGDheadView
#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // UI搭建
       [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    self.backgroundColor = BGColor;
    
    
//    UIView *cutView = [[UIView alloc] init];
//    cutView.backgroundColor = BGColor;
//    cutView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.width*0.496, [UIScreen mainScreen].bounds.size.width, 5);
//    [self addSubview:cutView];
}



@end
