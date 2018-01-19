


#import <Foundation/Foundation.h>

@interface PhoneMaintainModel : NSObject





@property (nonatomic,copy)NSNumber *categoryId;

@property (nonatomic,copy)NSString *categoryName;

@property (nonatomic,copy)NSString *categoryImage;//时间

//@property (nonatomic,copy)NSString *orItemsParam;//内容
//
//@property (nonatomic,copy)NSString *orItemsPrice;



+(instancetype)ModelWith:(NSDictionary *)dic;
@end
