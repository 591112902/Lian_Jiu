


#import <Foundation/Foundation.h>

@interface KuaiDiOrderModel : NSObject


@property(nonatomic)NSInteger type;//请求数据type




@property (nonatomic,copy)NSString *orExpressRecyclePrice;

@property (nonatomic,copy)NSString *orExpressNum;

@property (nonatomic,copy)NSString *orExpressNumCancel;



@property (nonatomic,copy)NSString *orItemsPictruePreview;
@property (nonatomic,copy)NSString *orExpressId;
@property (nonatomic,copy)NSString *orExpressUserId;
@property (nonatomic,copy)NSString *orExpressUserPhone;//
@property (nonatomic,copy)NSString *orExpressEvaluatedPrice;//
@property (nonatomic,copy)NSString *orExpressCreated;
@property (nonatomic,copy)NSString *orExpressUpdated;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *productName;
@property (nonatomic,copy)NSNumber *orExpressStatus;
@property (nonatomic,copy)NSNumber *categoryId;
@property (nonatomic,copy)NSNumber *productNum;




+(instancetype)ModelWith:(NSDictionary *)dic;
@end
