//
//  DCBrandSortCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#import "Masonry.h"

#import "DCBrandSortCell.h"

// Controllers

// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
// Views

// Vendors
#import "UIImageView+WebCache.h"
// Categories

// Others

@interface DCBrandSortCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *brandImageView;

@end

@implementation DCBrandSortCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
   
    _brandImageView = [[UIImageView alloc] init];
    _brandImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_brandImageView];
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 20, self.frame.size.height - 25));
    }];
}

#pragma mark - Setter Getter Methods
- (void)setSubItem:(DCCalssSubItem *)subItem
{
    _subItem = subItem;
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:subItem.image_url]];
}

@end
