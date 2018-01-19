


#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "ChooseAssessVC.h"
#import "ZJNavigationController.h"
#import "ChanPinListVC.h"
@interface SellBottomFirstVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

{
    
    NSInteger pageNo;
    BOOL isDown;

}

@property (nonatomic, strong) UINavigationController *parentNavigationController;


@property(nonatomic,strong) NSString *categoryId;
@property(nonatomic,strong) NSString *typeStr;




//-(void)requestData;

-(void)headClickRequestData:(NSString *)categoryId WithOrder:(NSString *)order;



@end

