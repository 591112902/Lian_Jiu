//
//  CollectionHeader.m
//  RGCategoryView
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 com.roroge. All rights reserved.
//

#import "CollectionHeader.h"

#import "UIImageView+WebCache.h"

@implementation CollectionHeader
{
     NSMutableArray *headPhotosUrl;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.chLabel = [[UILabel alloc] init];
        self.chLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/375.0*292, [UIScreen mainScreen].bounds.size.width/375.0*30);
       // self.chLabel.text = @" 家电回收暂时仅限深圳市和北京市";
        
        self.chLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:self.chLabel];
        
        
        
         CGFloat headImageH = [UIScreen mainScreen].bounds.size.width/375.0*129;
          self.chImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/375.0*292, headImageH)];
        
         [self addSubview:self.chImageView];
        
        
        
        
//        //头部scrollView--------------------------------------------------------------
//        
//      
//        CGFloat headImageH = [UIScreen mainScreen].bounds.size.width/375.0*129;
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width/375.0*30, [UIScreen mainScreen].bounds.size.width/375.0*292, [UIScreen mainScreen].bounds.size.width/375.0*129)];
//        //headSCView.delegate = self;
//        _scrollView.tag = 199999;
//        for (int i = 0; i<headPhotosUrl.count; i++) {
//            UIImageView *headImag = [[UIImageView alloc] initWithFrame:CGRectMake(i*([UIScreen mainScreen].bounds.size.width/375.0*292), 0, [UIScreen mainScreen].bounds.size.width/375.0*292, headImageH)];
//            NSString *urlStr = [@"" stringByAppendingString:headPhotosUrl[i]?headPhotosUrl[i]:@""];
//            urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//            [headImag sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"222"]];
//        
//            [_scrollView addSubview:headImag];
//            headImag = nil;
//        }
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.pagingEnabled = YES;
//        _scrollView.contentSize = CGSizeMake(headPhotosUrl.count*([UIScreen mainScreen].bounds.size.width/375.0*292), headImageH);
//        [self addSubview:_scrollView];
//        _scrollView = nil;
//        
//        CGFloat pageItemW = 15;
//        UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/375.0*292-pageItemW*headPhotosUrl.count)/2, headImageH-25, pageItemW*headPhotosUrl.count, 10)];
//        page.tag = 44;
//        page.numberOfPages = headPhotosUrl.count;
//        page.currentPageIndicatorTintColor = MAINColor;
//        [self addSubview:page];
        
        
        
        
        
        
    }
    return self;


}




- (void)awakeFromNib {
    [super awakeFromNib];
 

    
    
    
}

@end
