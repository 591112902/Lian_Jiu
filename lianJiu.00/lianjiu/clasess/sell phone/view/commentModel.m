

#import "commentModel.h"

@implementation commentModel

+(instancetype)ModelWith:(NSDictionary *)dic
{
    commentModel *model = [[self alloc] init];
    model.commentEmoji = dic[@"commentEmoji"];
    
    model.username = dic[@"username"];
    //model.username = dic[@"username"];
    model.commentLabelPrice = dic[@"commentLabelPrice"];
    model.commentLabelRemit = dic[@"commentLabelRemit"];
    model.commentLabelService = dic[@"commentLabelService"];
    
    model.commentUpdated = dic[@"commentUpdated"];
    
    
    model.commentDetails = dic[@"commentDetails"];
    
    return model;
}




@end
