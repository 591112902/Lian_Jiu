//
//  Modify_PriceTableViewCell.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ScrapDetailTableViewCell.h"



@implementation ScrapDetailTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        
        
        
       // [UIScreen mainScreen].bounds.size.width/320.0*133;
        
        
        
        self.iv = [[UIImageView alloc] init];
        self.iv.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, [UIScreen mainScreen].bounds.size.width/320.0*17, [UIScreen mainScreen].bounds.size.width/320.0*117, [UIScreen mainScreen].bounds.size.width/320.0*113);
       // self.iv.backgroundColor = [UIColor blueColor];
        self.iv.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.iv];
        
        
        
        //111
        self.leftL1 = [[UILabel alloc] init];
        self.leftL1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*133, [UIScreen mainScreen].bounds.size.width/320.0*17, [UIScreen mainScreen].bounds.size.width/320.0*51, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.leftL1.font = [UIFont systemFontOfSize:15];
        self.leftL1.textColor = [UIColor blackColor];
        self.leftL1.textAlignment = NSTextAlignmentCenter;
        self.leftL1.adjustsFontSizeToFitWidth = YES;
        //self.leftL.numberOfLines = 0;
        self.leftL1.text = @"名称:";
        [self.contentView addSubview:self.leftL1];
        
        self.rightL1 = [[UILabel alloc] init];
        self.rightL1.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*186, [UIScreen mainScreen].bounds.size.width/320.0*17, [UIScreen mainScreen].bounds.size.width/320.0*124, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.rightL1.font = [UIFont systemFontOfSize:15];
        self.rightL1.textAlignment = NSTextAlignmentCenter;
        self.rightL1.adjustsFontSizeToFitWidth = YES;
        //self.rightL.numberOfLines = 0;
        self.rightL1.text = @"4556元";
        [self.contentView addSubview:self.rightL1];
        
        //22
        self.leftL2 = [[UILabel alloc] init];
        self.leftL2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*133, [UIScreen mainScreen].bounds.size.width/320.0*46, [UIScreen mainScreen].bounds.size.width/320.0*51, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.leftL2.font = [UIFont systemFontOfSize:15];
        self.leftL2.textColor = [UIColor blackColor];
        self.leftL2.textAlignment = NSTextAlignmentCenter;
        self.leftL2.adjustsFontSizeToFitWidth = YES;
        //self.leftL.numberOfLines = 0;
        self.leftL2.text = @"单价:";
        [self.contentView addSubview:self.leftL2];
        
        self.rightL2 = [[UILabel alloc] init];
        self.rightL2.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*186, [UIScreen mainScreen].bounds.size.width/320.0*46, [UIScreen mainScreen].bounds.size.width/320.0*124, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.rightL2.font = [UIFont systemFontOfSize:15];
        self.rightL2.textAlignment = NSTextAlignmentCenter;
        self.rightL2.adjustsFontSizeToFitWidth = YES;
        //self.rightL.numberOfLines = 0;
        self.rightL2.text = @"4556元";
        [self.contentView addSubview:self.rightL2];
        
        
        
        
        //4
        self.leftL4 = [[UILabel alloc] init];
        self.leftL4.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*133, [UIScreen mainScreen].bounds.size.width/320.0*104, [UIScreen mainScreen].bounds.size.width/320.0*51, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.leftL4.font = [UIFont systemFontOfSize:15];
        self.leftL4.textColor = [UIColor blackColor];
        self.leftL4.textAlignment = NSTextAlignmentCenter;
        self.leftL4.adjustsFontSizeToFitWidth = YES;
        //self.leftL.numberOfLines = 0;
        self.leftL4.text = @"回收价格:";
        [self.contentView addSubview:self.leftL4];
        
        self.rightL4 = [[UILabel alloc] init];
        self.rightL4.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*186, [UIScreen mainScreen].bounds.size.width/320.0*104, [UIScreen mainScreen].bounds.size.width/320.0*124, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.rightL4.font = [UIFont systemFontOfSize:15];
        self.rightL4.textAlignment = NSTextAlignmentCenter;
        self.rightL4.adjustsFontSizeToFitWidth = YES;
        //self.rightL.numberOfLines = 0;
        self.rightL4.text = @"0.00元";
        [self.contentView addSubview:self.rightL4];
        
        
        
        
        //3
        self.leftL = [[UILabel alloc] init];
        self.leftL.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*133, [UIScreen mainScreen].bounds.size.width/320.0*75, [UIScreen mainScreen].bounds.size.width/320.0*51, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.leftL.font = [UIFont systemFontOfSize:15];
        self.leftL.textColor = [UIColor blackColor];
        self.leftL.textAlignment = NSTextAlignmentCenter;
        self.leftL.adjustsFontSizeToFitWidth = YES;
        //self.leftL.numberOfLines = 0;
        self.leftL.text = @"数量:";
        [self.contentView addSubview:self.leftL];
        
        //    self.rightL = [[UILabel alloc] init];
        //    self.rightL.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*186, [UIScreen mainScreen].bounds.size.width/320.0*75, [UIScreen mainScreen].bounds.size.width/320.0*124, [UIScreen mainScreen].bounds.size.width/320.0*21);
        //    self.rightL.font = [UIFont systemFontOfSize:15];
        //    self.rightL.textAlignment = NSTextAlignmentCenter;
        //    self.rightL.adjustsFontSizeToFitWidth = YES;
        //    //self.rightL.numberOfLines = 0;
        //    self.rightL.text = @"4556元";
        //    [self.contentView addSubview:self.rightL];
        self.numberTextField = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*186, [UIScreen mainScreen].bounds.size.width/320.0*75, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*21)];
        self.numberTextField.placeholder = @"自填";
        self.numberTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.numberTextField.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.numberTextField];

        
        
        
        
        
        
        self.danweiL = [[UILabel alloc] init];
        self.danweiL.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*276, [UIScreen mainScreen].bounds.size.width/320.0*75, [UIScreen mainScreen].bounds.size.width/320.0*44, [UIScreen mainScreen].bounds.size.width/320.0*21);
        self.danweiL.font = [UIFont systemFontOfSize:15];
        self.danweiL.textAlignment = NSTextAlignmentCenter;
        self.danweiL.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.danweiL];
        
        
        
        //[self.contentView addSubview:self.numberButton];
    }
    return self;
}









- (void)awakeFromNib {
    [super awakeFromNib];
    
    
  }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
