//
//  CQMarqueeView.m
//  CQMarqueeView
//
//  Created by 蔡强 on 2017/8/22.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "CQMarqueeView.h"
#import "UIColor+Util.h"
#import "UIView+frameAdjust.h"

@implementation CQMarqueeView{
    UILabel *_marqueeLabel;
    /** 控制跑马灯的timer */
    NSTimer *_timer;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    //------- 左边的喇叭 -------//
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 9, 16, 12)];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"Headlines"];
    
    //------- 右边的关闭按钮 -------//
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 33, 0, 30, 30)];
    [self addSubview:closeButton];
    //[closeButton setImage:[UIImage imageNamed:@"close-marquee"] forState:UIControlStateNormal];
    [closeButton setImageEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];
#pragma mark-这里把关闭按钮给注释了
   // [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //------- marquee View -------//
    
    // 背景
    UIView *marqueeBgView = [[UIView alloc] initWithFrame:CGRectMake(41, 0, self.width - 41 - 38, self.height)];
    [self addSubview:marqueeBgView];
    marqueeBgView.clipsToBounds = YES;
    marqueeBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marqueeViewClicked)];
    [marqueeBgView addGestureRecognizer:tap];
    
    // marquee label
    _marqueeLabel = [[UILabel alloc] initWithFrame:marqueeBgView.bounds];
    [marqueeBgView addSubview:_marqueeLabel];
    _marqueeLabel.textColor = [UIColor darkGrayColor];
    _marqueeLabel.font = [UIFont systemFontOfSize:13];
}
#pragma mark-视图的点击事件
-(void)marqueeViewClicked{
    if ([self.delegate respondsToSelector:@selector(marqueeView:)]) {
        [self.delegate marqueeView:self];
    }
    
    
    //    if ([self.delegate respondsToSelector:@selector(marqueeView:closeButtonDidClick:)]) {
    //        [self.delegate marqueeView:self closeButtonDidClick:sender];
    //    }

}



#pragma mark - 关闭按钮点击
/** 关闭按钮点击 */
//- (void)closeButtonClicked:(UIButton *)sender {
//    if (_timer) {
//        [_timer invalidate];
//        _timer = nil;
//    }
//    
//    if ([self.delegate respondsToSelector:@selector(marqueeView:closeButtonDidClick:)]) {
//        [self.delegate marqueeView:self closeButtonDidClick:sender];
//    }
//}

#pragma mark - 赋值跑马灯文字
/** 赋值跑马灯文字 */
- (void)setMarqueeText:(NSString *)marqueeText {
    _marqueeText = marqueeText;
    
    _marqueeLabel.text = _marqueeText;
    [_marqueeLabel sizeToFit];
    _marqueeLabel.centerY = self.height / 2;
 
#pragma mark-把下面代码注释掉,就可以停止跑了
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
//    // 从最右边开始跑
//    _marqueeLabel.x = self.width - 41 - 38;
    // 从最左边开始跑
    _marqueeLabel.x =  0;
    
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshMarqueeLabelFrame) userInfo:nil repeats:YES];//0.01
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/** 刷新跑马灯label的位置 */
- (void)refreshMarqueeLabelFrame {
    _marqueeLabel.x -= 0.3;//0.3
    if (_marqueeLabel.maxX <= 0) {
        _marqueeLabel.x = self.width - 41 - 38;
    }
}

@end
