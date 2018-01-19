//
//  SKSelectionItemCell.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoDelayButtonCollectionView.h"
#import "ZJRateRow.h"
@protocol SKSelectionCellDelegate <NSObject>
- (void)didSelected:(ZJRateRow *)row value:(NSString *)value indexPath:(NSIndexPath *)indexPath;
@end

@interface SKSelectionItemCell : UITableViewCell
@property (strong,nonatomic) NoDelayButtonCollectionView *collectionView;
@property (strong,nonatomic) ZJRateRow      *row;
@property (nonatomic, weak) id <SKSelectionCellDelegate> delegate;
@property (strong,nonatomic) NSIndexPath   *indexPath;
@end
