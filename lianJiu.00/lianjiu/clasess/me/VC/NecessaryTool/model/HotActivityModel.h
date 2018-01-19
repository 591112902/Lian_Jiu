

#import <Foundation/Foundation.h>

@interface HotActivityModel : NSObject



@property(nonatomic,copy)NSString *actId;//
@property(nonatomic,copy)NSString *actTitle;
@property(nonatomic,copy)NSString *actContent;//
@property(nonatomic,copy)NSString *actStartTime;
@property(nonatomic,copy)NSString *actEndTime;
@property(nonatomic,copy)NSString *actPicture;
@property(nonatomic,copy)NSString *actPicLink;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *addPerson;
@property(nonatomic,copy)NSString *categoryId;



+(instancetype)ModelWith:(NSDictionary *)dic;

@end
