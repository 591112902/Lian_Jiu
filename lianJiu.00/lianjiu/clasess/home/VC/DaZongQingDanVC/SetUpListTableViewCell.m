//
//  ChanPinListTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "SetUpListTableViewCell.h"

@implementation SetUpListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 0, [UIScreen mainScreen].bounds.size.width/320.0*304, 1);
    self.rightLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*312, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.bottomLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 34, [UIScreen mainScreen].bounds.size.width/320.0*304, 1);
    self.cneter1Line.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*109, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.leftLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.center2Line.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*210, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.h0L.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 0, [UIScreen mainScreen].bounds.size.width/320.0*102, 35);
    self.h1L.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*109, 0, [UIScreen mainScreen].bounds.size.width/320.0*102, 35);
    self.h2L.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*210, 0, [UIScreen mainScreen].bounds.size.width/320.0*102, 35);

    
    
    self.bulkNumTF.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*216, 5, [UIScreen mainScreen].bounds.size.width/320.0*57, 24);
    
    self.bulkNum_UnitLL.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*275, 1, [UIScreen mainScreen].bounds.size.width/320.0*37, 33);


    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillCellWithModel:(SetUpListModel*)model
{
    NSString *danwei ;
    NSString *wPriceUnit =[NSString stringWithFormat:@"%@",model.priceUnit];
    if ([wPriceUnit isEqualToString:@"0"]) {
        danwei = @"米";
    }else if ([wPriceUnit isEqualToString:@"1"]) {
        danwei = @"个";
    }else if ([wPriceUnit isEqualToString:@"2"]) {
        danwei = @"克";
    }else if ([wPriceUnit isEqualToString:@"3"]) {
        danwei = @"千克";
    }else if ([wPriceUnit isEqualToString:@"4"]) {
        danwei = @"台";
    }else if ([wPriceUnit isEqualToString:@"5"]) {
        danwei = @"斤";
    }else if ([wPriceUnit isEqualToString:@"6"]) {
        danwei = @"公斤";
    }else if ([wPriceUnit isEqualToString:@"7"]) {
        danwei = @"部";
    }

    
    self.nameL.text = model.bulkName?model.bulkName:@"";
    self.priceSingleL.text = [NSString stringWithFormat:@"%@元/%@",model.priceSingle,danwei];
    self.bulkNum_UnitLL.text = danwei?danwei:@"";
    self.bulkNumTF.text =  [NSString stringWithFormat:@"%@",model.bulkNum?model.bulkNum:@""];

}
-(void)fillCellWithCModel:(CommitListModel*)model{
    
    NSString *danwei ;
    NSString *wPriceUnit =[NSString stringWithFormat:@"%@",model.bulkItemUnit];
    if ([wPriceUnit isEqualToString:@"0"]) {
        danwei = @"米";
    }else if ([wPriceUnit isEqualToString:@"1"]) {
        danwei = @"个";
    }else if ([wPriceUnit isEqualToString:@"2"]) {
        danwei = @"克";
    }else if ([wPriceUnit isEqualToString:@"3"]) {
        danwei = @"千克";
    }else if ([wPriceUnit isEqualToString:@"4"]) {
        danwei = @"台";
    }else if ([wPriceUnit isEqualToString:@"5"]) {
        danwei = @"斤";
    }else if ([wPriceUnit isEqualToString:@"6"]) {
        danwei = @"公斤";
    }else if ([wPriceUnit isEqualToString:@"7"]) {
        danwei = @"部";
    }
    
    
    self.nameL.text = model.bulkItemName?model.bulkItemName:@"";
    self.priceSingleL.text = [NSString stringWithFormat:@"%@元/%@",model.bulkItemPrice,danwei];
    self.bulkNumL.text = [NSString stringWithFormat:@"%@%@",model.bulkItemNum,danwei];

}
@end
