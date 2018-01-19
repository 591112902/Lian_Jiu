//
//  ScrapListViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/8.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ScrapListViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ScrapListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillCellWithModel:(ScrapListViewModel*)model
{
    NSString *urlStr = [model.wasteImage excisionForFistString];
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@""]];
    self.leftIV.contentMode = UIViewContentModeScaleAspectFit;
    self.nameL.text = model.name;
    //
    
   
    
    
    
    
    
    NSString *danwei ;
    NSString *wPriceUnit =[NSString stringWithFormat:@"%@",model.wPriceUnit];
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

    
     self.priceL.text = [NSString stringWithFormat:@"%@元/%@",model.wPriceSingle,danwei];
    
    
    
    
}

@end
