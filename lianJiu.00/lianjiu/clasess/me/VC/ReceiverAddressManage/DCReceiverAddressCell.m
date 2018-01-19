//
//  DCReceiverAddressCell.m
//  CDDMall
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCReceiverAddressCell.h"
#import "DCSpeedy.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others
//CGFloat const DCMargin = 5;
#define DCMargin 10

@interface DCReceiverAddressCell ()

/* 收件人名称 */
@property (strong , nonatomic)UILabel *adNameLabel;
/* 收件人电话 */
@property (strong , nonatomic)UILabel *adPhoneLabel;
/* 收件人详细地址 */
@property (strong , nonatomic)UILabel *adDetailLabel;



/* 分割线(heng) */
@property (strong , nonatomic)UIView *partingLine;
/* 分割线(shu) */
@property (strong , nonatomic)UIView *verticalLine;

@end

@implementation DCReceiverAddressCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    
    _adNameLabel = [[UILabel alloc] init];
    _adNameLabel.font = PFR15Font;
    [self addSubview:_adNameLabel];
    
    _adPhoneLabel = [[UILabel alloc] init];
    _adPhoneLabel.font = _adNameLabel.font;
    _adPhoneLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_adPhoneLabel];
    
    _adDetailLabel = [[UILabel alloc] init];
    _adDetailLabel.font = PFR14Font;
    _adDetailLabel.numberOfLines = 0; 
    //_adDetailLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_adDetailLabel];
    
    _partingLine = [[UIView alloc] init];
    _partingLine.backgroundColor = BGColor;
    [self addSubview:_partingLine];
    
    _defaultAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultAddressButton setTitle:@"设为默认" forState:UIControlStateNormal];
    
       
    _defaultAddressButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);//上左下右
    //_defaultAddressButton.imageEdgeInsets = UIEdgeInsetsMake(8,8,8,8);//上左下右
    _defaultAddressButton.titleLabel.font = PFR14Font;
    [_defaultAddressButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_defaultAddressButton setImage:[UIImage imageNamed:@"unSelect_btn"] forState:UIControlStateNormal];
    [_defaultAddressButton setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateSelected];
    [self addSubview:_defaultAddressButton];
    [_defaultAddressButton addTarget:self action:@selector(defaultAddressButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    
     _editButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);//上左下右
    
    _editButton.titleLabel.font = PFR14Font;
    [_editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_editButton setImage:[UIImage imageNamed:@"Address_bianji"] forState:UIControlStateNormal];
    [self addSubview:_editButton];
    [_editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
//    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//    _deleteButton.titleLabel.font = PFR14Font;
//    [_deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [_deleteButton setImage:[UIImage imageNamed:@"Address_shanchu"] forState:UIControlStateNormal];
//    [self addSubview:_deleteButton];
//    [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    _verticalLine = [[UIView alloc] init];
//    _verticalLine.backgroundColor = _partingLine.backgroundColor;
   // [self addSubview:_verticalLine];
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    frame.origin.y += 5;
    
//    frame.origin.x += 0;
//    frame.size.width -=  2 * 0;
    
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_adNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.height.mas_equalTo(30);
    }];
    
    [_adPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_adNameLabel.mas_right)setOffset:DCMargin * 2];
        
         [make.right.mas_equalTo(self)setOffset:-DCMargin];
        
        make.centerY.mas_equalTo(_adNameLabel);
    }];
    
    [_adDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_adNameLabel);
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(_adNameLabel.mas_bottom)setOffset:DCMargin];
        
    }];
    
    [_partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_adNameLabel);
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        
        
        
//        make.left.mas_equalTo(self);
//        make.right.mas_equalTo(self);
//        make.width.mas_equalTo(self);
        [make.top.mas_equalTo(_adDetailLabel.mas_bottom)setOffset:DCMargin];
        make.height.mas_equalTo(1);
    }];
    
    [_defaultAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        [make.left.mas_equalTo(self)setOffset:5];
        make.height.mas_equalTo(35);
         make.width.mas_equalTo(90);
    }];
    
    
    
#pragma mark-只留编辑
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        [make.right.mas_equalTo(self)setOffset:-10];
        make.height.mas_equalTo(35);
         make.width.mas_equalTo(90);
        
    }];
    
//    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self);
//        [make.right.mas_equalTo(self)setOffset:-DCMargin];
//        make.height.mas_equalTo(35);
//       
//    }];
//
//    
//    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_deleteButton);
//        [make.right.mas_equalTo(_deleteButton.mas_left)setOffset:-5];
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(1);
//    }];
//    
//    
//    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self);
//        [make.right.mas_equalTo(_verticalLine.mas_left)setOffset:-5];
//        make.height.mas_equalTo(35);
//    }];
}



#pragma mark - 点击事件
- (void)defaultAddressButtonSelect:(UIButton *)button
{
    self.isSelect = !self.isSelect;
    if (self.dSelectBlock) {
        self.dSelectBlock(self.isSelect,button.tag);
    }
    
    // button.selected = !button.selected;
//    if (!button.selected) {
//        !_defaultClickBlock ? : _defaultClickBlock();
//    }
}
- (void)editButtonClick
{
    !_editClickBlock ? : _editClickBlock();
}
- (void)deleteButtonClick
{
    !_delectClickBlock ? : _delectClickBlock();
}


#pragma mark - Setter Getter Methods
-(void)fillCellWithModel:(DCAddressItem*)model
{
    
    //self.usernameL.text = model.username;
    self.adNameLabel.text = model.userAddressName;;
    self.adPhoneLabel.text = model.userAddressPhone;;
    self.adDetailLabel.text = [NSString stringWithFormat:@"%@",model.userLocation];//[NSString stringWithFormat:@"%@%@%@%@%@",model.userProvince,model.userCity,model.userDistrict, model.userSite,model.userLocation];
    
    
   
}



//- (void)setAdItem:(DCAddressItem *)adItem
//{
//    _adItem = adItem;
//    _adNameLabel.text = adItem.adName;
//    _adPhoneLabel.text = adItem.adPhone;
//    _adDetailLabel.text = [NSString stringWithFormat:@"%@%@",adItem.adCity,adItem.adDetail];
//    
//   // _adPhoneLabel.text = [DCSpeedy dc_EncryptionDisplayMessageWith:adItem.adPhone WithFirstIndex:3]; //电话号码保密
//
//    //_defaultAddressButton.selected = adItem.isDefault;
//}



@end
