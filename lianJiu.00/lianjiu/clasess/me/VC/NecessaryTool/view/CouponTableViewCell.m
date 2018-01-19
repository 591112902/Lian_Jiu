//
//  CouponTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/6.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)fillCellWithModel:(CouponModel*)model{
    self.couponMoneyL.text = [NSString stringWithFormat:@"%@元",model.couponMoney];
    self.couponTitleL.text = model.couponTitle?model.couponTitle:@"";
    
    
    
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd"];// HH:mm:ss
    
    //NSDate *startD =[date dateFromString:model.startTime];
    
    NSDate *startD = [NSDate date];//当前时间===为开始时间计算
    
    NSDate *endD = [date dateFromString:model.endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
    int house = (int)value / (24 *3600)%3600;
    
    int day = (int)value / (24 *3600);
    
    NSString *str;
    
    if (day != 0) {
        
        if (day<0) {
            day = 0;
        }
        
        str = [NSString stringWithFormat:@"剩余%d天",day];
        
    }else if (day==0 && house !=0) {
        if (house<0) {
            house = 0;
        }
        
        
        str = [NSString stringWithFormat:@"剩余%d小时",house];
        
    }else if (day==0 && house==0 && minute!=0) {
        if (minute<0) {
            minute = 0;
        }
        
        str = [NSString stringWithFormat:@"剩余%d分钟",minute];
        
    }else{
        if (second<0) {
            second = 0;
        }
        str = [NSString stringWithFormat:@"剩余%d秒",second];
        
    }
    
    
    
    
    
    self.endTimeL.text = [NSString stringWithFormat:@"%@到期(%@)",model.endTime,str];
}

@end
