//
//  QuPingLunViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/15.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "QuPingLunViewController.h"
#import "UITextView+YLTextView.h"
@interface QuPingLunViewController ()
{
    NSString *commentEmoji;
    
   NSMutableArray *duoSelectNameArr;
    NSString *firstS;NSString *secondS;NSString *threeS;
}
@end

@implementation QuPingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回收评论";
    
    
    duoSelectNameArr = [[NSMutableArray alloc] init];
    
    [duoSelectNameArr addObjectsFromArray:@[@"10",@"11",@"12"]];
    
    _contentTV.placeholder = @"说说哪里满意,给大家提供参考";
    _contentTV.limitLength = @200;
    self.firstL.layer.borderWidth = 1;
    self.secondL.layer.borderWidth = 1;
    self.threeL.layer.borderWidth = 1;
    self.firstL.selected = YES;self.self.secondL.selected = YES;self.threeL.selected = YES;
    self.firstL.layer.borderColor = MAINColor.CGColor;
    self.secondL.layer.borderColor = MAINColor.CGColor;
    self.threeL.layer.borderColor = MAINColor.CGColor;
    
    
    
    
    
    
    
    
    
           self.fBtn.selected = NO;
        self.sBtn.selected = YES;
        self.tBtn.selected = NO;
        [duoSelectNameArr addObjectsFromArray:@[@"10",@"11",@"12"]];
        firstS = @"价格公道";
        secondS = @"打款快";
        threeS = @"态度好";
        [self.firstL setTitle:firstS forState:UIControlStateNormal];
        [self.secondL setTitle:secondS forState:UIControlStateNormal];
        [self.threeL setTitle:threeS forState:UIControlStateNormal];
        // self.threeL.textColor = MAINColor;
        commentEmoji= @"60";

    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    if (_contentTV.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请输入评论内容" toView:self.view];
        return;
    }
    
    
  
    
    NSLog(@"%@ duoSelectNameArr&&:%@",@{@"userId":uid,@"commentDetails":_contentTV.text,@"commentType":@"3",@"relativeId":_relativeId,@"commentEmoji":commentEmoji,@"commentLabelPrice":[duoSelectNameArr containsObject:@"10"]?firstS:@"",@"commentLabelRemit":[duoSelectNameArr containsObject:@"11"]?secondS:@"",@"commentLabelService":[duoSelectNameArr containsObject:@"12"]?threeS:@"",},duoSelectNameArr);
    
    
    NSDictionary *para ;
    if ([_recycleStyle isEqualToString:@"KD"]) {
        para = @{@"userId":uid,@"commentDetails":_contentTV.text,@"commentType":@"3",@"relativeId":_relativeId,@"commentEmoji":commentEmoji,@"commentLabelPrice":[duoSelectNameArr containsObject:@"10"]?firstS:@"",@"commentLabelRemit":[duoSelectNameArr containsObject:@"11"]?secondS:@"",@"commentLabelService":[duoSelectNameArr containsObject:@"12"]?threeS:@"",};
        
    }else if ([_recycleStyle isEqualToString:@"SM"]) {
        para = @{@"userId":uid,@"commentDetails":_contentTV.text,@"commentType":@"4",@"relativeId":_relativeId,@"commentEmoji":commentEmoji,@"commentLabelPrice":[duoSelectNameArr containsObject:@"10"]?firstS:@"",@"commentLabelRemit":[duoSelectNameArr containsObject:@"11"]?secondS:@"",@"commentLabelService":[duoSelectNameArr containsObject:@"12"]?threeS:@"",};
    }else if ([_recycleStyle isEqualToString:@"DZ"]) {
        para = @{@"userId":uid,@"commentDetails":_contentTV.text,@"commentType":@"5",@"relativeId":_relativeId,@"commentEmoji":commentEmoji,@"commentLabelPrice":[duoSelectNameArr containsObject:@"10"]?firstS:@"",@"commentLabelRemit":[duoSelectNameArr containsObject:@"11"]?secondS:@"",@"commentLabelService":[duoSelectNameArr containsObject:@"12"]?threeS:@"",};
    }

    
    
    
    [networking AFNPOST:SUBMITCOMMENT withparameters:para success:^(NSMutableDictionary *dic) {
        
        if ([_recycleStyle isEqualToString:@"SM"]) {
        
            NSNotification *notification = [NSNotification notificationWithName:@"JIADAN__NOTIFICATION" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            ShangMenOrderViewController* oneVC =nil;
            for(UIViewController* VC in self.navigationController.viewControllers){
                if([VC isKindOfClass:[ShangMenOrderViewController class]]){
                    oneVC =(ShangMenOrderViewController*) VC;
                    //
                    [self.navigationController popToViewController:oneVC animated:YES];
                    [MBProgressHUD showNotPhotoError:@"评价成功" toView:oneVC.view];
                }
            }

        }else if ([_recycleStyle isEqualToString:@"KD"]) {
            
            NSNotification *notification = [NSNotification notificationWithName:@"FANHUI_SHUAXIN_NOTIFICATION" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            KuaiDiOrderViewController* oneVC =nil;
            for(UIViewController* VC in self.navigationController.viewControllers){
                if([VC isKindOfClass:[KuaiDiOrderViewController class]]){
                    oneVC =(KuaiDiOrderViewController*) VC;
                    //
                    [self.navigationController popToViewController:oneVC animated:YES];
                    [MBProgressHUD showNotPhotoError:@"评价成功" toView:oneVC.view];
                }
            }
            
        }else if ([_recycleStyle isEqualToString:@"DZ"]) {
            
            NSNotification *notification = [NSNotification notificationWithName:@"DAZONG_NOTIFICATION" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            DaZongOrderViewController* oneVC =nil;
            for(UIViewController* VC in self.navigationController.viewControllers){
                if([VC isKindOfClass:[DaZongOrderViewController class]]){
                    oneVC =(DaZongOrderViewController*) VC;
                    //
                    [self.navigationController popToViewController:oneVC animated:YES];
                    [MBProgressHUD showNotPhotoError:@"评价成功" toView:oneVC.view];
                }
            }
            
        }


        
     
        
       
        
        
        
        
    } error:nil HUDAddView:self.view];
    
    
}

- (IBAction)biaoQianAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
//     NSInteger index = btn.tag -10;
     btn.selected = !btn.selected;
    if (btn.selected) {
        btn.layer.borderColor=MAINColor.CGColor;
        [btn setTitleColor:MAINColor forState:UIControlStateNormal];
        
        NSString *selectS = [NSString stringWithFormat:@"%ld",(long)btn.tag];
         [duoSelectNameArr addObject:selectS];

    }else{
        btn.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        NSString *selectS = [NSString stringWithFormat:@"%ld",(long)btn.tag];
        [duoSelectNameArr removeObject:selectS];
    }
}
@end
