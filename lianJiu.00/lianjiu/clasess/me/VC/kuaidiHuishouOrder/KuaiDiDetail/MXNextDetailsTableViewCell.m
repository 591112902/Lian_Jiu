//
//  DetailsTableViewCell.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "MXNextDetailsTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MXNextDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.zjbgBtn.layer.cornerRadius = 2;
    self.zjbgBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillCellWithModel:(JinQiJiaModel*)model{
   
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.orItemsPicture]];
    self.orItemsNameL.text = model.orItemsName?model.orItemsName:@"";
    self.orItemsPriceL.text = [NSString stringWithFormat:@"%@元",model.orItemsPrice];
//    
//    NSString *unitStr ;
//    if ([model.unit isEqualToNumber:@0]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@米",model.orItemsNum];
//        unitStr = @"米";
//    }else if ([model.unit isEqualToNumber:@1]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@个",model.orItemsNum];
//        unitStr = @"个";
//    }else if ([model.unit isEqualToNumber:@2]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@克",model.orItemsNum];
//        unitStr = @"克";
//    }
//    else if ([model.unit isEqualToNumber:@3]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@千克",model.orItemsNum];
//        unitStr = @"千克";
//    }
//    else if ([model.unit isEqualToNumber:@4]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@台",model.orItemsNum];
//        unitStr = @"台";
//    }else if ([model.unit isEqualToNumber:@5]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@斤",model.orItemsNum];
//        unitStr = @"斤";
//    }else if ([model.unit isEqualToNumber:@6]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@公斤",model.orItemsNum];
//        unitStr = @"公斤";
//    }
//    else if ([model.unit isEqualToNumber:@7]) {
//        self.orItemsNumL.text = [NSString stringWithFormat:@"%@部",model.orItemsNum];
//        unitStr = @"部";
//    }
//
//    
//    
//
//    
//    
//    
//    
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
//        self.zjmxBtn.hidden = YES;
//        
//        self.orItemsBeforePriceL.text = [NSString stringWithFormat:@"%@元/%@",model.orItemsPrice,unitStr];
//    }

    
    
    
    
}
@end
