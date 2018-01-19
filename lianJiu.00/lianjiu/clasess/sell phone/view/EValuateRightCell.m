//
//  CommentTableViewCell.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/8/31.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "EValuateRightCell.h"

@implementation EValuateRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cLabel1.layer.borderColor = MAINColor.CGColor;
    self.cLabel2.layer.borderColor = MAINColor.CGColor;
    self.cLabel3.layer.borderColor = MAINColor.CGColor;
    
}


-(void)fillCellWithModel:(commentModel*)model{
   // self.userL.text = model.username;
    
    NSString *orItemsUserS = model.username;
    if (orItemsUserS.length>9) {
        
        NSString *tel = [orItemsUserS stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.userL.text = [NSString stringWithFormat:@"%@",tel];
    }else{
        
        self.userL.text =  [NSString stringWithFormat:@"%@",orItemsUserS];
        
    }

    
    
    
    if (model.commentLabelPrice.length>0 && model.commentLabelRemit.length>0&& model.commentLabelService.length>0 ) {
        self.cLabel1.hidden = NO;self.cLabel2.hidden = NO;self.cLabel3.hidden = NO;
        self.cLabel1.text = model.commentLabelPrice;//价格高
        self.cLabel2.text = model.commentLabelRemit;//速度慢
        self.cLabel3.text = model.commentLabelService;//极贴心
    }else  if (model.commentLabelPrice.length==0 && model.commentLabelRemit.length>0&& model.commentLabelService.length>0 ) {
       
        self.cLabel1.hidden = NO;self.cLabel2.hidden = NO;self.cLabel3.hidden = YES;
      //  self.cLabel1.text = model.commentLabelPrice;//价格高
        self.cLabel1.text = model.commentLabelRemit;//速度慢
        self.cLabel2.text = model.commentLabelService;//极贴心
    }else  if (model.commentLabelPrice.length>0 && model.commentLabelRemit.length==0&& model.commentLabelService.length>0 ) {
        self.cLabel1.hidden = NO;self.cLabel2.hidden = NO;self.cLabel3.hidden = YES;
        self.cLabel1.text = model.commentLabelPrice;//价格高
       // self.cLabel2.text = model.commentLabelRemit;//速度慢
        self.cLabel2.text = model.commentLabelService;//极贴心
    }else  if (model.commentLabelPrice.length>0 && model.commentLabelRemit.length>0&& model.commentLabelService.length==0 ) {
        self.cLabel1.hidden = NO;self.cLabel2.hidden = NO;self.cLabel3.hidden = YES;
        self.cLabel1.text = model.commentLabelPrice;//价格高
        self.cLabel2.text = model.commentLabelRemit;//速度慢
       // self.cLabel3.text = model.commentLabelService;//极贴心
        
    }else  if (model.commentLabelPrice.length>0 && model.commentLabelRemit.length==0&& model.commentLabelService.length==0 ) {
        self.cLabel1.hidden = NO; self.cLabel2.hidden = YES;
        self.cLabel3.hidden = YES;
        self.cLabel1.text = model.commentLabelPrice;//价格高
        //self.cLabel2.text = model.commentLabelRemit;//速度慢
       // self.cLabel3.text = model.commentLabelService;//极贴心
    }else  if (model.commentLabelPrice.length==0 && model.commentLabelRemit.length>0&& model.commentLabelService.length==0 ) {
        self.cLabel1.hidden = NO;self.cLabel2.hidden = YES;
        self.cLabel3.hidden = YES;
        //self.cLabel1.text = model.commentLabelPrice;//价格高
        self.cLabel1.text = model.commentLabelRemit;//速度慢
        //self.cLabel3.text = model.commentLabelService;//极贴心
    }else  if (model.commentLabelPrice.length==0 && model.commentLabelRemit.length==0&& model.commentLabelService.length>0 ) {
        self.cLabel1.hidden = NO;self.cLabel2.hidden = YES;
        self.cLabel3.hidden = YES;
        //self.cLabel1.text = model.commentLabelPrice;//价格高
        //self.cLabel1.text = model.commentLabelRemit;//速度慢
        self.cLabel1.text = model.commentLabelService;//极贴心
    }else  if (model.commentLabelPrice.length==0 && model.commentLabelRemit.length==0&& model.commentLabelService.length==0 ) {
        self.cLabel2.hidden = YES;
        self.cLabel3.hidden = YES;
        self.cLabel1.hidden = YES;
    }





    
    
    
    
    
    
   
    
    self.timeL.text = model.commentUpdated;
    self.contentL.text = model.commentDetails;
   
    
    if ([model.commentEmoji isEqualToNumber:@30]) {
        //
        self.cImageView.image = [UIImage imageNamed:@"30_s"];
    }else if ([model.commentEmoji isEqualToNumber:@60]){
        self.cImageView.image = [UIImage imageNamed:@"60_s"];
    }else if ([model.commentEmoji isEqualToNumber:@90]){
        self.cImageView.image = [UIImage imageNamed:@"90_s"];
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
