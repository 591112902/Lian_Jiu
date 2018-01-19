//
//  IWBadgeButton.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "PRJBadgeButton.h"

@implementation PRJBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"tabbg"] forState:UIControlStateSelected];
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
//    _badgeValue = badgeValue;
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize;
            if (isIOS7) {
                NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName,nil];
                badgeSize =[badgeValue boundingRectWithSize:CGSizeMake(10000, badgeH) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
            }else
            {
                
               // badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            }
        
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
