//
//  HotActivityTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/6.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "HotActivityTableViewCell.h"

@implementation HotActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)fillCellWithModel:(HotActivityModel*)model{
    
    self.hotTitleL.text = model.actTitle?model.actTitle:@"";
    [self.hotIV sd_setImageWithURL:[NSURL URLWithString:model.actPicture?model.actPicture:@""] placeholderImage:nil];
    
    
    NSString *starTime;NSString *endTime;
    if (model.actStartTime.length > 10) {
        starTime = [model.actStartTime substringToIndex:10];
    }else{
        starTime = model.actStartTime?model.actStartTime:@"";
    }
    
    if (model.actEndTime.length > 10) {
        endTime = [model.actEndTime substringToIndex:10];
    }else{
        endTime = model.actEndTime?model.actEndTime:@"";
    }

    
    
    
 
    
    
    
    self.hotTimeL.text = [NSString stringWithFormat:@"活动时间:%@至%@",starTime,endTime];
    
    
}

@end
