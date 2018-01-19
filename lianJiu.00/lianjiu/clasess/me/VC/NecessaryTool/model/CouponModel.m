

#import "CouponModel.h"

@implementation CouponModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    CouponModel *model = [[self alloc] init];
    
    
    model.couponId = dic[@"couponId"];
    model.startTime = dic[@"startTime"];
    model.endTime = dic[@"endTime"];
    model.couponTitle = dic[@"couponTitle"];
    model.couponMoney = dic[@"couponMoney"];
    model.couponRatio = dic[@"couponRatio"];
 
    
    
    
    return model;
}

@end
