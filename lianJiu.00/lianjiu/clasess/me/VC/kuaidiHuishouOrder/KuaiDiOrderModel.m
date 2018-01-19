


#import "KuaiDiOrderModel.h"

@implementation KuaiDiOrderModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    KuaiDiOrderModel *model = [[self alloc] init];
    model.orExpressId = dic[@"orExpressId"];
    model.orExpressUserId = dic[@"orExpressUserId"];
    model.orExpressUserPhone = dic[@"orExpressUserPhone"];
    model.orExpressEvaluatedPrice = dic[@"orExpressEvaluatedPrice"];
    model.orExpressCreated = dic[@"orExpressCreated"];
    model.orExpressUpdated = dic[@"orExpressUpdated"];
    model.image = dic[@"image"];
    model.productName = dic[@"productName"];
    model.orExpressStatus = dic[@"orExpressStatus"];
    model.categoryId = dic[@"categoryId"];
    model.productNum = dic[@"productNum"];
    model.orItemsPictruePreview = dic[@"orItemsPictruePreview"];
    model.orExpressNum = dic[@"orExpressNum"];
    
    model.orExpressRecyclePrice = dic[@"orExpressRecyclePrice"];
    
     model.orExpressNumCancel = dic[@"orExpressNumCancel"];
    return model;
}
@end
