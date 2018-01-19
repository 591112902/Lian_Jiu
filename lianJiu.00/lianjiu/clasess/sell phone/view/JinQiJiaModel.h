

#import <Foundation/Foundation.h>

@interface JinQiJiaModel : NSObject

@property (nonatomic,strong) NSString *hsfs;

@property (nonatomic,strong) NSString *orItemsCreated;
@property (nonatomic,copy)NSString *orItemsId;
@property (nonatomic,copy)NSString *orItemsName;
@property (nonatomic,copy)NSString *orItemsNum;

@property (nonatomic,copy)NSString *orItemsParam;
@property (nonatomic,copy)NSString *orItemsPicture;
@property (nonatomic,copy)NSString *orItemsPrice;
@property (nonatomic,copy)NSString *orItemsProductId;
@property (nonatomic,copy)NSString *orItemsRecycleType;
@property (nonatomic,copy)NSString *orItemsUser;
@property (nonatomic,copy)NSString *ordersId;
@property (nonatomic,copy)NSNumber *orItemsStatus;


@property (nonatomic,copy)NSString *orItemsAccountPrice;

+(instancetype)ModelWith:(NSDictionary *)dic;




@end
