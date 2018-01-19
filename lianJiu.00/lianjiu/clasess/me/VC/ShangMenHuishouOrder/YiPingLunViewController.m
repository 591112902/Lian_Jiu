//
//  QuPingLunViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/15.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "YiPingLunViewController.h"
#import "UITextView+YLTextView.h"
@interface YiPingLunViewController ()
{
    NSString *commentEmoji;
    
   NSMutableArray *duoSelectNameArr;
    NSString *firstS;NSString *secondS;NSString *threeS;
}
@end

@implementation YiPingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回收评论";
    self.firstL.layer.borderWidth = 1;
    self.secondL.layer.borderWidth = 1;
    self.threeL.layer.borderWidth = 1;
    self.firstL.layer.borderColor = MAINColor.CGColor;
    self.secondL.layer.borderColor = MAINColor.CGColor;
    self.threeL.layer.borderColor = MAINColor.CGColor;
    
    

    
   
    
    
    
    [networking AFNRequest: [NSString stringWithFormat:@"%@/%@/1/10/current",GETCOMMENT,_relativeId?_relativeId:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            
            NSArray *lianjiuData = dic[@"lianjiuData"];
            if (lianjiuData.count==0) {
                return ;
            }
            NSDictionary *dataDic = lianjiuData[0];
            self.contentTV.text = [dataDic objectForKey:@"commentDetails"];
            
            NSString *commentLabelPrice = [dataDic objectForKey:@"commentLabelPrice"];
            NSString *commentLabelRemit = [dataDic objectForKey:@"commentLabelRemit"];
            NSString *commentLabelService = [dataDic objectForKey:@"commentLabelService"];
            
            
            if (commentLabelPrice.length>0 && commentLabelRemit.length>0&& commentLabelService.length>0 ) {
                self.firstL.hidden = NO;self.secondL.hidden = NO;self.threeL.hidden = NO;
                [self.firstL setTitle:commentLabelPrice forState:UIControlStateNormal];
                [self.secondL setTitle:commentLabelRemit forState:UIControlStateNormal];
                [self.threeL setTitle:commentLabelService forState:UIControlStateNormal];
             
            }else  if (commentLabelPrice.length==0 && commentLabelRemit.length>0&& commentLabelService.length>0 ) {
                self.firstL.hidden = NO;self.secondL.hidden = NO;self.threeL.hidden = YES;
                [self.firstL setTitle:commentLabelRemit forState:UIControlStateNormal];
                [self.secondL setTitle:commentLabelService forState:UIControlStateNormal];
               
            }else  if (commentLabelPrice.length>0 && commentLabelRemit.length==0&& commentLabelService.length>0 ) {
                self.firstL.hidden = NO;self.secondL.hidden = NO;self.threeL.hidden = YES;
                [self.firstL setTitle:commentLabelPrice forState:UIControlStateNormal];
                [self.secondL setTitle:commentLabelService forState:UIControlStateNormal];

            }else  if (commentLabelPrice.length>0 && commentLabelRemit.length>0&& commentLabelService.length==0 ) {
                self.firstL.hidden = NO;self.secondL.hidden = NO;self.threeL.hidden = YES;
                [self.firstL setTitle:commentLabelPrice forState:UIControlStateNormal];
                [self.secondL setTitle:commentLabelRemit forState:UIControlStateNormal];

                
            }else  if (commentLabelPrice.length>0 && commentLabelRemit.length==0&& commentLabelService.length==0 ) {
                
                self.firstL.hidden = NO;self.secondL.hidden = YES;self.threeL.hidden = YES;
                [self.firstL setTitle:commentLabelPrice forState:UIControlStateNormal];
            }else  if (commentLabelPrice.length==0 && commentLabelRemit.length>0&& commentLabelService.length==0 ) {
                
                self.firstL.hidden = NO;self.secondL.hidden = YES;self.threeL.hidden = YES;
                [self.firstL setTitle:commentLabelRemit forState:UIControlStateNormal];

            }else  if (commentLabelPrice.length==0 &&commentLabelRemit.length==0&& commentLabelService.length>0 ) {
                
                self.firstL.hidden = NO;self.secondL.hidden = YES;self.threeL.hidden = YES;
                [self.firstL setTitle:commentLabelService forState:UIControlStateNormal];
              
            }else  if (commentLabelPrice.length==0 && commentLabelRemit.length==0&& commentLabelService.length==0 ) {
               self.firstL.hidden = YES;self.secondL.hidden = YES;self.threeL.hidden = YES;            }

//            [self.firstL setTitle:commentLabelPrice forState:UIControlStateNormal];
//            [self.secondL setTitle:commentLabelRemit forState:UIControlStateNormal];
//            [self.threeL setTitle:commentLabelService forState:UIControlStateNormal];
            
        
            
            
            
            
            
            NSNumber *commentEmojiNum = [dataDic objectForKey:@"commentEmoji"];
            if ([commentEmojiNum isEqualToNumber:@30]) {
                //
                self.fBtn.selected = YES;
                 self.sBtn.selected = NO;
                 self.tBtn.selected = NO;
            }else if ([commentEmojiNum isEqualToNumber:@60]){
                self.fBtn.selected = NO;
                self.sBtn.selected = YES;
                self.tBtn.selected = NO;

            }else if ([commentEmojiNum isEqualToNumber:@90]){
                self.fBtn.selected = NO;
                self.sBtn.selected = NO;
                self.tBtn.selected = YES;

            }
            
            
            
            
            

            
        }
        
        
    } error:nil HUDAddView:self.view];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
      // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)xiaoLianAction:(id)sender {
    
    self.fBtn.selected = YES;
    self.sBtn.selected = NO;
    self.tBtn.selected = NO;
    
    
    
     [duoSelectNameArr addObjectsFromArray:@[@"10",@"11",@"12"]];
    _firstL.layer.borderColor=MAINColor.CGColor;
    [_firstL setTitleColor:MAINColor forState:UIControlStateNormal];
    _secondL.layer.borderColor=MAINColor.CGColor;
    [_secondL setTitleColor:MAINColor forState:UIControlStateNormal];
    _threeL.layer.borderColor=MAINColor.CGColor;
    [_threeL setTitleColor:MAINColor forState:UIControlStateNormal];
    
    firstS = @"价格低";
    secondS = @"打款慢";
    threeS = @"服务不好";
    [self.firstL setTitle:firstS forState:UIControlStateNormal];
    [self.secondL setTitle:secondS forState:UIControlStateNormal];
    [self.threeL setTitle:threeS forState:UIControlStateNormal];

   // self.threeL.textColor = MAINColor;
    commentEmoji= @"30";
}

