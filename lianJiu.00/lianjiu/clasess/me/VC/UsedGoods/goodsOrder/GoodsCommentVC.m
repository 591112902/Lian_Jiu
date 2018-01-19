//
//  GoodsCommentVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "GoodsCommentVC.h"
#import "UITextView+YLTextView.h"
@interface GoodsCommentVC ()<UITextViewDelegate>

@end

@implementation GoodsCommentVC

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
    self.contentTV.placeholder = @"说说您对这款产品的评论，为小伙伴们提供建议。";
    self.contentTV.limitLength = @200;
    self.titleL.text = [NSString stringWithFormat:@"产品:%@",_nameS];
    
//    [networking AFNRequestNotCode:[NSString stringWithFormat:@"%@/%@",EXCELLENTGETONECOMMENT,_ordersId?_ordersId:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
//        
//        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *lianjiuData = dic[@"lianjiuData"];
//            
//           
//            self.contentTV.text = lianjiuData[@"commentDetails"]?lianjiuData[@"commentDetails"]:@"";
//            self.commentBtn.hidden = YES;
//        }
//        
//    } error:nil HUDAddView:nil];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commentAction:(id)sender {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [def objectForKey:@"userId"];
    if (_contentTV.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写评论内容" toView:self.view];
        return;
    }
    
    [networking AFNPOST:SUBMITCOMMENT withparameters:@{@"userId":uuid,@"commentDetails":_contentTV.text,@"commentType":@"7",@"relativeId":_orItemsProductId,@"ordersId":_ordersId} success:^(NSMutableDictionary *dic) {
      
        
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"评论成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
//        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
        
        NSNotification *notification = [NSNotification notificationWithName:@"GOODORDER__NOTIFICATION" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        

        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
             [self.navigationController popViewControllerAnimated:YES];
            
        }];
        //[clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        
        
        
   
        
       
        
    } error:nil HUDAddView:self.view];
    
}
@end
