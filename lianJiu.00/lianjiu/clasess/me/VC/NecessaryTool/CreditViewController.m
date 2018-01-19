//
//  CreditViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/8/26.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import "CreditViewController.h"
//#import "C_ContenTableViewController.h"
#import "UIImageView+WebCache.h"
@interface CreditViewController ()
{
    NSInteger imgValue;
}
@end

@implementation CreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//    backItem.title = CustomLocalizedString(@"返回", nil);
//    self.navigationItem.backBarButtonItem = backItem;
   
    
    //NSInteger rating = [CreditViewController MyCreditRating:self.userModel.integral];
    
    NSInteger rating = [self.userModel.grade integerValue];
    
    
    self.headImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"vip_lv%ld",(long)rating]];
    
    self.GradeLabel.text = [NSString stringWithFormat:@"积分:%@",self.userModel.integral];
    
    
    
    
    self.huanbaoL.text = [NSString stringWithFormat:@"环保等级:%zd",rating];
    
}



+ (NSInteger)MyCreditRating:(NSNumber*)credit
{
    NSArray *arr = @[@0,@100,@300,@400,@500,@700,@800,@900,@600000,];
    NSInteger rating = 0;
    for (NSNumber *num in arr) {
        if ([credit compare:num] == NSOrderedDescending  ) {
            
            
            if (([credit integerValue]>=901)) {
                break;
            }else{
                
               rating++;
                
            }
            
            
            
        }else{
            break;
        }
    }
    return rating==0?1:rating;
}

@end
