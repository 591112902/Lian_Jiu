


#import <UIKit/UIKit.h>

#import "FaHuoViewController.h"

#import "QuPingLunViewController.h"
#import "YiPingLunViewController.h"
@interface KuaiDiOrderManageTVController : UITableViewController


@property (nonatomic)NSInteger type;


@property (nonatomic,strong)NSString *vip;
@property (nonatomic)BOOL isRequestData;//重新申请数据
//@property(nonatomic,strong)ModifyTableViewController *VC;

-(void)requestDataIsDown:(BOOL)isDown;

@end
