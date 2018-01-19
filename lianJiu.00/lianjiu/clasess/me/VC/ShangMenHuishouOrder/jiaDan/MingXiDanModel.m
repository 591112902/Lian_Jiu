


#import "MingXiDanModel.h"

@implementation MingXiDanModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    MingXiDanModel *model = [[self alloc] init];
    model.orItemsId = dic[@"orItemsId"];
    model.orItemsName = dic[@"orItemsName"];
    model.orItemsProductId = dic[@"orItemsProductId"];
    model.orItemsStemFrom = dic[@"orItemsStemFrom"];
    model.orItemsPrice = dic[@"orItemsPrice"];
    model.orItemsNum = dic[@"orItemsNum"];
 
    model.orItemsPriceUnit = dic[@"orItemsPriceUnit"];
    
     model.orItemsRecycleType = dic[@"orItemsRecycleType"];
    
     model.orItemsStatus = dic[@"orItemsStatus"];
    model.unit = dic[@"unit"];
    
    return model;
}
@end
