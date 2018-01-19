


#import <UIKit/UIKit.h>
#import "CommitListModel.h"
#import "CommitListNextVC.h"
#import "LoginViewController.h"

@interface CommitListVC : UIViewController

@property(nonatomic,strong) NSString *categoryId;

@property(nonatomic,strong) NSString *jiaORShou;



@property(nonatomic,strong)NSMutableArray *dataSour;
@end
