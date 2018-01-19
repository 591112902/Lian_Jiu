//
//  CreditViewController.h
//  zaiShang
//
//  Created by cnmobi on 15/8/26.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"
@interface CreditViewController : UIViewController

typedef void(^giveValueBlock)(NSString *);
@property(nonatomic,copy)giveValueBlock block;


@property (nonatomic,strong)AccountModel *userModel;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *GradeLabel;


@property (strong, nonatomic) IBOutlet UILabel *huanbaoL;




@property (weak, nonatomic) IBOutlet UIImageView *oneImgView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fourImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveImgView;
@property (weak, nonatomic) IBOutlet UIImageView *sixImgView;
@property (weak, nonatomic) IBOutlet UIImageView *sevenImgView;
@property (weak, nonatomic) IBOutlet UIImageView *eightIvgView;
@property (weak, nonatomic) IBOutlet UIImageView *nineImgView;
@property (weak, nonatomic) IBOutlet UIImageView *tenImgView;
@property (weak, nonatomic) IBOutlet UIImageView *elevenImgView;

/*
 计算信用等级
 
 credit 信用值
 
 result 信用等级
 */
+ (NSInteger)MyCreditRating:(NSNumber*)credit;
@end
