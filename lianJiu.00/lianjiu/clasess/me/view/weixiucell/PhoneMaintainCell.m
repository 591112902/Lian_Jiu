//
//  MainCollectionViewCell.m
//  zaiShang
//
//  Created by cnmobi on 15/8/20.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import "PhoneMaintainCell.h"
#import "UIImageView+WebCache.h"
@implementation PhoneMaintainCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
//    self.contentView.layer.borderColor=[UIColor darkGrayColor].CGColor;
//    self.contentView.layer.borderWidth=0.3;
//    self.contentView.backgroundColor = [UIColor whiteColor];

    
}


-(void)fillCellWithModel:(PhoneMaintainModel*)model
{
    
    
    NSString *urlStr = [model.categoryImage excisionForFistString];

    [self.headImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@""]];
    _headImage.layer.cornerRadius=3;// 将图层的边框设置为圆角
    _headImage.layer.masksToBounds=YES;// 隐藏边界
    _headImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.nameBtn setTitle:model.categoryName forState:UIControlStateNormal];
//    STRINGNONIL(model.t_quality);
//    self.num.text = [model.t_quality stringByAppendingString:model.dw_name?model.dw_name:@""];
    
   
}
@end
