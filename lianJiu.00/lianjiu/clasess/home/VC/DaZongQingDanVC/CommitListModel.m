

#import "CommitListModel.h"

@implementation CommitListModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    CommitListModel *model = [[self alloc] init];
    
    model.bulkItemId = dic[@"bulkItemId"];
    model.bulkItemName = dic[@"bulkItemName"];
    model.bulkItemProductId = dic[@"bulkItemProductId"];
    model.bulkItemPrice = dic[@"bulkItemPrice"];
    model.bulkItemAccountPrice = dic[@"bulkItemAccountPrice"];
    model.bulkItemNum = dic[@"bulkItemNum"];
    model.bulkItemCreated = dic[@"bulkItemCreated"];
    model.bulkItemUnit = dic[@"bulkItemUnit"];
    model.bulkItemVolume = dic[@"bulkItemVolume"];
    model.bulkItemPriceCurrent = dic[@"bulkItemPriceCurrent"];
    model.bulkItemNumModify = dic[@"bulkItemNumModify"];
    
    return model;
}

@end
