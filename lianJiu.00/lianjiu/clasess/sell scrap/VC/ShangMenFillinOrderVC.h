
#import "ShangMenOrderViewController.h"
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface ShangMenFillinOrderVC : UIViewController

@property(nonatomic,strong)NSString *productId;
@property(nonatomic) BOOL userDefault;
@property(nonatomic,strong) NSDictionary *address;




@property(nonatomic,strong) NSString *goodImageViewStr;


@property(nonatomic,strong) NSString *productIdList;


@property(nonatomic,strong) NSString *price;








-(void)requestDataDef;

//
//@property(nonatomic,strong) NSString *payFromLianjiu;
//@property(nonatomic,strong) NSString *payFromOthers;

@end
