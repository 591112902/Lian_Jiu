//
//  DCFillinOrderViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/27.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface DCFillinOrderViewController : UIViewController

@property(nonatomic,strong)NSString *productId;
@property(nonatomic) BOOL userDefault;
@property(nonatomic,strong) NSDictionary *address;




@property(nonatomic,strong) NSString *goodImageViewStr;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *nameDetail;






//
//@property(nonatomic,strong) NSString *payFromLianjiu;
//@property(nonatomic,strong) NSString *payFromOthers;

@end
