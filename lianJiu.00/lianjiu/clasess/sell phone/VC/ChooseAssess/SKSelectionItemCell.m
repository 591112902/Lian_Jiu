//
//  SKSelectionItemCell.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SKSelectionItemCell.h"
#import "Masonry.h"
#import "SKItemCollectionViewCell.h"
#import "ZJPublicConfig.h"
#import "ZJRateModal.h"

@interface SKSelectionItemCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation SKSelectionItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setup];
        
    }
    return self;
}

-(void)setup{
    
    [self.contentView addSubview:self.collectionView];
    
}

-(void)setRow:(ZJRateRow *)row{
    _row = row;
    
    [_collectionView reloadData];
}

-(NoDelayButtonCollectionView *)collectionView{
    if (!_collectionView) {

        CGFloat itemSpacing = 8;
        CGFloat lineSpacing = 8;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset    = UIEdgeInsetsMake(8, 8, 8, 8);
        
        layout.minimumInteritemSpacing = itemSpacing;
        layout.minimumLineSpacing      = lineSpacing;
        layout.scrollDirection         = UICollectionViewScrollDirectionVertical;
        layout.itemSize                = CGSizeMake(([UIScreen mainScreen].bounds.size.width-3*8)/2, ZJ_RATEBUTTON_HEIGHT);
        
        _collectionView = [[NoDelayButtonCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = false;
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        [_collectionView registerClass:[SKItemCollectionViewCell class] forCellWithReuseIdentifier:@"SKItemCollectionViewCell"];

        
    }
    return _collectionView;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading);
        make.top.equalTo(self.contentView.mas_top);
        make.trailing.equalTo(self.contentView.mas_trailing);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.row.values.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SKItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SKItemCollectionViewCell" forIndexPath:indexPath];
    ZJRateValue *value = (ZJRateValue *)_row.values[indexPath.row];
    cell.selectLabel.text = value.value;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJRateValue *value = (ZJRateValue *)_row.values[indexPath.row];
    if (_delegate) {
        [_delegate didSelected:_row value:value.value indexPath:_indexPath];
    }
}

@end
