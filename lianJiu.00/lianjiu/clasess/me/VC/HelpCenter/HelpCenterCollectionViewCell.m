//
//  MainCollectionViewCell.m
//  zaiShang
//
//  Created by cnmobi on 15/8/20.
//  Copyright (c) 2015年 CNMOBI. All rights reserved.
//

#import "HelpCenterCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation HelpCenterCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
//    self.contentView.layer.borderColor=[UIColor darkGrayColor].CGColor;
//    self.contentView.layer.borderWidth=0.3;
   
    self.contentView.backgroundColor = [UIColor whiteColor];

}


-(void)fillCellWithModel:(ScrapModel*)model
{
    NSString *urlStr = [model.categoryImage excisionForFistString];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"180x180"]];

    self.title.text = model.categoryName;
//
}
@end
