//
//  WaitDoorTableViewCell.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/1.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WaitDoorTableViewCell.h"

@implementation WaitDoorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.modfiyPriceBtn.layer.borderColor = MAINColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillCellWithModel:(WeiXiuOrderModel*)model
{
    self.orRepairCreatedL.text = model.orRepairVisitTime;
    self.orRepairUserPhoneL.text = [NSString stringWithFormat:@"%@ %@",model.orRepairUser,model.orRepairPhone];
    
    
    NSData *nsData=[ model.orRepairScheme dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *orRepairSchemeDic =[NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];

    self.priceL.text = [NSString stringWithFormat:@"¥%@元",orRepairSchemeDic [@"priceAlliance"]];
    
    self.orRepairSchemeL.text = [NSString stringWithFormat:@"%@",orRepairSchemeDic [@"major"]];//,orRepairSchemeDic [@"majorData"]
    
//    if (self.type == 1) {
//        statusList = @"0";
//    }else if (self.type == 2) {
//        statusList = @"1";
//    }else if (self.type == 3) {
//        statusList = @"2,3";
//    }
//statusList=[0]，待维修，statusList=[1]，上门中，statusList=[2,3]，已维修
    if ([model.orRepairStatus isEqualToNumber:@0]) {
        self.orRepairStatusL.text = @"待维修";
        
    }else if ([model.orRepairStatus isEqualToNumber:@1]) {
        self.orRepairStatusL.text = @"上门中";
        self.paymentBtn.hidden = YES;
    }else if ([model.orRepairStatus isEqualToNumber:@2] ) {
        
        self.orRepairStatusL.text = @"已维修";
        self.paymentBtn.hidden = YES;
        
    }else if ([model.orRepairStatus isEqualToNumber:@3]) {
        self.orRepairStatusL.text = @"已取消";
        self.paymentBtn.hidden = YES;
    }
    
    
    
    
    self.orRepairIdL.text = [NSString stringWithFormat:@"订单编号:%@",model.orRepairId];
    
    
    
    
   // NSMutableString *mutString = [[NSMutableString alloc] init];
//    for (NSDictionary *temp in majorArr) {
//        ;
//        [mutString appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"majorData"]]];
//    }
//    self.orItemsParamL.text = mutString;

    
    //self.usernameL.text = model.username;
//    self.timeL.text = model.commentCreated;
//    self.detailL.text = model.commentDetails;
    
}

@end
