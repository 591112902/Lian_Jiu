//
//  UsedGoodsVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/18.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "UsedGoodsVC.h"
#import "SDCycleScrollView.h"
#import "UsedGoodsDetailVC.h"
#import "ZSWViewController.h"
#import "UIImageView+WebCache.h"

@interface UsedGoodsVC ()<SDCycleScrollViewDelegate>
{
    UIScrollView *_scrollV;
    CGFloat _scrollVH;
    SDCycleScrollView *cycleScrollView;//滚动视图
    NSMutableArray *scrollPhotoList;
    
    NSString *productId1;
    NSString *productId2;
    NSString *productId3;
    NSString *productId4;
    
    
    NSString *title1;
    NSString *title2;
    NSString *title3;
    NSString *title4;
    
    
    NSString *mingCheng1;
    NSString *mingCheng2;
    NSString *mingCheng3;
    NSString *mingCheng4;
    NSString *mingCheng5;
    NSString *mingCheng6;
    
}

@end

@implementation UsedGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self ADDCarousel];
    
    
    
    
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    //图片轮播器
    CGFloat headImageH = BOUND_WIDTH/1125.0*383;
    // 本地加载 --- 创建不带标题的图片轮播器
    cycleScrollView = [[SDCycleScrollView alloc ] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, headImageH)];
    cycleScrollView.backgroundColor = BGColor;
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.dotColor = MAINColor; // 自定义分页控件小圆标颜色
    //cycleScrollView.imageURLStringsGroup =@[@"",@""];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"esjph"];
    [_scrollV addSubview:cycleScrollView];
    _scrollVH +=headImageH;

    
    
    CGFloat imgH = BOUND_WIDTH*0.245;
    UIView *pinzhiV = [[UIView alloc] init];
    pinzhiV.backgroundColor = [UIColor whiteColor];
    pinzhiV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, imgH+50);
    _scrollVH +=imgH+50;
    [_scrollV addSubview:pinzhiV];

    
    UILabel *tLabel = [[UILabel alloc] init];
    tLabel.text = @"品质保证";
    //ttleftLabel.numberOfLines = 0;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    tLabel.font = PFR15Font;
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.frame = CGRectMake(0, 0, BOUND_WIDTH, 35);
    [pinzhiV addSubview:tLabel];
    
    UIImageView *biv1 =[[UIImageView alloc] init];
    biv1.image = [UIImage imageNamed:@"esjple"];
    //biv1.backgroundColor = [UIColor greenColor];
    biv1.frame = CGRectMake(0, 35, (BOUND_WIDTH-10)/3.0, imgH);
    [pinzhiV addSubview:biv1];
    
    UIImageView *biv2 =[[UIImageView alloc] init];
    biv2.image = [UIImage imageNamed:@"esjpc"];
    // biv2.backgroundColor = [UIColor greenColor];
    biv2.frame = CGRectMake((BOUND_WIDTH-10)/3.0+5, 35, (BOUND_WIDTH-10)/3.0, imgH);
    [pinzhiV addSubview:biv2];
    
    UIImageView *biv3 =[[UIImageView alloc] init];
    biv3.image = [UIImage imageNamed:@"esjpr"];
    // biv3.backgroundColor = [UIColor greenColor];
    biv3.frame = CGRectMake(((BOUND_WIDTH-10)/3.0+5)*2, 35, (BOUND_WIDTH-10)/3.0, imgH);
    [pinzhiV addSubview:biv3];

    _scrollVH +=5;
    
    
    
    UIView *remaiqianV = [[UIView alloc] init];
    remaiqianV.backgroundColor = [UIColor whiteColor];
//    remaiqianV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, BOUND_WIDTH*3);
//    _scrollVH +=BOUND_WIDTH*3;
    [_scrollV addSubview:remaiqianV];

    UILabel *rmqLabel = [[UILabel alloc] init];
    rmqLabel.text = @"热卖墙";
    //ttleftLabel.numberOfLines = 0;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    rmqLabel.font = PFR15Font;
    rmqLabel.textAlignment = NSTextAlignmentCenter;
    rmqLabel.frame = CGRectMake(0, 0, BOUND_WIDTH, 35);
    [remaiqianV addSubview:rmqLabel];
    


