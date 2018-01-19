//
//  MyOrderTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "KuaiDiOrderTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation KuaiDiOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      // Initialization code
}
-(void)fillCellWithModel:(KuaiDiOrderModel *)model{
    
    
     self.orExpressIdL.text = [NSString stringWithFormat:@"订单编号:%@",model.orExpressId];
     [self.imageIV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"esjpr.png"]];
    
    self.imageIV.contentMode = UIViewContentModeScaleAspectFit;
    
    self.productNameTV.text = model.productName;
    
    
    
    self.orExpressEvaluatedPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressEvaluatedPrice];
    self.productNumLL.text =[NSString stringWithFormat:@"共%@件",model.productNum];
    self.orExpressCreatedL.text = model.orExpressCreated;
    
    
    
//    self.orExpressStatusLL.text ;//待发货Label
//    self.pinggujiaLL.text;//评估价
    
    
    //0代发货 ===  1待验机2结算3取消4全部
    if ([model.orExpressStatus isEqualToNumber:@0]) {
        self.orExpressStatusLL.text = @"待发货";
        self.secondBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.secondBtn.backgroundColor = MAINColor;
        [self.secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else  if([model.orExpressStatus isEqualToNumber:@1]) {
        self.orExpressStatusLL.text = @"待验机";
        self.secondBtn.hidden  = YES;
        self.firstBtn.hidden = YES;
        self.dhL.hidden = YES;
       // self.dhL.text = [NSString stringWithFormat:@"快递单号:%@",model.orExpressNum];
    }else  if([model.orExpressStatus isEqualToNumber:@2]) {
        self.orExpressStatusLL.text = @"结算";
        self.firstBtn.hidden = YES;
        self.secondBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.secondBtn.backgroundColor = MAINColor;
        [self.secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.secondBtn setTitle:@"等待付款" forState:UIControlStateNormal];
        self.leftpingGUL.hidden = NO;
        self.leftPingGPriceL.hidden = NO;
//        self.leftpingGUL.text = @"评估价";
//        self.pinggujiaLL.text = @"回收价";
        
        self.leftPingGPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressRecyclePrice];//orExpressRecyclePrice
        self.orExpressEvaluatedPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressEvaluatedPrice];//orExpressEvaluatedPrice
        
    }else  if([model.orExpressStatus isEqualToNumber:@3]) {
        
        self.orExpressStatusLL.text = @"取消";
        self.firstBtn.hidden = YES;
        if (model.orExpressNumCancel.length>0) {
            self.secondBtn.hidden = YES;
            self.dhL.hidden = NO;
            self.dhL.text = [NSString stringWithFormat:@"快递单号:%@",model.orExpressNumCancel];
        }else{
            self.secondBtn.hidden = NO;
            self.secondBtn.layer.borderColor = MAINColor.CGColor;
            self.secondBtn.layer.borderWidth = 1;
            self.secondBtn.backgroundColor = [UIColor whiteColor];
            [self.secondBtn setTitleColor:MAINColor forState:UIControlStateNormal];
            [self.secondBtn setTitle:@"退货中" forState:UIControlStateNormal];
            
        }
        
        self.leftpingGUL.hidden = NO;
        self.leftPingGPriceL.hidden = NO;
//        self.leftpingGUL.text = @"评估价";
//        self.pinggujiaLL.text = @"回收价";
        
        self.leftPingGPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressRecyclePrice];//orExpressRecyclePrice
        self.orExpressEvaluatedPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressEvaluatedPrice];//orExpressEvaluatedPrice
        
        
        
        
    }else  if([model.orExpressStatus isEqualToNumber:@4]) {
        self.orExpressStatusLL.text = @"取消";
        self.secondBtn.hidden  = YES;
        self.firstBtn.hidden = YES;
        
        
        
    }else  if([model.orExpressStatus isEqualToNumber:@5]) {
        self.orExpressStatusLL.text = @"结算";
        
        self.firstBtn.hidden = YES;
        
        self.secondBtn.layer.borderColor = [UIColor clearColor].CGColor;
        
        self.secondBtn.layer.borderWidth = 1;
        self.secondBtn.backgroundColor = [UIColor lightGrayColor];
        [self.secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.secondBtn setTitle:@"去评论" forState:UIControlStateNormal];
        
        
        self.leftpingGUL.hidden = NO;
        self.leftPingGPriceL.hidden = NO;

        
        self.leftPingGPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressRecyclePrice];//orExpressRecyclePrice
        self.orExpressEvaluatedPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressEvaluatedPrice];//
        
    }else  if([model.orExpressStatus isEqualToNumber:@6]) {
        self.orExpressStatusLL.text = @"结算";
        
        [self.firstBtn setTitle:@"不卖了" forState:UIControlStateNormal];
        self.secondBtn.layer.borderWidth = 1;
        self.secondBtn.layer.borderColor = MAINColor.CGColor;
        self.secondBtn.backgroundColor = [UIColor whiteColor];
        [self.secondBtn setTitleColor:MAINColor forState:UIControlStateNormal];
        [self.secondBtn setTitle:@"确认价格" forState:UIControlStateNormal];
        
        
        
        self.leftpingGUL.hidden = NO;
        self.leftPingGPriceL.hidden = NO;
//        self.leftpingGUL.text = @"评估价";
//        self.pinggujiaLL.text = @"回收价";
        
        self.leftPingGPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressRecyclePrice];//orExpressRecyclePrice
        self.orExpressEvaluatedPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressEvaluatedPrice];//orExpressEvaluatedPrice
        
    }else  if([model.orExpressStatus isEqualToNumber:@7]) {
        self.orExpressStatusLL.text = @"结算";
        
        self.firstBtn.hidden = YES;
        
        self.secondBtn.layer.borderColor = [UIColor clearColor].CGColor;
        
        self.secondBtn.layer.borderWidth = 1;
        self.secondBtn.backgroundColor = [UIColor lightGrayColor];
        [self.secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.secondBtn setTitle:@"已评论" forState:UIControlStateNormal];
        
        
        self.leftpingGUL.hidden = NO;
        self.leftPingGPriceL.hidden = NO;
        
        
        self.leftPingGPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressRecyclePrice];//orExpressRecyclePrice
        self.orExpressEvaluatedPriceL.text = [NSString stringWithFormat:@"%@元",model.orExpressEvaluatedPrice];//
        
    }

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
