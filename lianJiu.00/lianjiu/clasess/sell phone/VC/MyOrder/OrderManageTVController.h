


#import <UIKit/UIKit.h>



@interface OrderManageTVController : UITableViewController


@property (nonatomic)NSInteger type;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *vip;
@property (nonatomic)BOOL isRequestData;//重新申请数据
//@property(nonatomic,strong)ModifyTableViewController *VC;
@end
