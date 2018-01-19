//
//  PhotoMultModel.h
//  zaiShang
//
//  Created by cnmobi on 15/12/19.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoMultModel : NSObject
@property (nonatomic,strong)NSMutableArray *photoDataSouc;
@property (nonatomic,assign)NSInteger photoNumber;
@property (nonatomic,copy)NSString *headTitle;
@property (nonatomic,copy)NSString *footTitle;
@property (nonatomic)BOOL isaddPhoto;
@end
