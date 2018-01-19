//
//  DetailsTableViewCell.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WHSMXTableViewCell.h"

@implementation WHSMXTableViewCell

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
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@米",model.orItemsNum];
        unitStr = @"米";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@1]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@个",model.orItemsNum];
        unitStr = @"个";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@2]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@克",model.orItemsNum];
        unitStr = @"克";
    }
    else if ([model.orItemsPriceUnit isEqualToNumber:@3]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@千克",model.orItemsNum];
        unitStr = @"千克";
    }
    else if ([model.orItemsPriceUnit isEqualToNumber:@4]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@台",model.orItemsNum];
        unitStr = @"台";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@5]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@斤",model.orItemsNum];
        unitStr = @"斤";
    }else if ([model.orItemsPriceUnit isEqualToNumber:@6]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@公斤",model.orItemsNum];
        unitStr = @"公斤";
    }
    else if ([model.orItemsPriceUnit isEqualToNumber:@7]) {
        self.orItemsNumL.text = [NSString stringWithFormat:@"%@部",model.orItemsNum];
        unitStr = @"部";
    }else{
        unitStr = @"";
    }

    
    

    
    
    
    
    if ([model.orItemsStemFrom isEqualToNumber:@1]) {//家电/质检明细
        
        self.orItemsNumL.text = [NSString stringWithFormat:@"1台"];
        
        
        self.zjmxBtn.hidden = NO;
        self.orItemsBeforePriceL.text = [NSString stringWithFormat:@"%@元",model.orItemsPrice];
        
    }else{
        // self.zjmxBtn.hidden = NO;
        self.zjmxBtn.hidden = YES;
        
        self.orItemsBeforePriceL.text = [NSString stringWithFormat:@"%@元/%@",model.orItemsPrice,unitStr];
    }

    
    
    
    
}
@end
