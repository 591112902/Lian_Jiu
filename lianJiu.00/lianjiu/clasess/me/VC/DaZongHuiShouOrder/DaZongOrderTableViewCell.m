//
//  MyOrderTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "DaZongOrderTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DaZongOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      // Initialization code
}
-(void)fillCellWithModel:(DaZongOrderModel *)model{
    
    self.orFacefaceIdL.text = [NSString stringWithFormat:@"订单编号:%@",model.orBulkId];
  // [self.maxImageIV sd_setImageWithURL:[NSURL URLWithString:model.maxImage]];
//    
//    self.usernamePhoneLL.text = [NSString stringWithFormat:@"上门师傅:%@ %@",model.username,model.userPhone];
//    
//  
//    

    self.orFfDetailsPriceL.text = [NSString stringWithFormat:@"清单总价:%@元",model.ordersPrice];
    
    
    
    self.orFfDetailsRetrPrice.text = [NSString stringWithFormat:@"交货总价:%@元",model.ordersRetrPrice];
    self.orFacefaceUpdatedLL.text = model.orBulkCreated;
    
   // orFacefaceStatus
    
     if ([model.orBulkStatus isEqualToNumber:@1]) {//取消1
          self.left_cancelBtn.hidden = YES;
         self.orFacefaceStatusLL.text = @"待验货";
         self.firstBtn.hidden = YES;
         self.secondBtn.hidden = NO;
         [self.secondBtn setTitle:@"取消" forState:UIControlStateNormal];
     }else if ([model.orBulkStatus isEqualToNumber:@2]) {//2
         
         self.orFacefaceStatusLL.text = @"待确认";
         self.firstBtn.hidden = NO;
         self.secondBtn.hidden = NO;
         self.left_cancelBtn.hidden = NO;
          [self.left_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
         [self.secondBtn setTitle:@"确认价格" forState:UIControlStateNormal];
         [self.firstBtn setTitle:@"交货清单" forState:UIControlStateNormal];
         [self.firstBtn setTitleColor:MAINColor forState:0];
         self.firstBtn.layer.cornerRadius = 3;
         self.firstBtn.layer.borderWidth = 1;
         self.firstBtn.layer.borderColor = MAINColor.CGColor;
         
         
         
         
     }else if ([model.orBulkStatus isEqualToNumber:@3]) {
         
         self.orFacefaceStatusLL.text = @"已发货";
         self.firstBtn.hidden = NO;
         self.secondBtn.hidden = NO;
          self.left_cancelBtn.hidden = YES;
         [self.secondBtn setTitle:@"去评论" forState:UIControlStateNormal];
         [self.firstBtn setTitle:@"交货清单" forState:UIControlStateNormal];
         [self.firstBtn setTitleColor:MAINColor forState:0];
         self.firstBtn.layer.cornerRadius = 3;
         self.firstBtn.layer.borderWidth = 1;
         self.firstBtn.layer.borderColor = MAINColor.CGColor;



     }else if ([model.orBulkStatus isEqualToNumber:@4]) {
          self.left_cancelBtn.hidden = YES;
         self.orFacefaceStatusLL.text = @"已评论";
         self.firstBtn.hidden = NO;
         self.secondBtn.hidden = NO;
         [self.secondBtn setTitle:@"已评论" forState:UIControlStateNormal];
         self.secondBtn.backgroundColor = [UIColor lightGrayColor];
         [self.firstBtn setTitle:@"交货清单" forState:UIControlStateNormal];
         [self.firstBtn setTitleColor:MAINColor forState:0];
         self.firstBtn.layer.cornerRadius = 3;
         self.firstBtn.layer.borderWidth = 1;
         self.firstBtn.layer.borderColor = MAINColor.CGColor;
     }else if ([model.orBulkStatus isEqualToNumber:@0]) {
         self.orFacefaceStatusLL.text = @"取消";
         self.left_cancelBtn.hidden = YES;
         self.firstBtn.hidden = YES;
         self.secondBtn.hidden = YES;
     }
    
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
