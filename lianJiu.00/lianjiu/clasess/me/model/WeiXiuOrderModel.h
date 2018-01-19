


#import <Foundation/Foundation.h>

@interface WeiXiuOrderModel : NSObject

@property (nonatomic,copy)NSString *orRepairId;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *orRepairVisitTime;
@property (nonatomic,copy)NSString *orRepairScheme;


@property (nonatomic,copy)NSString *orRepairUser;
@property (nonatomic,copy)NSString *orRepairPhone;
@property (nonatomic,copy)NSString *orRepairProvince;
@property (nonatomic,copy)NSString *orRepairCity;
@property (nonatomic,copy)NSString *orRepairDistrict;
@property (nonatomic,copy)NSString *orRepairLocation;
@property (nonatomic,copy)NSString *orRepairCreated;
@property (nonatomic,copy)NSString *orRepairHandleTime;








@property (nonatomic,copy)NSNumber *categoryId;
@property (nonatomic,copy)NSNumber *orRepairStatus;



//@property (nonatomic,copy)NSString *orItemsParam;//内容
//
//@property (nonatomic,copy)NSString *orItemsPrice;



+(instancetype)ModelWith:(NSDictionary *)dic;
@end