#pragma mark-热门墙-网络请求
    [networking AFNRequest:SELECTADESSENCEHOTFOUR withparameters:nil success:^(NSMutableDictionary *dic) {
        
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            productId1 = response.count>0?(response[0][@"productId"]?response[0][@"productId"]:@""):@"";
            productId2 = response.count>1?(response[1][@"productId"]?response[1][@"productId"]:@""):@"";
            productId3 = response.count>2?(response[2][@"productId"]?response[2][@"productId"]:@""):@"";
            productId4 = response.count>3?(response[3][@"productId"]?response[3][@"productId"]:@""):@"";
            
            
            title1 =  response.count>0?(response[0][@"essTitle"]?response[0][@"essTitle"]:@""):@"";
            title2 =  response.count>1?(response[1][@"essTitle"]?response[1][@"essTitle"]:@""):@"";
            title3 =  response.count>2?(response[2][@"essTitle"]?response[2][@"essTitle"]:@""):@"";
            title4 =  response.count>3?(response[3][@"essTitle"]?response[3][@"essTitle"]:@""):@"";
            
            
            
             NSString *essSizeStr1 = response.count>0?(response[0][@"essSize"]?response[0][@"essSize"]:@""):@"";
            
             NSString *essSizeStr2 = response.count>1?(response[1][@"essSize"]?response[1][@"essSize"]:@""):@"";
            
             NSString *essSizeStr3 = response.count>2?(response[2][@"essSize"]?response[2][@"essSize"]:@""):@"";
            
             NSString *essSizeStr4 = response.count>3?(response[3][@"essSize"]?response[3][@"essSize"]:@""):@"";
            
            
            
            [essSizeStr1 componentsSeparatedByString:@",，,"].count>0?[essSizeStr1 componentsSeparatedByString:@","][0]:@"";
            
             [essSizeStr2 componentsSeparatedByString:@","].count>1?[essSizeStr2 componentsSeparatedByString:@","][1]:@"";
            
             [essSizeStr3 componentsSeparatedByString:@","].count>2?[essSizeStr3 componentsSeparatedByString:@","][2]:@"";
            
            [essSizeStr4 componentsSeparatedByString:@","].count>3?[essSizeStr4 componentsSeparatedByString:@","][3]:@"";
            
//            response.count>0?(response[0][@"essTitle"]?response[0][@"essTitle"]:@""):@"";
//            response.count>0?(response[0][@"proPrice"]?response[0][@"proPrice"]:@""):@"";
//            response.count>0?(response[0][@"essPicture"]?response[0][@"essPicture"]:@""):@"";
            
#pragma mark-第一个
            CGFloat rSmallVWidth = (BOUND_WIDTH-26)/2;
            UIView *rSmallV1 = [[UIView alloc] init];
            rSmallV1.backgroundColor = [UIColor whiteColor];
            //rSmallV1.frame = CGRectMake(8, 35, (BOUND_WIDTH-26)/2, BOUND_WIDTH);
            rSmallV1.layer.borderColor = BGColor.CGColor;
            rSmallV1.layer.borderWidth = 1;
            [remaiqianV addSubview:rSmallV1];
            
            
            UIImageView *riv1 =[[UIImageView alloc] init];
           
            
            [riv1 sd_setImageWithURL:[NSURL URLWithString:response.count>0?(response[0][@"essPicture"]?response[0][@"essPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjpiphone"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            riv1.contentMode = UIViewContentModeScaleAspectFit;
            // biv3.backgroundColor = [UIColor greenColor];
            riv1.frame = CGRectMake((rSmallVWidth-140)/2, 10, 140, 96);
            [rSmallV1 addSubview:riv1];
            
            UIImageView *cutIV =[[UIImageView alloc] init];
            cutIV.backgroundColor = BGColor;
            cutIV.frame = CGRectMake(0, riv1.frame.size.height+riv1.frame.origin.y+10, rSmallVWidth, 1);
            [rSmallV1 addSubview:cutIV];
            UILabel *priceLabel = [[UILabel alloc] init];
            priceLabel.text = [NSString stringWithFormat:@"¥%@",response.count>0?(response[0][@"proPrice"]?response[0][@"proPrice"]:@""):@""];
            priceLabel.textColor = MAINColor;
            //hmleftLabel.backgroundColor = [UIColor redColor];
            priceLabel.font = PFR15Font;
            priceLabel.adjustsFontSizeToFitWidth = YES;
            priceLabel.textAlignment = NSTextAlignmentCenter;
            priceLabel.frame = CGRectMake(0,cutIV.frame.size.height+cutIV.frame.origin.y+5,rSmallVWidth, 25);
            [rSmallV1 addSubview:priceLabel];
            
            UILabel *pNameLabel = [[UILabel alloc] init];
            pNameLabel.text = response.count>0?(response[0][@"essTitle"]?response[0][@"essTitle"]:@""):@"";
            //hmleftLabel.backgroundColor = [UIColor redColor];
            pNameLabel.font = PFR15Font;
            pNameLabel.adjustsFontSizeToFitWidth = YES;
            pNameLabel.textAlignment = NSTextAlignmentCenter;
            pNameLabel.frame = CGRectMake(0,priceLabel.frame.size.height+priceLabel.frame.origin.y,rSmallVWidth, 25);
            [rSmallV1 addSubview:pNameLabel];
            
            
           
            //,，,
           // componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";,"]];
            
            
            UILabel *bqFirst = [[UILabel alloc] init];
            bqFirst.text =   [essSizeStr1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>0?[essSizeStr1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][0]:@"";//@"九成新";//11111
            bqFirst.textColor = [UIColor grayColor];
            bqFirst.layer.borderWidth = 1;
            bqFirst.layer.borderColor = [UIColor grayColor].CGColor;
            bqFirst.font = PFR12Font;
            bqFirst.adjustsFontSizeToFitWidth = YES;
            bqFirst.textAlignment = NSTextAlignmentCenter;
            bqFirst.frame = CGRectMake(BOUND_WIDTH/320.0*5.5,pNameLabel.frame.size.height+pNameLabel.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV1 addSubview:bqFirst];
            
            UILabel *bqSecond = [[UILabel alloc] init];
            bqSecond.text =  [essSizeStr1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>1?[essSizeStr1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][1]:@"";//@"64G";
            bqSecond.textColor = [UIColor grayColor];
            bqSecond.layer.borderWidth = 1;
            bqSecond.layer.borderColor = [UIColor grayColor].CGColor;
            bqSecond.font = PFR12Font;
            bqSecond.adjustsFontSizeToFitWidth = YES;
            bqSecond.textAlignment = NSTextAlignmentCenter;
            bqSecond.frame = CGRectMake(bqFirst.frame.size.width+bqFirst.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel.frame.size.height+pNameLabel.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV1 addSubview:bqSecond];
            
            
            UILabel *bqThree = [[UILabel alloc] init];
            bqThree.text =  [essSizeStr1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>2?[essSizeStr1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][2]:@"";//@"全网通";
            bqThree.textColor = [UIColor grayColor];
            bqThree.layer.borderWidth = 1;
            bqThree.layer.borderColor = [UIColor grayColor].CGColor;
            bqThree.font = PFR12Font;
            bqThree.adjustsFontSizeToFitWidth = YES;
            bqThree.textAlignment = NSTextAlignmentCenter;
            bqThree.frame = CGRectMake(bqSecond.frame.size.width+bqSecond.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel.frame.size.height+pNameLabel.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV1 addSubview:bqThree];
            
            rSmallV1.frame = CGRectMake(8, 35, rSmallVWidth, bqThree.frame.size.height+bqThree.frame.origin.y+12);
            
            
            
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
            [rSmallV1 addGestureRecognizer:tap1];
            rSmallV1.userInteractionEnabled = YES;
            
            
            
            
#pragma mark-第二个
            //CGFloat rSmallVWidth2 = (BOUND_WIDTH-26)/2;
            UIView *rSmallV2 = [[UIView alloc] init];
            rSmallV2.backgroundColor = [UIColor whiteColor];
            //rSmallV1.frame = CGRectMake(8, 35, (BOUND_WIDTH-26)/2, BOUND_WIDTH);
            rSmallV2.layer.borderColor = BGColor.CGColor;
            rSmallV2.layer.borderWidth = 1;
            [remaiqianV addSubview:rSmallV2];
            
            UIImageView *riv2 =[[UIImageView alloc] init];
           
            [riv2 sd_setImageWithURL:[NSURL URLWithString:response.count>1?(response[1][@"essPicture"]?response[1][@"essPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjpiphone"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
           
            riv2.contentMode = UIViewContentModeScaleAspectFit;
            
            // biv3.backgroundColor = [UIColor greenColor];
            riv2.frame = CGRectMake((rSmallVWidth-140)/2, 10, 140, 96);
            [rSmallV2 addSubview:riv2];
            
            UIImageView *cutIV2 =[[UIImageView alloc] init];
            cutIV2.backgroundColor = BGColor;
            cutIV2.frame = CGRectMake(0, riv2.frame.size.height+riv2.frame.origin.y+10, rSmallVWidth, 1);
            [rSmallV2 addSubview:cutIV2];
            
            UILabel *priceLabel2 = [[UILabel alloc] init];
            
            priceLabel2.text = [NSString stringWithFormat:@"¥%@",response.count>1?(response[1][@"proPrice"]?response[1][@"proPrice"]:@""):@""];
            priceLabel2.textColor = MAINColor;
            //hmleftLabel.backgroundColor = [UIColor redColor];
            priceLabel2.font = PFR15Font;
            priceLabel2.adjustsFontSizeToFitWidth = YES;
            priceLabel2.textAlignment = NSTextAlignmentCenter;
            priceLabel2.frame = CGRectMake(0,cutIV2.frame.size.height+cutIV2.frame.origin.y+5,rSmallVWidth, 25);
            [rSmallV2 addSubview:priceLabel2];
            
            UILabel *pNameLabel2 = [[UILabel alloc] init];
            pNameLabel2.text = response.count>1?(response[1][@"essTitle"]?response[1][@"essTitle"]:@""):@"";
            //hmleftLabel.backgroundColor = [UIColor redColor];
            pNameLabel2.font = PFR15Font;
            pNameLabel2.adjustsFontSizeToFitWidth = YES;
            pNameLabel2.textAlignment = NSTextAlignmentCenter;
            pNameLabel2.frame = CGRectMake(0,priceLabel2.frame.size.height+priceLabel2.frame.origin.y,rSmallVWidth, 25);
            [rSmallV2 addSubview:pNameLabel2];
            
            
            UILabel *bqFirst2 = [[UILabel alloc] init];
            bqFirst2.text =  [essSizeStr2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>0?[essSizeStr2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][0]:@"";//@"九2新";
            bqFirst2.textColor = [UIColor grayColor];
            bqFirst2.layer.borderWidth = 1;
            bqFirst2.layer.borderColor = [UIColor grayColor].CGColor;
            bqFirst2.font = PFR12Font;
            bqFirst2.adjustsFontSizeToFitWidth = YES;
            bqFirst2.textAlignment = NSTextAlignmentCenter;
            bqFirst2.frame = CGRectMake(BOUND_WIDTH/320.0*5.5,pNameLabel2.frame.size.height+pNameLabel2.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV2 addSubview:bqFirst2];
            
            UILabel *bqSecond2 = [[UILabel alloc] init];
            bqSecond2.text =  [essSizeStr2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>1?[essSizeStr2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][1]:@"";//@"62G";
            bqSecond2.textColor = [UIColor grayColor];
            bqSecond2.layer.borderWidth = 1;
            bqSecond2.layer.borderColor = [UIColor grayColor].CGColor;
            bqSecond2.font = PFR12Font;
            bqSecond2.adjustsFontSizeToFitWidth = YES;
            bqSecond2.textAlignment = NSTextAlignmentCenter;
            bqSecond2.frame = CGRectMake(bqFirst.frame.size.width+bqFirst.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel2.frame.size.height+pNameLabel2.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV2 addSubview:bqSecond2];
            
            
            UILabel *bqThree2 = [[UILabel alloc] init];
            bqThree2.text =  [essSizeStr2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>2?[essSizeStr2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][2]:@"";//@"全网通2";
            bqThree2.textColor = [UIColor grayColor];
            bqThree2.layer.borderWidth = 1;
            bqThree2.layer.borderColor = [UIColor grayColor].CGColor;
            bqThree2.font = PFR12Font;
            bqThree2.adjustsFontSizeToFitWidth = YES;
            bqThree2.textAlignment = NSTextAlignmentCenter;
            bqThree2.frame = CGRectMake(bqSecond2.frame.size.width+bqSecond2.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel2.frame.size.height+pNameLabel2.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV2 addSubview:bqThree2];
            
            rSmallV2.frame = CGRectMake(8+10+rSmallVWidth, 35, rSmallVWidth, bqThree2.frame.size.height+bqThree2.frame.origin.y+12);
            
            
            
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
            [rSmallV2 addGestureRecognizer:tap2];
            rSmallV2.userInteractionEnabled = YES;
            
            
#pragma mark-第三个
            //CGFloat rSmallVWidth2 = (BOUND_WIDTH-26)/2;
            UIView *rSmallV3 = [[UIView alloc] init];
            rSmallV3.backgroundColor = [UIColor whiteColor];
            //rSmallV1.frame = CGRectMake(8, 35, (BOUND_WIDTH-26)/2, BOUND_WIDTH);
            rSmallV3.layer.borderColor = BGColor.CGColor;
            rSmallV3.layer.borderWidth = 1;
            [remaiqianV addSubview:rSmallV3];
            
            UIImageView *riv3 =[[UIImageView alloc] init];
           [riv3 sd_setImageWithURL:[NSURL URLWithString:response.count>2?(response[2][@"essPicture"]?response[2][@"essPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjpiphone"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            riv3.contentMode = UIViewContentModeScaleAspectFit;
            
            // biv3.backgroundColor = [UIColor greenColor];
            riv3.frame = CGRectMake((rSmallVWidth-140)/2, 10, 140, 96);
            [rSmallV3 addSubview:riv3];
            
            UIImageView *cutIV3 =[[UIImageView alloc] init];
            cutIV3.backgroundColor = BGColor;
            cutIV3.frame = CGRectMake(0, riv3.frame.size.height+riv3.frame.origin.y+10, rSmallVWidth, 1);
            [rSmallV3 addSubview:cutIV3];
            
            UILabel *priceLabel3 = [[UILabel alloc] init];
            priceLabel3.text = [NSString stringWithFormat:@"¥%@",response.count>2?(response[2][@"proPrice"]?response[2][@"proPrice"]:@""):@""];
            
            priceLabel3.textColor = MAINColor;
            //hmleftLabel.backgroundColor = [UIColor redColor];
            priceLabel3.font = PFR15Font;
            priceLabel3.adjustsFontSizeToFitWidth = YES;
            priceLabel3.textAlignment = NSTextAlignmentCenter;
            priceLabel3.frame = CGRectMake(0,cutIV3.frame.size.height+cutIV3.frame.origin.y+5,rSmallVWidth, 25);
            [rSmallV3 addSubview:priceLabel3];
            
            UILabel *pNameLabel3 = [[UILabel alloc] init];
            pNameLabel3.text = response.count>2?(response[2][@"essTitle"]?response[2][@"essTitle"]:@""):@"";
            pNameLabel3.font = PFR15Font;
            pNameLabel3.adjustsFontSizeToFitWidth = YES;
            pNameLabel3.textAlignment = NSTextAlignmentCenter;
            pNameLabel3.frame = CGRectMake(0,priceLabel3.frame.size.height+priceLabel3.frame.origin.y,rSmallVWidth, 25);
            [rSmallV3 addSubview:pNameLabel3];
            
            
            UILabel *bqFirst3 = [[UILabel alloc] init];
            bqFirst3.text =  [essSizeStr3 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>0?[essSizeStr3 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][0]:@"";//@"九3新";
            bqFirst3.textColor = [UIColor grayColor];
            bqFirst3.layer.borderWidth = 1;
            bqFirst3.layer.borderColor = [UIColor grayColor].CGColor;
            bqFirst3.font = PFR12Font;
            bqFirst3.adjustsFontSizeToFitWidth = YES;
            bqFirst3.textAlignment = NSTextAlignmentCenter;
            bqFirst3.frame = CGRectMake(BOUND_WIDTH/320.0*5.5,pNameLabel3.frame.size.height+pNameLabel3.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV3 addSubview:bqFirst3];
            
            UILabel *bqSecond3 = [[UILabel alloc] init];
            bqSecond3.text =  [essSizeStr3 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>1?[essSizeStr3 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][1]:@"";//@"64G3";
            bqSecond3.textColor = [UIColor grayColor];
            bqSecond3.layer.borderWidth = 1;
            bqSecond3.layer.borderColor = [UIColor grayColor].CGColor;
            bqSecond3.font = PFR12Font;
            bqSecond3.adjustsFontSizeToFitWidth = YES;
            bqSecond3.textAlignment = NSTextAlignmentCenter;
            bqSecond3.frame = CGRectMake(bqFirst.frame.size.width+bqFirst.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel2.frame.size.height+pNameLabel3.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV3 addSubview:bqSecond3];
            
            
            UILabel *bqThree3 = [[UILabel alloc] init];
            bqThree3.text =  [essSizeStr3 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>2?[essSizeStr3 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][2]:@"";//@"全网通3";
            bqThree3.textColor = [UIColor grayColor];
            bqThree3.layer.borderWidth = 1;
            bqThree3.layer.borderColor = [UIColor grayColor].CGColor;
            bqThree3.font = PFR12Font;
            bqThree3.adjustsFontSizeToFitWidth = YES;
            bqThree3.textAlignment = NSTextAlignmentCenter;
            bqThree3.frame = CGRectMake(bqSecond3.frame.size.width+bqSecond3.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel3.frame.size.height+pNameLabel3.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV3 addSubview:bqThree3];
            
            rSmallV3.frame = CGRectMake(8, 35 +5  +bqThree3.frame.size.height+bqThree3.frame.origin.y+12, rSmallVWidth, bqThree3.frame.size.height+bqThree3.frame.origin.y+12);
            
            
            UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action)];
            [rSmallV3 addGestureRecognizer:tap3];
            rSmallV3.userInteractionEnabled = YES;
            
#pragma mark-第四个
            //CGFloat rSmallVWidth2 = (BOUND_WIDTH-26)/2;
            UIView *rSmallV4 = [[UIView alloc] init];
            rSmallV4.backgroundColor = [UIColor whiteColor];
            //rSmallV1.frame = CGRectMake(8, 35, (BOUND_WIDTH-26)/2, BOUND_WIDTH);
            rSmallV4.layer.borderColor = BGColor.CGColor;
            rSmallV4.layer.borderWidth = 1;
            [remaiqianV addSubview:rSmallV4];
            
            UIImageView *riv4 =[[UIImageView alloc] init];
            [riv4 sd_setImageWithURL:[NSURL URLWithString:response.count>3?(response[3][@"essPicture"]?response[3][@"essPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjpiphone"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            riv4.contentMode = UIViewContentModeScaleAspectFit;
            
            // biv3.backgroundColor = [UIColor greenColor];
            riv4.frame = CGRectMake((rSmallVWidth-140)/2, 10, 140, 96);
            [rSmallV4 addSubview:riv4];
            
            UIImageView *cutIV4 =[[UIImageView alloc] init];
            cutIV4.backgroundColor = BGColor;
            cutIV4.frame = CGRectMake(0, riv4.frame.size.height+riv4.frame.origin.y+10, rSmallVWidth, 1);
            [rSmallV4 addSubview:cutIV4];
            
            UILabel *priceLabel4 = [[UILabel alloc] init];
            priceLabel4.text = [NSString stringWithFormat:@"¥%@",response.count>3?(response[3][@"proPrice"]?response[3][@"proPrice"]:@""):@""];
            
            
            priceLabel4.textColor = MAINColor;
            //hmleftLabel.backgroundColor = [UIColor redColor];
            priceLabel4.font = PFR15Font;
            priceLabel4.adjustsFontSizeToFitWidth = YES;
            priceLabel4.textAlignment = NSTextAlignmentCenter;
            priceLabel4.frame = CGRectMake(0,cutIV4.frame.size.height+cutIV4.frame.origin.y+5,rSmallVWidth, 25);
            [rSmallV4 addSubview:priceLabel4];
            
            UILabel *pNameLabel4 = [[UILabel alloc] init];
            pNameLabel4.text = response.count>3?(response[3][@"essTitle"]?response[3][@"essTitle"]:@""):@"";
            //hmleftLabel.backgroundColor = [UIColor redColor];
            pNameLabel4.font = PFR15Font;
            pNameLabel4.adjustsFontSizeToFitWidth = YES;
            pNameLabel4.textAlignment = NSTextAlignmentCenter;
            pNameLabel4.frame = CGRectMake(0,priceLabel4.frame.size.height+priceLabel4.frame.origin.y,rSmallVWidth, 25);
            [rSmallV4 addSubview:pNameLabel4];
            
            
            UILabel *bqFirst4 = [[UILabel alloc] init];
            bqFirst4.text =  [essSizeStr4 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>0?[essSizeStr4 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][0]:@"";//@"九4新";
            bqFirst4.textColor = [UIColor grayColor];
            bqFirst4.layer.borderWidth = 1;
            bqFirst4.layer.borderColor = [UIColor grayColor].CGColor;
            bqFirst4.font = PFR12Font;
            bqFirst4.adjustsFontSizeToFitWidth = YES;
            bqFirst4.textAlignment = NSTextAlignmentCenter;
            bqFirst4.frame = CGRectMake(BOUND_WIDTH/320.0*5.5,pNameLabel4.frame.size.height+pNameLabel4.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV4 addSubview:bqFirst4];
            
            UILabel *bqSecond4 = [[UILabel alloc] init];
            bqSecond4.text =  [essSizeStr4 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>1?[essSizeStr4 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][1]:@"";//@"64G4";
            bqSecond4.textColor = [UIColor grayColor];
            bqSecond4.layer.borderWidth = 1;
            bqSecond4.layer.borderColor = [UIColor grayColor].CGColor;
            bqSecond4.font = PFR12Font;
            bqSecond4.adjustsFontSizeToFitWidth = YES;
            bqSecond4.textAlignment = NSTextAlignmentCenter;
            bqSecond4.frame = CGRectMake(bqFirst.frame.size.width+bqFirst.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel4.frame.size.height+pNameLabel4.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV4 addSubview:bqSecond4];
            
            
            UILabel *bqThree4 = [[UILabel alloc] init];
            bqThree4.text = [essSizeStr4 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]].count>2?[essSizeStr4 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，,"]][2]:@"";// @"全网通4";
            bqThree4.textColor = [UIColor grayColor];
            bqThree4.layer.borderWidth = 1;
            bqThree4.layer.borderColor = [UIColor grayColor].CGColor;
            bqThree4.font = PFR12Font;
            bqThree4.adjustsFontSizeToFitWidth = YES;
            bqThree4.textAlignment = NSTextAlignmentCenter;
            bqThree4.frame = CGRectMake(bqSecond4.frame.size.width+bqSecond4.frame.origin.x+BOUND_WIDTH/320.0*8,pNameLabel4.frame.size.height+pNameLabel4.frame.origin.y+5,BOUND_WIDTH/320.0*40, BOUND_WIDTH/320.0*18);
            [rSmallV4 addSubview:bqThree4];
            
            rSmallV4.frame = CGRectMake(8+10+rSmallVWidth, 35 +5  +bqThree4.frame.size.height+bqThree4.frame.origin.y+12, rSmallVWidth, bqThree4.frame.size.height+bqThree4.frame.origin.y+12);
            
            UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4Action)];
            [rSmallV4 addGestureRecognizer:tap4];
            rSmallV4.userInteractionEnabled = YES;
            
            
            

        }

        
        
        
    } error:nil HUDAddView:self.view];
    
    
    

    remaiqianV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, (35+106+11+60+BOUND_WIDTH/320.0*18+12)*2);
     _scrollVH +=(35+106+11+60+BOUND_WIDTH/320.0*18+12)*2;


    
    
    
    UIImageView *bottomIV =[[UIImageView alloc] init];
    bottomIV.image = [UIImage imageNamed:@"esjpbigimg"];
    // biv3.backgroundColor = [UIColor greenColor];
    bottomIV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, BOUND_WIDTH/750*280);
    [_scrollV addSubview:bottomIV];
    _scrollVH +=BOUND_WIDTH/750*280 +5;
    
    
    
    
    
    
    
    
    
    CGFloat imgeH = BOUND_WIDTH/320.0*60;
    UIView *ppV = [[UIView alloc] init];
    ppV.backgroundColor = [UIColor whiteColor];
    ppV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, imgeH*2+35+20);
    _scrollVH +=imgeH*2+35+20;
    [_scrollV addSubview:ppV];
    
    UILabel *ppLabel = [[UILabel alloc] init];
    ppLabel.text = @"品牌墙";
    //ttleftLabel.numberOfLines = 0;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    ppLabel.font = PFR15Font;
    ppLabel.textAlignment = NSTextAlignmentCenter;
    ppLabel.frame = CGRectMake(0, 0, BOUND_WIDTH, 35);
    [ppV addSubview:ppLabel];
    
    
#pragma mark-品牌墙网络请求
    
    [networking AFNRequest:GETBRANDS withparameters:nil success:^(NSMutableDictionary *dic) {
        
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            

            
            mingCheng1 =  response.count>0?(response[0][@"brTitle"]?response[0][@"brTitle"]:@""):@"";
            mingCheng2 =  response.count>1?(response[1][@"brTitle"]?response[1][@"brTitle"]:@""):@"";
            mingCheng3 =  response.count>2?(response[2][@"brTitle"]?response[2][@"brTitle"]:@""):@"";
            mingCheng4 =  response.count>3?(response[3][@"brTitle"]?response[3][@"brTitle"]:@""):@"";
            mingCheng5 =  response.count>4?(response[4][@"brTitle"]?response[4][@"brTitle"]:@""):@"";
            mingCheng6 =  response.count>5?(response[5][@"brTitle"]?response[5][@"brTitle"]:@""):@"";
            
            

            
            
            
            UIImageView *piv1 =[[UIImageView alloc] init];
            
            [piv1 sd_setImageWithURL:[NSURL URLWithString:response.count>0?(response[0][@"brPicture"]?response[0][@"brPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp1"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            
            piv1.tag = 111;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPivImage:)];
            [piv1 addGestureRecognizer:tap];
            piv1.userInteractionEnabled = YES;

            
            piv1.layer.borderColor = BGColor.CGColor;
            piv1.layer.masksToBounds = YES;
            piv1.layer.borderWidth = 1;
            piv1.frame = CGRectMake(8, 35, BOUND_WIDTH/320.0*98, imgeH);
            [ppV addSubview:piv1];
            
            UIImageView *piv2 =[[UIImageView alloc] init];
             [piv2 sd_setImageWithURL:[NSURL URLWithString:response.count>1?(response[1][@"brPicture"]?response[1][@"brPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            
            piv2.tag = 222;
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPivImage:)];
            [piv2 addGestureRecognizer:tap2];
            piv2.userInteractionEnabled = YES;
            
            
            
            piv2.layer.borderColor = BGColor.CGColor;
            piv2.layer.masksToBounds = YES;
            piv2.layer.borderWidth = 1;
            piv2.frame = CGRectMake(8+5+BOUND_WIDTH/320.0*98, 35 , BOUND_WIDTH/320.0*98, imgeH);
            [ppV addSubview:piv2];
            
            UIImageView *piv3 =[[UIImageView alloc] init];
             [piv3 sd_setImageWithURL:[NSURL URLWithString:response.count>2?(response[2][@"brPicture"]?response[2][@"brPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp3"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            
            
            piv3.tag = 333;
            UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPivImage:)];
            [piv3 addGestureRecognizer:tap3];
            piv3.userInteractionEnabled = YES;

            
            piv3.layer.borderColor = BGColor.CGColor;
            piv3.layer.masksToBounds = YES;
            piv3.layer.borderWidth = 1;
            piv3.frame = CGRectMake(8+10+BOUND_WIDTH/320.0*98*2, 35 , BOUND_WIDTH/320.0*98, imgeH);
            [ppV addSubview:piv3];
            
            
            UIImageView *piv4 =[[UIImageView alloc] init];
             [piv4 sd_setImageWithURL:[NSURL URLWithString:response.count>3?(response[3][@"brPicture"]?response[3][@"brPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp4"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            piv4.tag = 444;
            UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPivImage:)];
            [piv4 addGestureRecognizer:tap4];
            piv4.userInteractionEnabled = YES;

            
            
            
            piv4.layer.borderColor = BGColor.CGColor;
            piv4.layer.masksToBounds = YES;
            piv4.layer.borderWidth = 1;
            piv4.frame = CGRectMake(8, 35+BOUND_WIDTH/320.0*60+5, BOUND_WIDTH/320.0*98, imgeH);
            [ppV addSubview:piv4];
            
            UIImageView *piv5 =[[UIImageView alloc] init];
             [piv5 sd_setImageWithURL:[NSURL URLWithString:response.count>4?(response[4][@"brPicture"]?response[4][@"brPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp5"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            piv5.tag = 555;
            UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPivImage:)];
            [piv5 addGestureRecognizer:tap5];
            piv5.userInteractionEnabled = YES;

            
            
            piv5.layer.borderColor = BGColor.CGColor;
            piv5.layer.masksToBounds = YES;
            piv5.layer.borderWidth = 1;
            piv5.frame = CGRectMake(8+5+BOUND_WIDTH/320.0*98, 35+BOUND_WIDTH/320.0*60+5, BOUND_WIDTH/320.0*98, imgeH);
            [ppV addSubview:piv5];
            
            
            UIImageView *piv6 =[[UIImageView alloc] init];
             [piv6 sd_setImageWithURL:[NSURL URLWithString:response.count>5?(response[5][@"brPicture"]?response[5][@"brPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp6"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            
            piv6.tag = 666;
            UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPivImage:)];
            [piv6 addGestureRecognizer:tap6];
            piv6.userInteractionEnabled = YES;

            
            
            piv6.layer.borderColor = BGColor.CGColor;
            piv6.layer.masksToBounds = YES;
            piv6.layer.borderWidth = 1;
            piv6.frame = CGRectMake(8+10+BOUND_WIDTH/320.0*98*2, 35+BOUND_WIDTH/320.0*60+5, BOUND_WIDTH/320.0*98, imgeH);
            [ppV addSubview:piv6];
            
            
        }
        
    } error:nil HUDAddView:self.view];

    
    
    
    _scrollVH +=20;
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);

}
-(void)clickPivImage:(UITapGestureRecognizer *)tap{
     UIImageView *imgeV = (UIImageView *)tap.view;
    if (imgeV.tag == 111) {
        
        PinPaiLIst *pvc = [[PinPaiLIst alloc] init];
        pvc.mingcheng = mingCheng1;
        [self.navigationController pushViewController:pvc animated:YES];
        
        
        NSLog(@"mingCheng1:%@",mingCheng1);
        
    }else if (imgeV.tag == 222){
        PinPaiLIst *pvc = [[PinPaiLIst alloc] init];
        pvc.mingcheng = mingCheng2;
        [self.navigationController pushViewController:pvc animated:YES];
 NSLog(@"mingCheng1:%@",mingCheng1);
    }else if (imgeV.tag == 333){
        PinPaiLIst *pvc = [[PinPaiLIst alloc] init];
        pvc.mingcheng = mingCheng3;
        [self.navigationController pushViewController:pvc animated:YES];
 NSLog(@"mingCheng1:%@",mingCheng1);
    }else if (imgeV.tag == 444){
        PinPaiLIst *pvc = [[PinPaiLIst alloc] init];
        pvc.mingcheng = mingCheng4;
        [self.navigationController pushViewController:pvc animated:YES];
 NSLog(@"mingCheng1:%@",mingCheng1);
    }else if (imgeV.tag == 555){
        PinPaiLIst *pvc = [[PinPaiLIst alloc] init];
        pvc.mingcheng = mingCheng5;
        [self.navigationController pushViewController:pvc animated:YES];
 NSLog(@"mingCheng1:%@",mingCheng1);
    }else if (imgeV.tag == 666){
        PinPaiLIst *pvc = [[PinPaiLIst alloc] init];
        pvc.mingcheng = mingCheng6;
        [self.navigationController pushViewController:pvc animated:YES];
 NSLog(@"mingCheng1:%@",mingCheng1);
    }
    
}
#pragma mark-四个按钮
-(void)tap1Action{
    NSLog(@"tap1Action:%@",productId1);
    
    
    
    
    UsedGoodsDetailVC *uv = [[UsedGoodsDetailVC alloc] init];
    uv.productId = productId1;
    uv.title = title1;
    [self.navigationController pushViewController:uv animated:YES];
}
-(void)tap2Action{
    NSLog(@"tap22Action:%@",productId2);
    UsedGoodsDetailVC *uv = [[UsedGoodsDetailVC alloc] init];
    uv.productId = productId2;
    
     uv.title = title2;
       [self.navigationController pushViewController:uv animated:YES];
}
-(void)tap3Action{
    NSLog(@"tap333Action:%@",productId3);
    UsedGoodsDetailVC *uv = [[UsedGoodsDetailVC alloc] init];
    uv.productId = productId3;
     uv.title = title3;
      [self.navigationController pushViewController:uv animated:YES];
}
-(void)tap4Action{
    NSLog(@"tap4444Action:%@",productId4);
    UsedGoodsDetailVC *uv = [[UsedGoodsDetailVC alloc] init];
    
     uv.title = title4;
    uv.productId = productId4;
  
    [self.navigationController pushViewController:uv animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -广告接口
- (void)ADDCarousel
{
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/1",SELECTCARAROUSE] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            scrollPhotoList = [[NSMutableArray alloc] init];
            for (NSDictionary *temp in response) {
                NSString *str = temp[@"caPicture"]?temp[@"caPicture"]:@"";
                NSString *urlStr = [str excisionForFistString];
                urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                
                [arr addObject:[@"" stringByAppendingString:urlStr]];
                
                [scrollPhotoList addObject:temp[@"caPicLink"]?temp[@"caPicLink"]:@""];
            }
            
            cycleScrollView.imageURLStringsGroup =arr;
        }
    } error:nil];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    if (scrollPhotoList.count>0) {
//        ZSWViewController *ZSWWebView = [[ZSWViewController alloc] init];
//        ZSWWebView.title = @"链旧";
//        ZSWWebView.url= scrollPhotoList[index];
//        ZSWWebView.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ZSWWebView animated:YES];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
