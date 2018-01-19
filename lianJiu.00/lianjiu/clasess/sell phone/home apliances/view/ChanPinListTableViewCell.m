//
//  ChanPinListTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ChanPinListTableViewCell.h"

@implementation ChanPinListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillCellWithModel:(ChanPinListModel*)model
{
    
//    if (![model.productImage isKindOfClass:[NSNull class]]) {
//        
//        [self.leftIV sd_setImageWithURL:[NSURL URLWithString:model.productImage?model.productImage:@""] placeholderImage:[UIImage imageNamed:@"Selling.png"]];
//    }
//   
    
    
    self.nameL.text = model.productName;
    //self.priceL.text = [NSString stringWithFormat:@"最高回收价%@元",model.productPriceAlliance];
    
    
    
    
    
    
    
    NSString *banceStr = [NSString stringWithFormat:@"%@",model.productPriceAlliance];//要变色的字
    NSString *str1 =  [NSString stringWithFormat:@"最高回收价 %@",banceStr];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str1];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:banceStr].location, [[noteStr string] rangeOfString:banceStr].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1] range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:redRange];
    [self.priceL setAttributedText:noteStr];
    self.priceL.adjustsFontSizeToFitWidth = YES;

    
    
    
    
    
    
    
    
    
    
    
    
    
    //self.usernameL.textt = model.username;
//    self.timeL.text = model.commentCreated;
//    self.detailL.text = model.commentDetails;
    
}

@end
