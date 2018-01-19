

#import "ProductModel.h"

@implementation ProductModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    ProductModel *model = [[self alloc] init];
    
    
    model.productName = dic[@"productName"];
    model.productPrice = dic[@"productPrice"];
    model.productPriceAlliance = dic[@"productPriceAlliance"];
    model.productMasterPicture = dic[@"productMasterPicture"];
    model.productId = dic[@"productId"];
    
    model.categoryId = dic[@"categoryId"];
    model.productCreated = dic[@"productCreated"];
    model.productParamData = dic[@"productParamData"];
    model.productRetriType = dic[@"productRetriType"];
    model.productStatus = dic[@"productStatus"];
    model.productSubPicture = dic[@"productSubPicture"];
    model.productVolume = dic[@"productVolume"];
    model.productUpdated = dic[@"productUpdated"];
//    model.n_time = dic[@"n_time"];
//    model.n_title = dic[@"n_title"];
//    model.n_type = dic[@"n_type"];
//    model.start_date = dic[@"start_date"];
    
    return model;
}

@end
