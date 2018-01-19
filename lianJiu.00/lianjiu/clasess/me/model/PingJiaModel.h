


#import <Foundation/Foundation.h>

@interface PingJiaModel : NSObject

@property (nonatomic,copy)NSString *commentId;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,strong)NSString *username;
//@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *relativeId;
@property (nonatomic,copy)NSString *commentLabelPrice;
@property (nonatomic,copy)NSString *commentDetails;
@property (nonatomic,copy)NSString *commentCreated;

+(instancetype)ModelWith:(NSDictionary *)dic;
@end
