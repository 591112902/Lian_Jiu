


#import "ShangMenOrderModel.h"

@implementation ShangMenOrderModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    ShangMenOrderModel *model = [[self alloc] init];
    model.orFacefaceId = dic[@"orFacefaceId"];
    model.userId = dic[@"userId"];
    model.userPhone = dic[@"userPhone"];
    model.username = dic[@"username"];
    model.orFacefaceProvince = dic[@"orFacefaceProvince"];
    model.orFacefaceCity = dic[@"orFacefaceCity"];
    model.orFacefaceDistrict = dic[@"orFacefaceDistrict"];
    model.orFacefaceCreated = dic[@"orFacefaceCreated"];
    model.orFacefaceUpdated = dic[@"orFacefaceUpdated"];
    model.orFacefaceLocation = dic[@"orFacefaceLocation"];
    model.orFacefaceVisittime = dic[@"orFacefaceVisittime"];
    model.orItemsNamePreview = dic[@"orItemsNamePreview"];
    model.orItemsPictruePreview = dic[@"orItemsPictruePreview"];
    model.maxImage = dic[@"maxImage"];
    model.orFfDetailsPrice = dic[@"orFfDetailsPrice"];
    model.orFacefaceStatus = dic[@"orFacefaceStatus"];
    
       
    model.categoryId = dic[@"categoryId"];
    
    
    model.orFfDetailsRetrPrice = dic[@"orFfDetailsRetrPrice"];
    
    return model;
}
@end
