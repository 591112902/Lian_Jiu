//
//  PhotoCollectionViewController.h
//  zaiShang
//
//  Created by cnmobi on 15/12/8.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//
@protocol PhotoCollectionViewDelegate <NSObject>

-(void)collectionView:(UIView*)view ChangeHeight:(CGFloat)Chageheight;

@end
#import <UIKit/UIKit.h>

@interface PhotoCollectionViewController : UICollectionViewController
@property (nonatomic,strong)NSMutableArray *photoDataSouc;
@property (nonatomic,assign)CGRect rect;
@property (nonatomic,assign)NSInteger photoNumber;//最大图片
@property (nonatomic,copy)NSString *headTitle;
@property (nonatomic,assign)id<PhotoCollectionViewDelegate> delegate;
@end