- (IBAction)xiaoLianAction2:(id)sender {
    
    self.fBtn.selected = NO;
    self.sBtn.selected = YES;
    self.tBtn.selected = NO;
    
    
     [duoSelectNameArr addObjectsFromArray:@[@"10",@"11",@"12"]];
    _firstL.layer.borderColor=MAINColor.CGColor;
    [_firstL setTitleColor:MAINColor forState:UIControlStateNormal];
    _secondL.layer.borderColor=MAINColor.CGColor;
    [_secondL setTitleColor:MAINColor forState:UIControlStateNormal];
    _threeL.layer.borderColor=MAINColor.CGColor;
    [_threeL setTitleColor:MAINColor forState:UIControlStateNormal];


    firstS = @"价格公道";
    secondS = @"打款快";
    threeS = @"态度好";
    [self.firstL setTitle:firstS forState:UIControlStateNormal];
    [self.secondL setTitle:secondS forState:UIControlStateNormal];
    [self.threeL setTitle:threeS forState:UIControlStateNormal];
    
   // self.threeL.textColor = MAINColor;
commentEmoji= @"60";
    
}

- (IBAction)xiaoLianAction3:(id)sender {
    
    self.fBtn.selected = NO;
    self.sBtn.selected = NO;
    self.tBtn.selected = YES;
    
     [duoSelectNameArr addObjectsFromArray:@[@"10",@"11",@"12"]];
    _firstL.layer.borderColor=MAINColor.CGColor;
    [_firstL setTitleColor:MAINColor forState:UIControlStateNormal];
    _secondL.layer.borderColor=MAINColor.CGColor;
    [_secondL setTitleColor:MAINColor forState:UIControlStateNormal];
    _threeL.layer.borderColor=MAINColor.CGColor;
    [_threeL setTitleColor:MAINColor forState:UIControlStateNormal];
    
    firstS = @"价格高";
    secondS = @"打款快";
    threeS = @"极贴心";
    [self.firstL setTitle:firstS forState:UIControlStateNormal];
    [self.secondL setTitle:secondS forState:UIControlStateNormal];
    [self.threeL setTitle:threeS forState:UIControlStateNormal];
    
    
    
   // self.threeL.textColor = MAINColor;
   commentEmoji= @"90";
    
}

- (IBAction)commentAction:(id)sender {
    
    
}

- (IBAction)biaoQianAction:(id)sender {
    
  }
@end
