//
//  MyOrderTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "GoodsOrderTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation GoodsOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      // Initialization code
}
-(void)fillCellWithModel:(GoodsOrderModel *)model{
     self.orItemsNameL.text = model.orItemsNamePreview;
    [self.orItemsPictureIV sd_setImageWithURL:[NSURL URLWithString:model.orItemsPictruePreview] placeholderImage:[UIImage imageNamed:@"esjpr.png"]];
    
    
    self.orItemsPictureIV.contentMode = UIViewContentModeScaleAspectFit;
    
//    NSData *nsData=[ model.orItemsParam dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *majorArr =[NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
//    NSMutableString *mutString = [[NSMutableString alloc] init];
//    for (NSDictionary *temp in majorArr) {
//        ;
//        [mutString appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"majorData"]]];
//    }
    self.orItemsParamL.text = model.orItemsParam;
    self.orItemsCreatedL.text = model.ordersCreated;
    self.orItemsPriceL.text = [NSString stringWithFormat:@"合计:%@元",model.ordersPrice];
    
    
    if ([model.ordersStatus isEqualToNumber:@1]) {
        self.stateL.text = @"待付款";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = NO;
        self.threeBtn.backgroundColor = MAINColor;
        [self.threeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.threeBtn.layer.borderColor = MAINColor.CGColor;
        [self.threeBtn setTitle:@"付款" forState:UIControlStateNormal];
        
        
    }else if ([model.ordersStatus isEqualToNumber:@2]){
         self.stateL.text = @"买家已付款";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = NO;
        self.threeBtn.layer.borderColor = MAINColor.CGColor;
        [self.threeBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
    }else if ([model.ordersStatus isEqualToNumber:@3]){
        self.stateL.text = @"待收货";
        self.firstBtn.hidden = NO;
        self.secondBtn.hidden = NO;
        self.threeBtn.hidden = NO;
        
        self.firstBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.secondBtn.layer.borderColor = BGColor.CGColor;
        self.threeBtn.layer.borderColor = MAINColor.CGColor;
      
        
    }else if ([model.ordersStatus isEqualToNumber:@4]){
        self.stateL.text = @"买家已付款";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = YES;
        
//        self.threeBtn.backgroundColor = [UIColor darkGrayColor];
//        [self.threeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//         [self.threeBtn setTitle:@"去评论" forState:UIControlStateNormal];
    }else if ([model.ordersStatus isEqualToNumber:@5]){//仅退款==退货退款==退货退款后发货===已取消
        self.stateL.text = @"待退款";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = YES;
        
        
//        self.threeBtn.layer.borderColor = [UIColor clearColor].CGColor;
//        [self.threeBtn setTitle:@"仅退款" forState:UIControlStateNormal];
    }else if ([model.ordersStatus isEqualToNumber:@6]){//仅退款==退货退款==退货退款后发货===已取消
        self.stateL.text = @"待退款";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = NO;
        
        
        self.threeBtn.layer.borderColor = MAINColor.CGColor;
        [self.threeBtn setTitle:@"退货快递" forState:UIControlStateNormal];
    }else if ([model.ordersStatus isEqualToNumber:@7]){
        self.stateL.text = @"成功交易";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = NO;
        
        self.threeBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.threeBtn.backgroundColor = [UIColor lightGrayColor];
        [self.threeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.threeBtn setTitle:@"去评论" forState:UIControlStateNormal];
    }else if ([model.ordersStatus isEqualToNumber:@8]){
        self.stateL.text = @"成功交易";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = NO;
        
        self.threeBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.threeBtn.backgroundColor = [UIColor lightGrayColor];
        [self.threeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.threeBtn setTitle:@"已评论" forState:UIControlStateNormal];
    }else if ([model.ordersStatus isEqualToNumber:@9]){//退货单号出来
        self.stateL.text = @"已退款";//
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = YES;
        
//        if (model./) {
//            <#statements#>
//        }
        
        self.kuaidiDanHaoL.hidden = NO;
        if (model.orExceDetailsExpressNum.length>0) {
              self.kuaidiDanHaoL.text = [NSString stringWithFormat:@"退货单号:%@",model.orExceDetailsExpressNum];
        }else{
             self.kuaidiDanHaoL.text = @"";
        }
        
      
        
//        self.threeBtn.layer.borderColor = [UIColor clearColor].CGColor;
//        [self.threeBtn setTitle:@"填单号" forState:UIControlStateNormal];
    }else if ([model.ordersStatus isEqualToNumber:@0]){//仅退款==退货退款==退货退款后发货===已取消
        self.stateL.text = @"已取消";
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.threeBtn.hidden = NO;
        
        
        self.threeBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.threeBtn.backgroundColor = [UIColor darkGrayColor];
        [self.threeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.threeBtn setTitle:@"已取消" forState:UIControlStateNormal];
        
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
