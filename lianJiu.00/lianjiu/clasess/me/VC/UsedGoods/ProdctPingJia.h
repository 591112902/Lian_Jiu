//
//  SegmentViewController.h
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "SegmentPageBaseViewController.h"

@interface ProdctPingJia : SegmentPageBaseViewController

@property(nonatomic,strong) NSString *pid;


-(void)requestData:(NSString *)pid;

@end
