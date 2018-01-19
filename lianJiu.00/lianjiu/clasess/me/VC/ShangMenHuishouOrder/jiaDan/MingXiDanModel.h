


#import <Foundation/Foundation.h>

@interface MingXiDanModel : NSObject

@property (nonatomic,copy)NSString *cxpgPrice;

@property (nonatomic,copy)NSString *orItemsRecycleType;

@property (nonatomic,copy)NSString *orItemsId;
@property (nonatomic,copy)NSString *orItemsName;
@property (nonatomic,copy)NSString *orItemsProductId;
@property (nonatomic,copy)NSNumber*orItemsStemFrom;
@property (nonatomic,copy)NSString *orItemsPrice;
@property (nonatomic,copy)NSString *orItemsNum;

@property (nonatomic,copy)NSNumber *orItemsPriceUnit;


@property (nonatomic,copy)NSNumber *orItemsStatus;



@property (nonatomic,copy)NSNumber *unit;
+(instancetype)ModelWith:(NSDictionary *)dic;
@end
