

#import <UIKit/UIKit.h>

#import "SmrzViewController.h"
#import "BdyhkViewController.h"
#import "TXVC.h"

#import "YetBdyhkViewController.h"
#import "FDAlertView.h"
@interface LianjiuMoneyVC : UIViewController
@property (nonatomic)BOOL isRequestData;//是否刷新数据
@property (nonatomic,strong)NSNumber *zuJi;//足迹数量
@property (nonatomic,strong)NSNumber *souCang;//收藏数量
@property (nonatomic,strong)NSNumber *xiaoXi;//消息数量
@property (nonatomic,strong)NSNumber *isHuiShouShang;//是否回收商



@end
