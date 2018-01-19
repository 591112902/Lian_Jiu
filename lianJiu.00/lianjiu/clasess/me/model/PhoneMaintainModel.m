


#import "PhoneMaintainModel.h"

@implementation PhoneMaintainModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    PhoneMaintainModel *model = [[self alloc] init];
    model.categoryId = dic[@"categoryId"];
    model.categoryName = dic[@"categoryName"];
    model.categoryImage = dic[@"categoryImage"];
  
    
    return model;
}
@end
