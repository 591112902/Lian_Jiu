


#import "WeiXiuOrderModel.h"

@implementation WeiXiuOrderModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    WeiXiuOrderModel *model = [[self alloc] init];
    model.orRepairId = dic[@"orRepairId"];
    model.userId = dic[@"userId"];
    model.orRepairVisitTime = dic[@"orRepairVisitTime"];
    
    
    
    model.orRepairUser = dic[@"orRepairUser"];
    model.orRepairPhone = dic[@"orRepairPhone"];
    model.orRepairProvince = dic[@"orRepairProvince"];
    model.orRepairCity = dic[@"orRepairCity"];
    model.orRepairDistrict = dic[@"orRepairDistrict"];
    model.orRepairLocation = dic[@"orRepairLocation"];
    model.orRepairCreated = dic[@"orRepairCreated"];
    model.orRepairHandleTime = dic[@"orRepairHandleTime"];
    
    model.orRepairScheme = dic[@"orRepairScheme"];
    
    model.categoryId = dic[@"categoryId"];
    
    model.orRepairStatus = dic[@"orRepairStatus"];
  
    
    return model;
}
@end
