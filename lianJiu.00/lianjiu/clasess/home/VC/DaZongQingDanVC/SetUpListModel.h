

#import <Foundation/Foundation.h>

@interface SetUpListModel : NSObject

@property(nonatomic,copy)NSString *bulkId;//
@property(nonatomic,copy)NSString *bulkName;
@property(nonatomic,copy)NSString *bulkVolume;//
@property(nonatomic,copy)NSString *bulkNum;
@property(nonatomic,copy)NSString *priceSingle;
@property(nonatomic,copy)NSNumber *categoryId;
@property(nonatomic,copy)NSNumber *priceUnit;

//@property(nonatomic,copy)NSString *e_img2;//会展详情图
//@property(nonatomic,copy)NSString *e_industry;//所属行业
//@property(nonatomic,copy)NSString *e_mobile;//手机
//@property(nonatomic,copy)NSString *e_net;//网址
//@property(nonatomic,copy)NSString *e_phone;//电话
//@property(nonatomic,copy)NSString *e_place;//会展地点
//@property(nonatomic,copy)NSString *end_date;//会展结束时间
//@property(nonatomic,copy)NSString *keyword;
//@property(nonatomic,copy)NSString *n_date;//发布时间
//@property(nonatomic,copy)NSString *n_detail;//内容(html格式)
//@property(nonatomic,copy)NSString *n_hits;
//@property(nonatomic,copy)NSString *n_id;//信息id
//@property(nonatomic,copy)NSString *n_image_url;//主图
//@property(nonatomic,copy)NSString *n_resume;//摘要
//@property(nonatomic,copy)NSString *n_source;
//@property(nonatomic,copy)NSString *n_time;
//@property(nonatomic,copy)NSString *n_title;//标题
//@property(nonatomic,copy)NSString *n_type;
//@property(nonatomic,copy)NSString *start_date;//会展开始时间


+(instancetype)ModelWith:(NSDictionary *)dic;

@end
