//
//  DetailsTableViewCell.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "DetailsTableViewCell.h"

@implementation DetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.orItemsNameL.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, [UIScreen mainScreen].bounds.size.width/320.0*0, [UIScreen mainScreen].bounds.size.width/320.0*90, 44);
    self.orItemsNumL.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*98, [UIScreen mainScreen].bounds.size.width/320.0*12, [UIScreen mainScreen].bounds.size.width/320.0*75, 21);
    self.orItemsBeforePriceL.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*173, [UIScreen mainScreen].bounds.size.width/320.0*12, [UIScreen mainScreen].bounds.size.width/320.0*75, 21);
    self.zjmxBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*251, [UIScreen mainScreen].bounds.size.width/320.0*7, [UIScreen mainScreen].bounds.size.width/320.0*61, 30);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillCellWithModel:(MingXiDanModel*)model{
    
    
    
    
    
    
    
    self.orItemsNameL.text = model.orItemsName;
    
    NSString *unitStr ;
    if ([model.orItemsPriceUnit isEqualToNumber:@0]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f米",model.orItemsNum.floatValue];
        unitStr = @"/米";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@1]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f个",model.orItemsNum.floatValue];
        unitStr = @"/个";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@2]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f克",model.orItemsNum.floatValue];
        unitStr = @"/克";
    }
    else if ([model.orItemsPriceUnit isEqualToNumber:@3]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f千克",model.orItemsNum.floatValue];
        unitStr = @"/千克";
    }
    else if ([model.orItemsPriceUnit isEqualToNumber:@4]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f台",model.orItemsNum.floatValue];
        unitStr = @"/台";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@5]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f斤",model.orItemsNum.floatValue];
        unitStr = @"/斤";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@6]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f公斤",model.orItemsNum.floatValue];
        unitStr = @"/公斤";
    }
    else if ([model.orItemsPriceUnit isEqualToNumber:@7]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%.2f部",model.orItemsNum.floatValue];
        unitStr = @"/部";
    }

    
     self.zjmxBtn.hidden = NO;
    self.orItemsBeforePriceL.text = [NSString stringWithFormat:@"%@元%@",model.orItemsPrice,unitStr?unitStr:@""];

    
    
    
    
//    if ([model.orItemsStemFrom isEqualToString:@"1"]) {//家电/质检明细
//        
//        self.orItemsNumL.text = [NSString stringWithFormat:@"1台"];
//        
//        
//        self.zjmxBtn.hidden = NO;
//        self.orItemsBeforePriceL.text = [NSString stringWithFormat:@"%@元",model.orItemsPrice];
//        
//    }else{
//        // self.zjmxBtn.hidden = NO;
//        self.zjmxBtn.hidden = NO;
//        
//        self.orItemsBeforePriceL.text = [NSString stringWithFormat:@"%@元/%@",model.orItemsPrice,unitStr];
//    }

    
    
    
    
}
@end
