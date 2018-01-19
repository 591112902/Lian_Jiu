

#import "LjMoney2TableViewCell.h"
#import "UIImageView+WebCache.h"
//#import "CreditViewController.h"

@implementation LjMoney2TableViewCell



- (void)awakeFromNib {
    // Initialization code
}

-(void)fillCellWithModel:(AccountModel*)mode
{
    
   // NSInteger rating = [CreditViewController MyCreditRating:mode.line_credit];
  //  self.headImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"vip_lv%ld",@""]];

    
   // self.nameLabel.text = mode.vip?mode.vip:mode.name;
    
    [self.rightBtn setTitle:CustomLocalizedString(@"签到", nil) forState:UIControlStateNormal];
}

-(void)dealloc{

    HZLog(@"%@",self.class);
}
@end
