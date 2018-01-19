
//  ZJLonginView.h
//  jianzhu
//
//  Created by iOS开发 on 15/11/11.
//  Copyright © 2015年 wanglinlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsedGDheadView : UIView<UIScrollViewDelegate>

//@property (strong, nonatomic) IBOutlet UIScrollView *scrollV;
//
//@property (strong, nonatomic) IBOutlet UIView *priceAreaView;
//
//
//@property (strong, nonatomic) IBOutlet UIView *skuAreaView;


@property (strong, nonatomic)  UILabel *nameL;
@property (strong, nonatomic)  UILabel *nameDetailL;
@property (strong, nonatomic)  UILabel *priceL;
@property (strong, nonatomic)  UILabel *sellL;

@property (strong, nonatomic)  UILabel *skuL;

@property (strong, nonatomic) UIView *skuView;


//@property (strong, nonatomic) NSString *headPhotosUrl;

//@property (strong, nonatomic) NSString *pID;
@end
