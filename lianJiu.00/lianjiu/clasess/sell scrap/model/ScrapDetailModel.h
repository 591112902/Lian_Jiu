#import <Foundation/Foundation.h>

@interface ScrapDetailModel : NSObject


//pass_time + t_date -当前时间
//countBid

@property(nonatomic,copy)NSString *wPriceId;
@property(nonatomic,copy)NSString *wPriceSingle;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *wPriceUnit;
@property(nonatomic,copy)NSString *wasteImage;

//@property(nonatomic,copy)NSString *usr_status;
//@property(nonatomic,copy)NSArray *priJsonList;//主图详情描述数组
//@property(nonatomic,copy)NSArray *detJsonList;//详情图描述数组
//@property(nonatomic,copy)NSString *zbBail;
//@property(nonatomic,copy)NSString *tbBail;
//@property(nonatomic,copy)NSString *dealTime;
//@property(nonatomic,copy)NSString *a_bail;
//@property(nonatomic,copy)NSString *a_fb_bail;
//@property(nonatomic,copy)NSString *w_date;
////@property(nonatomic,copy)NSString *cj_price;
//@property(nonatomic,copy)NSString *final_price;
//@property(nonatomic,copy)NSNumber *cj_price;
//@property(nonatomic,copy)NSNumber *countBid;
//@property(nonatomic,copy)NSString *pass_time;
//@property(nonatomic,copy)NSString *size;
//@property(nonatomic,copy)NSString *t_attestation;
//@property(nonatomic,copy)NSString *t_austate_id;
//@property(nonatomic,copy)NSString *t_bidstate_id;
//@property(nonatomic,copy)NSString *finish_state;
//@property(nonatomic,copy)NSString *cj_type;
//@property(nonatomic,copy)NSString *t_date;
//@property(nonatomic,copy)NSString *t_detail;
//@property(nonatomic,copy)NSString *t_id;
//@property(nonatomic,copy)NSString *t_phone;
//@property(nonatomic,copy)NSString *t_picktime;
//@property(nonatomic,copy)NSString *t_price;
//@property(nonatomic,copy)NSString *t_quality;
//@property(nonatomic,copy)NSString *t_reason;
//@property(nonatomic,copy)NSString *t_tendertype;



+(instancetype)ModelWith:(NSDictionary *)dic;
@end
