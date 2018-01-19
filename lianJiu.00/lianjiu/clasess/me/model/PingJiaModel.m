


#import "PingJiaModel.h"

@implementation PingJiaModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    PingJiaModel *model = [[self alloc] init];
    model.commentId = dic[@"commentId"];
    model.userId = dic[@"userId"];
    model.username = dic[@"username"];
    model.relativeId = dic[@"relativeId"];
    model.commentLabelPrice = dic[@"commentLabelPrice"];
    model.commentDetails = dic[@"commentDetails"];
    
    model.commentCreated = dic[@"commentCreated"];
    
    return model;
}
@end
