//
//  ShoppingCarCell.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "UConstants.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"

@implementation ShoppingCarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (110-20)/2.0, 20, 20)];
   
    self.checkImg.image =IMAGENAMED(@"check_p");
    [self addSubview:self.checkImg];
    
  
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkImg.right+10,15, 90.8, 60)];
   // self.shopImageView.backgroundColor = [UIColor redColor];
    self.shopImageView.image = IMAGENAMED(@"img");
    self.shopImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.shopImageView];
    
    
    
    
    
    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,10,kScreenWidth-self.shopImageView.right-20, 20)];
    self.shopNameLab.text = @"乐视显示屏";
    self.shopNameLab.numberOfLines = 0;
    self.shopNameLab.font = SYSTEMFONT(16);
    [self addSubview:self.shopNameLab];
    
    
    
    
    self.numberTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopNameLab.left,self.shopNameLab.bottom+5,self.shopNameLab.width, 20)];
    self.numberTitleLab.text = @"数量:10";
    self.numberTitleLab.textColor = [UIColor darkGrayColor];
    self.numberTitleLab.font = SYSTEMFONT(12);
    [self addSubview:self.numberTitleLab];
    
    
    
    
    self.shopTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopNameLab.left,60,60, 20)];
    self.shopTypeLab.text = @"评估价格:";
    self.shopTypeLab.textColor = [UIColor darkGrayColor];
    //self.shopTypeLab.backgroundColor = [UIColor darkGrayColor];
    self.shopTypeLab.font = SYSTEMFONT(12);
    [self addSubview:self.shopTypeLab];
    
    
    
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopTypeLab.left+60, 60, self.shopNameLab.width-60, 20)];
    self.priceLab.textColor = MAINColor;
    //self.priceLab.backgroundColor = [UIColor darkGrayColor];
    self.priceLab.text = @"￥123.00";
    self.priceLab.textAlignment = NSTextAlignmentLeft;
    self.priceLab.font = SYSTEMFONT(16);
    [self addSubview:self.priceLab];
    
    
    
    
    
    _deletButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deletButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 10, 30, 20);
    [_deletButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deletButton setTitle:@"删除" forState:UIControlStateHighlighted];
    [_deletButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _deletButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_deletButton addTarget:self action:@selector(deletButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _deletButton.tag = 102;
    
    // [self.contentView addSubview:_deletButton];
    
    
    
    UIImageView *lineIV = [[UIImageView alloc] init];
    lineIV.frame = CGRectMake(8, 90, [UIScreen mainScreen].bounds.size.width-16, 1);
    lineIV.backgroundColor = BGColor;
    [self.contentView addSubview:lineIV];
    
}
- (void)deletButtonAction:(UIButton *)button
{
    [self.delegate isDelet:self andDeletButtonTag:button.tag];
}



-(void)setShoppingModel:(ShoppingModel *)shoppingModel{
    
    _shoppingModel = shoppingModel;
    //self.shopNameLab.text = shoppingModel.goodsTitle;
    
    if (shoppingModel.selectState)
    {
        self.checkImg.image = [UIImage imageNamed:@"check_p"];
        self.selectState = YES;
        
    }else{
        self.selectState = NO;
        self.checkImg.image = [UIImage imageNamed:@"check_n"];
    }
    
    
    if (shoppingModel.isExpress) {
         self.priceLab.text = [NSString stringWithFormat:@"%@元",shoppingModel.orItemsPrice];
    }else{
        self.priceLab.text = [NSString stringWithFormat:@"%.2f元",shoppingModel.orItemsNum.doubleValue *shoppingModel.orItemsPrice.doubleValue];
    }
   
    
    
    self.shopNameLab.text = shoppingModel.orItemsName;
    
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shoppingModel.orItemsPicture] placeholderImage:nil];
    
//    self.shopImageView.image = IMAGENAMED(shoppingModel.imageName);
    self.numberTitleLab.text = [NSString stringWithFormat:@"数量%.2f",shoppingModel.orItemsNum.floatValue];
//    self.addNumberView.numberString = [NSString stringWithFormat:@"%d",shoppingModel.goodsNum];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
