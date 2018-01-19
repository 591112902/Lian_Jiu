//
//  CQMarqueeView.h
//  CQMarqueeView
//
//  Created by 蔡强 on 2017/8/22.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CQMarqueeView;

@protocol CQMarqueeViewDelegate <NSObject>

/** 跑马灯view上的关闭按钮点击时回调 */
- (void)marqueeView:(CQMarqueeView *)marqueeView;

@end

@interface CQMarqueeView : UIView

/** 跑马灯的文字 */
@property (nonatomic, copy) NSString *marqueeText;

@property (nonatomic, weak) id <CQMarqueeViewDelegate> delegate;

@end
