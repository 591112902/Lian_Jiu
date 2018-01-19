//
//  PinPaiTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/10/10.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "PinPaiTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PinPaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)fillCellWithModel:(XiaoLiangModel*)model{
    
   [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.excellentAttributePicture] placeholderImage:[UIImage imageNamed:@"jinpinshang"] options:  SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
    
    self.headIV.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleL.text = model.excellentName;
    
    
    
      self.priceL.text = [NSString stringWithFormat:@"¥%@",model.excellentPrice];
    
    
    
    
//    NSString *spxqStr = model.excellentParamData;
//    NSData *nsData=[spxqStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *spsxArr =[NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
//    
//    NSArray *childrenArr =[spsxArr[0] objectForKey:@"children"];
//    
//    // [_mutStrID appendString:becomeArr[6]];
//    NSMutableString *mutString = [[NSMutableString alloc] init];
//    NSMutableString *mutString2 = [[NSMutableString alloc] init];
//    for (NSDictionary *temp in childrenArr) {
//        ;
//        [mutString appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"retrieveType"]]];
//        [mutString2 appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"major"]]];
//        // _spsxDataArr addObject:[temp objectForKey:@"retrieveType"];
//        
//    }
//model.excellentParamData
    
   
    
    self.contentL.text =  [NSString stringWithFormat:@"%@",model.excellentParamData];

    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
