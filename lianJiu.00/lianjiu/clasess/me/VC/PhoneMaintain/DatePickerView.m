//
//  DatePickerView.m
//  DatePickerStudy
//
//  Created by 张发行 on 16/9/5.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView


- (DatePickerView *)initWithCustomeHeight:(CGFloat)height
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height=height<200?200:height)];
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.05].CGColor;
        
        //创建取消 确定按钮
        UIButton *cannel = [UIButton buttonWithType:UIButtonTypeCustom];
        cannel.frame = CGRectMake(20, 5, 50, 40);
        [cannel setTitle:@"取消" forState:0];
        [cannel setTitleColor:[UIColor colorWithRed:10/255.0 green:130/255.0 blue:243/255.0 alpha:1] forState:0];
        cannel.tag = 1;
        [cannel addTarget:self action:@selector(cannelOrConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cannel];
        
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm.frame = CGRectMake(SCREEN_WIDTH-70, 0, 50, 40);
        [confirm setTitle:@"确定" forState:0];
        [confirm setTitleColor:[UIColor colorWithRed:10/255.0 green:130/255.0 blue:243/255.0 alpha:1] forState:0];
        confirm.tag = 2;
        [confirm addTarget:self action:@selector(cannelOrConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirm];
        
        // 创建datapikcer
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, height-40)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        self.datePicker.minimumDate = [NSDate date];
        self.datePicker.maximumDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60*7];

        
        
        // 本地化
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        
        
        
        
        
//        //当前时间创建NSDate
//        NSDate *localDate = [NSDate date];
//        //在当前时间加上的时间：格里高利历
//        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//        //设置时间
//        [offsetComponents setYear:0];
//        [offsetComponents setMonth:0];
//        [offsetComponents setDay:7];
//        [offsetComponents setHour:0];
//        [offsetComponents setMinute:0];
//        [offsetComponents setSecond:0];
//        //设置最大值时间
//        NSDate *maxDate = [gregorian dateByAddingComponents:offsetComponents toDate:localDate options:0];
//        //设置属性
//        self.datePicker.minimumDate = localDate;
//        self.datePicker.maximumDate = maxDate;
        
        
        
        
        
        
        
        
        
        
        
        
        
        // 日期控件格式
//        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        
        
        
        
        
        
        
        
        
        
        [self addSubview:_datePicker];

    }
    return self;
}


//计算某个时间与此刻的时间间隔（天）
- (NSString *)dayIntervalFromNowtoDate:(NSString *)dateString
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *d=[date dateFromString:dateString];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate *dat = [NSDate date];
    NSString *nowStr = [date stringFromDate:dat];
    NSDate *nowDate = [date dateFromString:nowStr];
    
    NSTimeInterval now=[nowDate timeIntervalSince1970]*1;
    
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    timeString = [NSString stringWithFormat:@"%f", cha/86400];
    timeString = [timeString substringToIndex:timeString.length-7];
    
    if ([timeString intValue] < 0) {
        
        timeString = [NSString stringWithFormat:@"%d",-[timeString intValue]];
    }
    
    return timeString;
    
}

//选择确定或者取消
- (void)cannelOrConfirm:(UIButton *)sender
{
    if (sender.tag==2) {
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString *choseDateString = [dateformatter stringFromDate:_datePicker.date];
        
//        //如果选择的日期是未来
//        if ([[[NSDate date] laterDate:self.datePicker.date] isEqualToDate:self.datePicker.date]) {
//            NSLog(@"对不起，不能选择将来时！");
//            return;
//        }
        
        //计算出剩余多久生日
        //拿到生日中的 月&日 年份为今年 拼接起来 转化为时间 与今天相减
        NSArray *tempArr = [choseDateString componentsSeparatedByString:@"-"];
        
        NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
        [currentFormatter setDateFormat:@"yyyy"];
        NSString *currentYear = [currentFormatter stringFromDate:[NSDate date]];
        
        NSString *appendString = [NSString stringWithFormat:@"%@-%@-%@",currentYear,tempArr[1],tempArr[2]];
        
        
        NSDate *appendDate = [dateformatter dateFromString:appendString];
        
        //将此刻时间转换为与选择时间格式一致
        NSDate *now = [NSDate date];
        NSString *nowStr = [dateformatter stringFromDate:now];
        NSDate *nowDate = [dateformatter dateFromString:nowStr];
        
        
        //判断拼接后的时间与此刻时间对比
        if ([[nowDate earlierDate:appendDate] isEqualToDate:appendDate]) {
            //拼接后在当前时间之前 重新拼接 年份+1
            if (![nowDate isEqualToDate:appendDate]) {
                
                appendString = [NSString stringWithFormat:@"%d-%@-%@",[currentYear intValue]+1,tempArr[1],tempArr[2]];
            }
            
        }
        
        NSString *intercalStr = [self dayIntervalFromNowtoDate:appendString];
        
        self.confirmBlock(choseDateString,intercalStr);

        NSLog(@"intercalStr==%@",intercalStr);
        
    }
    self.cannelBlock();
}


@end
