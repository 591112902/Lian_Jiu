//
//  PingJiaTableViewCell.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/26.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "PingJiaTableViewCell.h"

@implementation PingJiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   [super awakeFromNib];
}


-(void)fillCellWithModel:(PingJiaModel*)model
{
    
    //self.usernameL.text = model.username;
    self.timeL.text = model.commentCreated;
    self.detailL.text = model.commentDetails;
    
    
    
    
    if (model.username.length>9) {
        
        NSString *tel = [model.username stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.usernameL.text = [NSString stringWithFormat:@"%@",tel];
    }else{
        
        self.usernameL.text =  model.username;
    }

    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
