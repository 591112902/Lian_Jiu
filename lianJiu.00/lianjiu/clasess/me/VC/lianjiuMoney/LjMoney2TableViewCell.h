


#import <UIKit/UIKit.h>
#import "AccountModel.h"
@interface LjMoney2TableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *accumulatedAmountL;



@property (strong, nonatomic) IBOutlet UILabel *walletDrawingL;

@property (strong, nonatomic) IBOutlet UILabel *userAssetL;



@property (strong, nonatomic) IBOutlet UIButton *smrzBtn;


@property (strong, nonatomic) IBOutlet UIButton *bdyhkBtn;









@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;







-(void)fillCellWithModel:(AccountModel*)model;



@end
