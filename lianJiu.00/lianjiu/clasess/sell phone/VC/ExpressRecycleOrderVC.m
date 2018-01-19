//
//  ExpressRecycleOrderVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/13.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ExpressRecycleOrderVC.h"

#import "ExpressRecycleOView.h"

#import "KuaiDiAddrViewController.h"

@interface ExpressRecycleOrderVC ()
{
    ExpressRecycleOView *erView;
    NSString *buyWay;
    
    
    NSString *code;
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;


}
@end



@implementation ExpressRecycleOrderVC
#pragma mark - action
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
 self.title = @"快递回收订单";
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    
    
   erView = [[[NSBundle mainBundle]loadNibNamed:@"ExpressRecycleOView" owner:nil options:nil]lastObject];
   erView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 880);
    [_scrollV addSubview:erView];
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, 636);
    
    
    
    
    
    if (BOUND_WIDTH == 320) {
        
        erView.HeadimageView.image = [UIImage imageNamed:@"head320"];
    }else if (BOUND_WIDTH == 375){
        erView.HeadimageView.image = [UIImage imageNamed:@"head375"];
    }else if (BOUND_WIDTH == 414){
        erView.HeadimageView.image = [UIImage imageNamed:@"head414"];
    }else{
        erView.HeadimageView.image = [UIImage imageNamed:@"head320"];
    }
    
    
    
    
    
    [erView.commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [erView.getCodeBtn addTarget:self action:@selector(codeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [erView.chuCSheZhiBtn addTarget:self action:@selector(chuCSheZhiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [erView.jieSuoBtn addTarget:self action:@selector(jieSuoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [erView.ziGouBtn addTarget:self action:@selector(firstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [erView.otherSongBtn addTarget:self action:@selector(firstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [erView.huoDongBtn addTarget:self action:@selector(firstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [erView.qitaBtn addTarget:self action:@selector(firstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    erView.ziGouBtn.tag = 10;
    erView.otherSongBtn.tag = 11;
    erView.huoDongBtn.tag = 12;
    erView.qitaBtn.tag = 13;

    
    
    buyWay = @"0";
    erView.ziGouBtn.selected = YES;
    erView.otherSongBtn.selected = NO;
    erView.huoDongBtn.selected = NO;
    erView.qitaBtn.selected = NO;
    
}
-(void)chuCSheZhiBtnAction{//出厂设置
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"如何恢复出厂设置" message:@"    1、 安卓手机如何恢复出厂设置\n\n恢复出厂设置会删除手机中所有数据和下载的应用程序。\n\n第一步：在手机找到并打开【设置】功能;\n\n第二步：在【设置】中找到【手机设置】、【安全设置】或者【隐私或安全】功能，恢复出厂设置一般都在这几个功能中;\n\n第三步：找到【恢复出厂设置】或者【备份和重置】;\n\n第四步：点击【恢复出厂设置】后基本可以恢复手机出厂设置，部分手机还需要点击【重置手机】-【清楚全部内容;\n\n2、 苹果手机如何恢复出厂设置\n\n第一步：在手机找到并打开【设置】功能;\n\n第二步：在恢复出厂设置前建议做好苹果手机备份工作。在【设置】-【iCloud】-【储存与备份】进行备份;\n\n第三步：在【设置】-【通用】-【还原】-【抹掉所有内容和设置】;" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];
}
-(void)jieSuoBtnAction{//解锁
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"如何解锁" message:@"    1、 安卓手机账号解除\n\n三星手机：点击【应用程序】-【设定】-【账户和同步】-【三星帐号】-【移除账户】。\n\n小米手机：点击【设置】-【账户】-【小米云服务】-点击账户名称-【注销账户】。\n\n魅族手机：点击【设置】-【账户】-【退出账户】。\n\n2、安卓手机解除开机密码\n\n华为手机：第一步：在手机找到并打开【设置】功能;\n\n第二步：点击【安全】-【解锁样式】-【不锁屏】。\n\n小米手机：第一步：在手机找到并打开【设置】功能;\n\n第二步：点击【锁屏与密码】-【密码】-【关闭密码】。\n\n由于安卓手机有品牌有很多，只简单介绍常见的几个手机品牌，其他品牌请大致参考步骤进行操作。\n\n2、苹果手机如何注销Apple ID\n\n第一步：在手机找到并打开【设置】功能\n\n第二步：点击【itunes store和app store】；\n\n第三步：点击自己的Apple ID；\n\n第四步：点击【注销】按钮。\n\n2、苹果手机解除开机密码\n\n第一步：在手机找到并打开【设置】功能；\n\n第二步：点击【Touch ID 与密码】-【关闭密码】-【关闭】" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];
}
-(void)firstBtnAction:(UIButton*)btn{
    
    if (btn.tag == 10) {
        buyWay = @"0";
        erView.ziGouBtn.selected = YES;
        erView.otherSongBtn.selected = NO;
        erView.huoDongBtn.selected = NO;
        erView.qitaBtn.selected = NO;
        
    }else if (btn.tag == 11) {
        buyWay = @"1";
        erView.ziGouBtn.selected = NO;
        erView.otherSongBtn.selected = YES;
        erView.huoDongBtn.selected = NO;
        erView.qitaBtn.selected = NO;
        
    }else if (btn.tag == 12) {
        buyWay = @"2";
        erView.ziGouBtn.selected = NO;
        erView.otherSongBtn.selected = NO;
        erView.huoDongBtn.selected = YES;
        erView.qitaBtn.selected = NO;
        
    }else if (btn.tag == 13) {
        buyWay = @"3";
        erView.ziGouBtn.selected = NO;
        erView.otherSongBtn.selected = NO;
        erView.huoDongBtn.selected = NO;
        erView.qitaBtn.selected = YES;
        
    }

    
}




-(void)commitBtnAction{
   // erView.lianXiRenTF.text ; erView.phoneTF.text ; erView.codeTF.text ;
    NSLog(@"lianXiRenTF:%@  phoneTF:%@  codeTF:%@  buyWay:%@",erView.lianXiRenTF.text,erView.phoneTF.text,erView.codeTF.text,buyWay);
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uID = [def objectForKey:@"userId"];
    
    if (erView.lianXiRenTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写联系人" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (erView.phoneTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写联系人电话" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (erView.codeTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写验证码" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }

    
    
  
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否提交订单？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [networking AFNPOSTNotCode:ORSUBMIT withparameters:@{@"orExpressUserId":uID,@"orExpressUserPhone":erView.phoneTF.text,@"orExpressUserName":erView.lianXiRenTF.text,@"checkCode":erView.codeTF.text,@"orItemsBuyway":buyWay} success:^(NSMutableDictionary *dic) {
            NSLog(@"%@---%@",dic,dic[@"msg"]);
            NSNumber *status=dic[@"status"];
            if ([status isEqualToNumber:@200]) {
                if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *lianjiuData  = dic[@"lianjiuData"];
                    KuaiDiAddrViewController *kv = [[KuaiDiAddrViewController alloc] init];
                    kv.ordersId = lianjiuData[@"ordersId"];
                    kv.totalprice = lianjiuData[@"totalprice"];
                    [self.navigationController pushViewController:kv animated:YES];
                    
                    [MBProgressHUD showNotPhotoError:@"订单提交成功" toView:kv.view];
                    
                }
            }else{
                [MBProgressHUD showError:dic[@"msg"]toView:self.view];
            }
        } error:nil HUDAddView:self.view];
        

        
        
        
    }];
    [clear addAction:quXiao];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];

    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)codeBtnAction{
    
    if (erView.phoneTF.text.length!=0) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *uID = [def objectForKey:@"userId"];
        NSLog(@"uIDuIDuID%@",uID);
        
        [networking AFNPOST:SENDEXPRESSORDERAMS withparameters:@{@"userId":uID?uID:@"",@"phone":erView.phoneTF.text} success:^(NSMutableDictionary *dic) {
            code = dic[@"lianjiuData"];
            NSLog(@"获取验证码:%@",dic);
            [MBProgressHUD showSuccess:@"验证码已发送成功" toView:[UIApplication sharedApplication].keyWindow];
            //accout = self.phoneTF.text;
            erView.getCodeBtn.enabled = NO;
            erView.getCodeBtn.alpha = 0.4;
            secondsCountDown = 300;//60秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        } error:^(NSError *error) {
            
        } HUDAddView:self.view];
    }else{
        
        [MBProgressHUD showNotPhotoError:@"请填写联系人电话" toView:[UIApplication sharedApplication].keyWindow];
    }

    
}
-(void)timeFireMethod{
    secondsCountDown--;
    [erView.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)secondsCountDown] forState:UIControlStateNormal];
    [erView.getCodeBtn setBackgroundColor:MAINColor];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [erView.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        erView.getCodeBtn.enabled = YES;
        erView.getCodeBtn.alpha = 1;
    }
}



@end
