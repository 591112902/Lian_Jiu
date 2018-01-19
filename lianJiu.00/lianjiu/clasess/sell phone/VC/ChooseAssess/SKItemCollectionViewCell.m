//
//  SKItemCollectionViewCell.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SKItemCollectionViewCell.h"
#import "Masonry.h"
#import "ZJPublicConfig.h"

@implementation SKItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

-(UILabel *)selectLabel{
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.textColor = [UIColor grayColor];
        _selectLabel.text = @"屏幕有划痕";
        _selectLabel.font = FONT(13);
        _selectLabel.textAlignment = NSTextAlignmentCenter;
        
        
        _selectLabel.numberOfLines = 0;
    }
    return _selectLabel;
}

-(UIButton *)infoButton{
    if (!_infoButton) {
        _infoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_infoButton setTintColor:[UIColor grayColor]];
        [_infoButton setImage:[UIImage imageNamed:@"zj_problem"] forState:UIControlStateNormal];
    }
    return _infoButton;
}

-(void)setup{
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    self.layer.borderWidth = 1;
    
    [self.contentView addSubview:self.selectLabel];
    [self.contentView addSubview:self.infoButton];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading);
        make.top.equalTo(self.contentView.mas_top);//
        make.trailing.equalTo(self.contentView.mas_trailing);//(self.infoButton.mas_leading).with.offset(-8);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [_infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-8);
        make.width.equalTo(@(15*ZJ_SCREEN_WIDTH_SCALE));
        make.height.equalTo(self.contentView.mas_height);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
}

@end
