

#import "JinQiJiaModel.h"

@implementation JinQiJiaModel

+(instancetype)ModelWith:(NSDictionary *)dic
{
    JinQiJiaModel *model = [[self alloc] init];
    model.orItemsCreated = dic[@"orItemsCreated"];
    model.orItemsId = dic[@"orItemsId"];
    model.orItemsName = dic[@"orItemsName"];
    model.orItemsNum = dic[@"orItemsNum"];
    model.orItemsParam = dic[@"orItemsParam"];
    //model.username = dic[@"username"];
    model.orItemsPicture = dic[@"orItemsPicture"];
    model.orItemsPrice = dic[@"orItemsPrice"];
    model.orItemsProductId = dic[@"orItemsProductId"];
    
    model.orItemsRecycleType = dic[@"orItemsRecycleType"];
    model.ordersId = dic[@"ordersId"];
    model.orItemsStatus = dic[@"orItemsStatus"];
    
    model.orItemsUser = dic[@"orItemsUser"];
    
    model.orItemsAccountPrice = dic[@"orItemsAccountPrice"];
 
    return model;
}




@end
