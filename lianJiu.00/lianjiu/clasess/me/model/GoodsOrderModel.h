


#import <Foundation/Foundation.h>

@interface GoodsOrderModel : NSObject


@property(nonatomic)NSInteger type;//请求数据type



@property (nonatomic,copy)NSString *orExceDetailsExpressNum;//快递单号
@property (nonatomic,copy)NSString *ordersId;
@property (nonatomic,copy)NSString *ordersPrice;
@property (nonatomic,copy)NSString *ordersCreated;
@property (nonatomic,copy)NSString *orItemsProductId;
@property (nonatomic,copy)NSString *orItemsNamePreview;//
@property (nonatomic,copy)NSString *orItemsPictruePreview;
@property (nonatomic,copy)NSString *orItemsParam;//
@property (nonatomic,copy)NSNumber *ordersStatus;


+(instancetype)ModelWith:(NSDictionary *)dic;
@end
