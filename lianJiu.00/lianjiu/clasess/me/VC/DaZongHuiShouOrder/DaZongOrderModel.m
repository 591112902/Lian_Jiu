


#import "DaZongOrderModel.h"

@implementation DaZongOrderModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    DaZongOrderModel *model = [[self alloc] init];
    model.orBulkId = dic[@"orBulkId"];
    model.userId = dic[@"userId"];
    model.userPhone = dic[@"userPhone"];
    model.userName = dic[@"userName"];
    model.ordersPrice = dic[@"ordersPrice"];
    model.ordersRetrPrice = dic[@"ordersRetrPrice"];
    model.orBulkCreated = dic[@"orBulkCreated"];
    model.orBulkStatus = dic[@"orBulkStatus"];
    
    
    
    return model;
}
@end
