//
//  SMTableViewCell.m
//  lianjiu
//
//  Created by 洪铭翔 on 17/11/20.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "SMTableViewCell.h"
#import "CalculateManager.h"
#import "UIColor+ChangeColor.h"
#import "UIImageView+WebCache.h"

@interface SMTableViewCell ()
@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *Label;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation SMTableViewCell
- (void)createUI {
    _flagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unSelect_btn"]];
    [self.contentView addSubview:_flagImageView];
    
    _pictureImageView = [[UIImageView alloc] init];
    _pictureImageView.layer.borderColor = [UIColor HexString:@"#e5e5e5"].CGColor;
    _pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    _pictureImageView.layer.borderWidth = 1;
    _pictureImageView.clipsToBounds = YES;
    [self.contentView addSubview:_pictureImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = Calculate_Font(28);
    [self.contentView addSubview:_nameLabel];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = Calculate_Font(24);
    _numberLabel.textColor = [UIColor HexString:@"#989898"];
    [self.contentView addSubview:_numberLabel];
    
    _Label = [[UILabel alloc] init];
    _Label.font = Calculate_Font(24);
    _Label.textColor = [UIColor HexString:@"#989898"];
    [self.contentView addSubview:_Label];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = Calculate_Font(26);
    _priceLabel.textColor = [UIColor HexString:@"#2bd82a"];
    [self.contentView addSubview:_priceLabel];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor HexString:@"#e5e5e5"];
    [self.contentView addSubview:_lineView];
    
}
- (void)setConstraints {
    __weak UIView *superView = self.contentView;
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.width.offset(Calculate_Width(38));
        make.centerY.equalTo(superView.mas_centerY);
    }];
    [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_flagImageView.mas_right).offset(Calculate_Width(26));
        make.width.offset(Calculate_Width(198));
        make.height.offset(Calculate_Height(160));
        make.centerY.equalTo(superView.mas_centerY);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pictureImageView.mas_right).offset(Calculate_Width(30));
        make.height.offset(Calculate_Height(28));
        make.top.equalTo(superView.mas_top).offset(Calculate_Height(40));
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pictureImageView.mas_right).offset(Calculate_Width(38));
        make.height.offset(Calculate_Height(28));
        make.top.equalTo(_nameLabel.mas_bottom).offset(Calculate_Height(24));
    }];
    [_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pictureImageView.mas_right).offset(Calculate_Width(38));
        make.height.offset(Calculate_Height(28));
        make.top.equalTo(_numberLabel.mas_bottom).offset(Calculate_Height(24));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_Label.mas_right);
        make.height.offset(Calculate_Height(28));
        make.top.equalTo(_numberLabel.mas_bottom).offset(Calculate_Height(24));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.height.offset(1);
        make.bottom.equalTo(superView.mas_bottom);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
    [self setConstraints];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(CallbackModel *)model {
    if (_model != model) {
        _model = model;
        _nameLabel.text = _model.orItemsName;
        _numberLabel.text = [NSString stringWithFormat:@"数量：%@", _model.orItemsNum];
        float sum = [_model.orItemsNum integerValue] * [_model.orItemsPrice floatValue];
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"评估价格：%.2f元", sum]];
        [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 5)];
        _priceLabel.attributedText = priceStr;
        [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:_model.orItemsPicture]];
    }
    _flagImageView.image = _model.isSelected?[UIImage imageNamed:@"selected_btn"]:[UIImage imageNamed:@"unSelect_btn"];
}

@end
