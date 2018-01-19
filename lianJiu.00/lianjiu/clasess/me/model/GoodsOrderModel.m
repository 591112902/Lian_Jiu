


#import "GoodsOrderModel.h"

@implementation GoodsOrderModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    GoodsOrderModel *model = [[self alloc] init];
    model.ordersId = dic[@"ordersId"];
    model.ordersPrice = dic[@"ordersPrice"];
    model.ordersCreated = dic[@"ordersCreated"];
    model.orItemsProductId = dic[@"orItemsProductId"];
    model.orItemsNamePreview = dic[@"orItemsNamePreview"];
    model.orItemsPictruePreview = dic[@"orItemsPictruePreview"];
    model.orItemsParam = dic[@"orItemsParam"];
    model.ordersStatus = dic[@"ordersStatus"];
    model.orExceDetailsExpressNum = dic[@"orExceDetailsExpressNum"];
    
    
    return model;
}
@end
