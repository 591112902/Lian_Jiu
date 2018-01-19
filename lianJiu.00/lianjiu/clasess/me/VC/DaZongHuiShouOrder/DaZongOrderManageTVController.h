


#import <UIKit/UIKit.h>

#import "QuPingLunViewController.h"
#import "DZ_DetailListVC.h"
#import "YiPingLunViewController.h"


@interface DaZongOrderManageTVController : UITableViewController


@property (nonatomic)NSInteger type;


@property (nonatomic,strong)NSString *vip;
@property (nonatomic)BOOL isRequestData;//重新申请数据
//@property(nonatomic,strong)ModifyTableViewController *VC;
@end
