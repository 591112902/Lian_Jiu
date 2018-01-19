//
//  UICustomDatePicker.m
//  LengBaoBao
//
//  Created by mac on 2017/6/25.
//  Copyright © 2017年 leng360. All rights reserved.
//

#import "UICustomDatePicker.h"

@interface UICustomDatePicker()


@property (weak, nonatomic) IBOutlet UIView        *bottomView;
@property (nonatomic, copy  ) void(^dateBlock)(NSDate *date);
@property (nonatomic, copy  ) void(^cancelBlock)();
@end

@implementation UICustomDatePicker

+ (void) showCustomDatePickerAtView:(UIView *)superView choosedDateBlock:(void (^)(NSDate *date))date cancelBlock:(void(^)())cancel
{
    if ([superView viewWithTag:1887]) {
        [[superView viewWithTag:1887] removeFromSuperview];
    }
    UICustomDatePicker *picker = [[NSBundle mainBundle] loadNibNamed:@"UICustomDatePicker" owner:nil options:nil][0];
    picker.tag = 1887;
    
   
    
    
    [superView addSubview:picker];
    picker.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superView
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1.0
                                                        constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    if (date) {
        picker.dateBlock = date;
    }
    if (cancel) {
        picker.cancelBlock = cancel;
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //初始化的工作可以在这里完成
        
        
//        self.datePicker.datePickerMode = UIDatePickerModeDate;
//        [self.datePicker addTarget:self action:@selector(seletedDate:) forControlEvents:UIControlEventValueChanged];

        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.maximumDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60*7];
}

- (IBAction)dismissBtnAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}
- (IBAction)confirmBtnAction:(id)sender {
    if (self.dateBlock) {
        self.dateBlock(self.datePicker.date);
    }
    [self removeFromSuperview];
}


//-(void)seletedDate:(UIDatePicker *)picker{
//    //UIDatePicker时间范围限制
//    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60*7];
//    picker.maximumDate = maxDate;
//    NSDate *minDate = [NSDate date];
//    picker.maximumDate = minDate;
//}

@end
