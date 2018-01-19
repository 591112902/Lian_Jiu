

#import "ScrapDetailModel.h"

@implementation ScrapDetailModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    ScrapDetailModel *model = [[self alloc] init];
   

    
    model.wPriceId = dic[@"wPriceId"];
    model.wPriceSingle = dic[@"wPriceSingle"];
    
    model.name = dic[@"name"];
    
     model.wPriceUnit = dic[@"wPriceUnit"];
    
     model.wasteImage = dic[@"wasteImage"];
    
//    model.size = dic[@"size"];
//    model.t_attestation = dic[@"t_attestation"];
//    model.t_austate_id = dic[@"t_austate_id"];
//    model.t_bidstate_id = dic[@"t_bidstate_id"];
//    model.t_date = dic[@"t_date"];
//    model.t_detail = dic[@"t_detail"];
//    model.t_id = dic[@"t_id"];
//    model.t_phone = dic[@"t_phone"];
//    model.t_picktime = dic[@"t_picktime"];
//    model.t_price = dic[@"t_price"];
//    model.t_quality = dic[@"t_quality"];

    
    return model;
}
@end
