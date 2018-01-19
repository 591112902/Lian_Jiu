

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject



@property(nonatomic,copy)NSString *couponId;//
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *endTime;//
@property(nonatomic,copy)NSString *couponTitle;


@property(nonatomic,copy)NSNumber *couponMoney;
@property(nonatomic,copy)NSNumber *couponRatio;




+(instancetype)ModelWith:(NSDictionary *)dic;

@end
