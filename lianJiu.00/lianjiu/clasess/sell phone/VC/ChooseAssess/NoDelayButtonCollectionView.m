//
//  NoDelayButtonCollectionView.m
//  FDDPlus
//
//  Created by Fadada-Zhou on 2017/3/20.
//  Copyright © 2017年 fadada. All rights reserved.
//

#import "NoDelayButtonCollectionView.h"

@implementation NoDelayButtonCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delaysContentTouches = NO;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delaysContentTouches = NO;
    }
    
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:UIButton.class]) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
