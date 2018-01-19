//
//  TuiMulPhotoCollectionViewController.h
//  lianjiu
//
//  Created by LIHONG on 2017/11/17.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoMultModel.h"
#import "FileCollectionViewCell.h"
#import "PhotoCollectionViewController.h"
@interface TuiMulPhotoCollectionViewController : UICollectionViewController


@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)CGRect rect;
@property (nonatomic,assign)NSInteger photoNumber;
@property (nonatomic,strong)NSArray *headAndFootTitles;
@property (nonatomic,assign)id<PhotoCollectionViewDelegate> delegate;



@end
