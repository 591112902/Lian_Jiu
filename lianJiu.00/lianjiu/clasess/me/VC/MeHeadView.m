//
//  ZJLonginView.m
//  jianzhu
//
//  Created by iOS开发 on 15/11/11.
//  Copyright © 2015年 wanglinlei. All rights reserved.
//

#import "MeHeadView.h"

@implementation MeHeadView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
   
    self.headIV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*9, [UIScreen mainScreen].bounds.size.width/320.0*20, [UIScreen mainScreen].bounds.size.width/320.0*30, [UIScreen mainScreen].bounds.size.width/320.0*30);
//    self.headIV.layer.cornerRadius = [UIScreen mainScreen].bounds.size.width/320.0*15;
//    self.headIV.layer.masksToBounds = YES;
    
    self.titleLLLL.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*48, [UIScreen mainScreen].bounds.size.width/320.0*25, 170, 21);
    
    
    
    
    self.payButton.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*233, [UIScreen mainScreen].bounds.size.width/320.0*21, 80, 30);
    
    self.payButton.layer.borderWidth = 1;
    self.payButton.layer.borderColor = MAINColor.CGColor;
    self.payButton.layer.cornerRadius = 5;
    
    
     self.ziChanL.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*12.5, [UIScreen mainScreen].bounds.size.width/320.0*91, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*21);
     self.zhuanQuL.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*115, [UIScreen mainScreen].bounds.size.width/320.0*91, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*21);
     self.huanBaoL.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*217.5, [UIScreen mainScreen].bounds.size.width/320.0*91, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*21);
    
    
    self.ziChanMoney.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*12.5, [UIScreen mainScreen].bounds.size.width/320.0*115, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*34);
    self.zhuanQuMoney.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*115, [UIScreen mainScreen].bounds.size.width/320.0*115, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*34);
    self.huanBaoLevel.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*217.5, [UIScreen mainScreen].bounds.size.width/320.0*115, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*34);
    
    
    
    
    
    
    
    
    self.backL1.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*110, [UIScreen mainScreen].bounds.size.width/320.0*91, 2, [UIScreen mainScreen].bounds.size.width/320.0*63);
    self.backL2.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*208, [UIScreen mainScreen].bounds.size.width/320.0*91, 2, [UIScreen mainScreen].bounds.size.width/320.0*63);
    

    
}

@end
