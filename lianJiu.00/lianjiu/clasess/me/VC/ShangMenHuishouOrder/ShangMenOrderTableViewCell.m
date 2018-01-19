//
//  MyOrderTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ShangMenOrderTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ShangMenOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      // Initialization code
}
-(void)fillCellWithModel:(ShangMenOrderModel *)model{
    
    self.orFacefaceIdL.text = [NSString stringWithFormat:@"订单编号:%@",model.orFacefaceId];
   [self.maxImageIV sd_setImageWithURL:[NSURL URLWithString:model.maxImage]];
    
    self.usernamePhoneLL.text = [NSString stringWithFormat:@"上门师傅:%@ %@",model.username,model.userPhone];
    
  
    
    self.orFfDetailsPriceL.text = [NSString stringWithFormat:@"预估总价:%@元",model.orFfDetailsPrice];
    
    
    
    self.orFfDetailsRetrPrice.text = [NSString stringWithFormat:@"回收总价:%@元",model.orFfDetailsRetrPrice];
    self.orFacefaceUpdatedLL.text = model.orFacefaceVisittime;
    
   // orFacefaceStatus
    
     if ([model.orFacefaceStatus isEqualToNumber:@1]) {
         self.orFacefaceStatusLL.text = @"派单中";
         self.secondBtn.hidden = YES;
     }else if ([model.orFacefaceStatus isEqualToNumber:@2]||[model.orFacefaceStatus isEqualToNumber:@4]) {
         
         self.orFacefaceStatusLL.text = @"上门中";
         self.secondBtn.hidden = NO;
         [self.secondBtn setTitle:@"加单" forState:UIControlStateNormal];
         
         
         
         
     }else if ([model.orFacefaceStatus isEqualToNumber:@5]||[model.orFacefaceStatus isEqualToNumber:@7]) {
         
         self.orFacefaceStatusLL.text = @"上门中";
         self.firstBtn.hidden = NO;
         self.secondBtn.hidden = NO;
         [self.secondBtn setTitle:@"确认价格" forState:UIControlStateNormal];
         
         
         
         
         
     }else if ([model.orFacefaceStatus isEqualToNumber:@6]||[model.orFacefaceStatus isEqualToNumber:@8]) {
         
         self.orFacefaceStatusLL.text = @"上门中";
         self.firstBtn.hidden = YES;
         
         //上门中-当订单状态为6和8的时候，需要出现等待付款按钮和显示出“回收总价”的内容
         self.orFfDetailsRetrPrice.hidden = NO;
         self.secondBtn.hidden = NO;
         [self.secondBtn setTitle:@"等待付款" forState:UIControlStateNormal];
         
     }else if ([model.orFacefaceStatus isEqualToNumber:@3]) {
         self.orFacefaceStatusLL.text = @"交易成功";
         self.orFfDetailsRetrPrice.hidden = NO;
         
         
         [self.secondBtn setTitle:@"去评论" forState:UIControlStateNormal];
     }else if ([model.orFacefaceStatus isEqualToNumber:@0]) {
         self.orFacefaceStatusLL.text = @"取消";
         self.orFfDetailsRetrPrice.hidden = NO;
         self.firstBtn.hidden = YES;
         self.secondBtn.hidden = YES;
         
        
     }else if ([model.orFacefaceStatus isEqualToNumber:@9]) {
         self.orFacefaceStatusLL.text = @"交易成功";
         self.orFfDetailsRetrPrice.hidden = YES;
        // self.firstBtn.hidden = YES;
         self.secondBtn.hidden = NO;
         
          [self.secondBtn setTitle:@"已评论" forState:UIControlStateNormal];
     }

    
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
