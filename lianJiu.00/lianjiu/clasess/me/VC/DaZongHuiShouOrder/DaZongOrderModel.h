


#import <Foundation/Foundation.h>

@interface DaZongOrderModel : NSObject


@property(nonatomic)NSInteger type;//请求数据type



@property (nonatomic,copy)NSString *orBulkId;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userPhone;//
@property (nonatomic,copy)NSString *userName;//
@property (nonatomic,copy)NSString *ordersPrice;
@property (nonatomic,copy)NSString *ordersRetrPrice;
@property (nonatomic,copy)NSString *orBulkCreated;






@property (nonatomic,copy)NSNumber *orBulkStatus;



+(instancetype)ModelWith:(NSDictionary *)dic;
@end
