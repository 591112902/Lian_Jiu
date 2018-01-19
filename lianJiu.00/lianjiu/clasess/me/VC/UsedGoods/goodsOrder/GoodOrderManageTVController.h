


#import <UIKit/UIKit.h>

#import "UsedGoodsDetailVC.h"
#import "PaymentViewController.h"
#import "GoodsCommentVC.h"
#import "ReturnOrderVC.h"
#import "YiGoodsCommentVC.h"
@interface GoodOrderManageTVController : UITableViewController


@property (nonatomic)NSInteger type;


@property (nonatomic,strong)NSString *vip;
@property (nonatomic)BOOL isRequestData;//重新申请数据
//@property(nonatomic,strong)ModifyTableViewController *VC;
@end
