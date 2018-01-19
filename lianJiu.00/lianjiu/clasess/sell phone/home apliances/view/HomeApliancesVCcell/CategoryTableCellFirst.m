//
//  CategoryTableCell.m
//  RGCategoryView
//
//  Created by Arvin on 15/10/28.
//  Copyright © 2015年 com.roroge. All rights reserved.
//

#import "CategoryTableCellFirst.h"

#define RGB(R,G,B)              [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

@interface CategoryTableCellFirst ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UIView *bottomView;


@property (strong, nonatomic) IBOutlet UIView *bigView;


@end

@implementation CategoryTableCellFirst

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.bigView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*70);
//
//    self.headImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*34.5);
//    self.nameLabel.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.width/320.0*34.5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*34.5);
//    
//    self.bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.width/320.0*69, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*1);
//
    
    //self.lineViewHeight.constant = 0.5;
   
}

-(void)configCellWithTitle:(NSDictionary *)dataDic andIndexPath:(NSIndexPath *)indexPath andSelectIndexPath:(NSIndexPath *)selectIndexPath{
    self.nameLabel.text = dataDic[@"categoryName"]?dataDic[@"categoryName"]:@"";
   
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"categoryImage"]?dataDic[@"categoryImage"]:@""]];
    
    if (indexPath.section == selectIndexPath.section && indexPath.row == selectIndexPath.row){
      
        self.backgroundColor = RGB(235, 235, 235);
        self.nameLabel.textColor = [UIColor blackColor];
    }else {
      
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor blackColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
