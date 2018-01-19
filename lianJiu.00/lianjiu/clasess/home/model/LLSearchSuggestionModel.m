

#import "LLSearchSuggestionModel.h"

@implementation LLSearchSuggestionModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    LLSearchSuggestionModel *model = [[self alloc] init];
    
    
    model.productId = dic[@"productId"];
    model.productName = dic[@"productName"];
    model.productMaxPrice = dic[@"productMaxPrice"];
    
    model.category = dic[@"category"];
  
    
//    model.e_img2 = dic[@"e_img2"];
//    model.e_industry = dic[@"e_industry"];
//    model.e_mobile = dic[@"e_mobile"];
//    model.e_net = dic[@"e_net"];
//    model.e_phone = dic[@"e_phone"];
//    model.e_place = dic[@"e_place"];
//    model.end_date = dic[@"end_date"];
//    model.keyword = dic[@"keyword"];
//    model.n_date = dic[@"n_date"];
//    model.n_detail = dic[@"n_detail"];
//    model.n_hits = dic[@"n_hits"];
//    model.n_id = dic[@"n_id"];
//    model.n_image_url = dic[@"n_image_url"];
//    model.n_resume = dic[@"n_resume"];
//    model.n_source = dic[@"n_source"];
//    model.n_time = dic[@"n_time"];
//    model.n_title = dic[@"n_title"];
//    model.n_type = dic[@"n_type"];
//    model.start_date = dic[@"start_date"];
    
    return model;
}

@end
