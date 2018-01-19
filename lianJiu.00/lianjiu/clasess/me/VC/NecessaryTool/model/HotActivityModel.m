

#import "HotActivityModel.h"

@implementation HotActivityModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    HotActivityModel *model = [[self alloc] init];
    
    
    model.actId = dic[@"actId"];
    model.actTitle = dic[@"actTitle"];
    model.actContent = dic[@"actContent"];
    model.actStartTime = dic[@"actStartTime"];
    model.actEndTime = dic[@"actEndTime"];
    model.actPicture = dic[@"actPicture"];
    model.actPicLink = dic[@"actPicLink"];
    model.addTime = dic[@"addTime"];
    model.addPerson = dic[@"addPerson"];
    model.categoryId = dic[@"categoryId"];
 
    
    
    return model;
}

@end
