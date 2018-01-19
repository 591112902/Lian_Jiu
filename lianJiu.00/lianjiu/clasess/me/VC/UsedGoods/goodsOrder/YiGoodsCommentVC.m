//
//  GoodsCommentVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "YiGoodsCommentVC.h"
#import "UITextView+YLTextView.h"
@interface YiGoodsCommentVC ()<UITextViewDelegate>

@end

@implementation YiGoodsCommentVC

#pragma mark - uitextviewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@" "]&&textView.text.length<1) {
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]){
        return YES;
    }
    
    NSString *toString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (toString.length <= 200) {//(\\+|\\-)?
    }
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
   self.title = @"优品评论";
   
    
    self.titleL.text = [NSString stringWithFormat:@"产品:%@",_nameS];
    
    [networking AFNRequestNotCode:[NSString stringWithFormat:@"%@/%@",EXCELLENTGETONECOMMENT,_ordersId?_ordersId:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *lianjiuData = dic[@"lianjiuData"];
            
           
            self.contentTV.text = lianjiuData[@"commentDetails"]?lianjiuData[@"commentDetails"]:@"";
           
        }
        
    } error:nil HUDAddView:nil];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
