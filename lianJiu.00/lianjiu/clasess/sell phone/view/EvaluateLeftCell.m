//
//  EvaluateLeftCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/12.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "EvaluateLeftCell.h"
#import "UIImageView+WebCache.h"
@implementation EvaluateLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.zjbgBtn.layer.cornerRadius = 4;
    self.zjbgBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.zjbgBtn.layer.borderWidth = 0.5;
    [self.zjbgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellWithModel:(JinQiJiaModel*)model{
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.orItemsPicture]];
    self.nameL.text = model.orItemsName?model.orItemsName:@"";
   // self.userL.text = model.orItemsUser?model.orItemsUser:@"";
    
    
    
    if (model.orItemsUser.length>9) {
        
        NSString *tel = [model.orItemsUser stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.userL.text = [NSString stringWithFormat:@"%@",tel];
    }else{
        
        self.userL.text =  [NSString stringWithFormat:@"%@",model.orItemsUser];
        
    }

    
    
    
    
    
    
   
    
    
    self.priceL.text =  [NSString stringWithFormat:@"%@元",model.orItemsAccountPrice?model.orItemsAccountPrice:@""];
    
    self.hiuhsouTypeL.text = model.hsfs;
    
    
    if (model.orItemsCreated.length>10) {
         self.timeL.text = [model.orItemsCreated substringToIndex:10]?[model.orItemsCreated substringToIndex:10]:@"";
    }else{
        self.timeL.text = model.orItemsCreated?model.orItemsCreated:@"";
    }
    
   
    
}

@end
