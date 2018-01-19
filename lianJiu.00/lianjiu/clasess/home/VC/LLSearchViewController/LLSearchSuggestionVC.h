//
//  LLSearchSuggestionVC.h
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrapDetailViewController.h"
#import "ChooseConditionVC.h"
#import "UsedGoodsDetailVC.h"
typedef void(^SuggestSelectBlock)(NSString *searchTest);
@interface LLSearchSuggestionVC : UIViewController

@property(nonatomic,strong)NSString *qExcellent;

@property (nonatomic, copy) SuggestSelectBlock searchBlock;

- (void)searchTestChangeWithTest:(NSString *)test;

@end
