


#import <Foundation/Foundation.h>

@interface ShangMenOrderModel : NSObject


@property(nonatomic)NSInteger type;//请求数据type



@property (nonatomic,copy)NSString *orFacefaceId;

@property (nonatomic,copy)NSString *userId;

@property (nonatomic,copy)NSString *userPhone;//

@property (nonatomic,copy)NSString *username;//

@property (nonatomic,copy)NSString *orFacefaceProvince;
@property (nonatomic,copy)NSString *orFacefaceCity;
@property (nonatomic,copy)NSString *orFacefaceDistrict;
@property (nonatomic,copy)NSString *orFacefaceCreated;
@property (nonatomic,copy)NSString *orFacefaceUpdated;
@property (nonatomic,copy)NSString *orFacefaceLocation;
@property (nonatomic,copy)NSString *orFacefaceVisittime;
@property (nonatomic,copy)NSString *orItemsNamePreview;
@property (nonatomic,copy)NSString *orItemsPictruePreview;
@property (nonatomic,copy)NSString *maxImage;
@property (nonatomic,copy)NSString *orFfDetailsPrice;
@property (nonatomic,copy)NSString *orFfDetailsRetrPrice;





@property (nonatomic,copy)NSNumber *orFacefaceStatus;
@property (nonatomic,copy)NSNumber *categoryId;


+(instancetype)ModelWith:(NSDictionary *)dic;
@end
