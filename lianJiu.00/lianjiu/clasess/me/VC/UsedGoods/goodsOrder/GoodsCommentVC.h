//
//  GoodsCommentVC.h
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCommentVC : UIViewController


@property (strong, nonatomic)NSString *ordersId;
@property (strong, nonatomic)NSString *orItemsProductId;
@property (strong, nonatomic)NSString *nameS;


@property (strong, nonatomic) IBOutlet UIButton *commentBtn;





@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UITextView *contentTV;
- (IBAction)commentAction:(id)sender;


@end
