//
//  WeiXiuSecondCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WeiXiuSecondCell.h"

@implementation WeiXiuSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.borderColor = BGColor.CGColor;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.masksToBounds = YES;
    
    
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
