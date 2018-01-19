

#import <Foundation/Foundation.h>

@interface commentModel : NSObject



@property (nonatomic,strong) NSNumber *commentEmoji;

@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *commentLabelPrice;
@property (nonatomic,copy)NSString *commentLabelRemit;
@property (nonatomic,copy)NSString *commentLabelService;
@property (nonatomic,copy)NSString *commentUpdated;
@property (nonatomic,copy)NSString *commentDetails;



+(instancetype)ModelWith:(NSDictionary *)dic;




@end
