//
//  DCFillinOrderViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/27.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WeiXiuOrderViewController.h"
#import "AddNewAddressVC.h"
#import "DCReceiverAdressViewController.h"
#import "PaymentViewController.h"
#import "DatePickerView.h"



@interface WeiXiuOrderViewController ()<DCReceiverAdressVCdelegate,UITextFieldDelegate>

@property (strong,nonatomic) DatePickerView *datePickerView;

@property (strong,nonatomic) UITextField *tf;
@end

@implementation WeiXiuOrderViewController
{
    UIScrollView *_scrollV;
    CGFloat _scrollVH;
    
    UILabel *userAddressName;
    UILabel *userAddressPhone;
    UILabel *addressN;
    
    
    NSString *usrProvince;
    NSString *usrCity;
    NSString *usrDistrict;
    NSString *usrLocation;
   
    
    NSString *userAddressId;//地址id
    
    UITextField *tf;
    
   // NSMutableArray *chuanArr;
   
 UIWebView *_webView;
}
-(void)kefuAction{
    
    // 提示：不要将webView添加到self.view，如果添加会遮挡原有的视图
    // 懒加载
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://4001818209"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
}




-(void)addAddressBtnAction{
    NSLog(@"addAddressBtnAction");
    AddNewAddressVC *avc = [[AddNewAddressVC alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
    
}
-(void)ToAddressManageAction{
    NSLog(@"ToAddressManageAction");
    DCReceiverAdressViewController *avc = [[DCReceiverAdressViewController alloc] init];
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];

}
#pragma mark--代理方法
-(void)requestSelectAddress:(DCAddressItem*)addrModel{
    userAddressName.text = addrModel.userAddressName;
    userAddressPhone.text = addrModel.userAddressPhone;
    addressN.text = [NSString stringWithFormat:@"%@%@%@%@%@",addrModel.userProvince,addrModel.userCity,addrModel.userDistrict,addrModel.userSite,addrModel.userLocation];
    
    _address = @{@"userAddressName":addrModel.userAddressName,@"userAddressPhone":addrModel.userAddressPhone,@"userProvince":addrModel.userProvince,@"userCity":addrModel.userCity,@"userDistrict":addrModel.userDistrict,@"userSite":addrModel.userSite,@"userLocation":addrModel.userLocation,@"userAddressId":addrModel.userAddressId,};

    
   usrProvince =  addrModel.userProvince;
    usrCity=  addrModel.userCity;
    usrDistrict=  addrModel.userDistrict;
   usrLocation=  addrModel.userLocation;

  userAddressId = addrModel.userAddressId;
//    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",SELECTADDRESSBYADDRESSID,uAddrId] withparameters:nil success:^(NSMutableDictionary *dic) {
//        NSLog(@"userAddressId%@  %@   %@",dic,uAddrId, [NSString stringWithFormat:@"%@/%@",SELECTADDRESSBYADDRESSID,uAddrId]);
//        
////        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
////            NSArray *response = dic[@"lianjiuData"];
////            
////            
////            //            response.count>0?(response[0][@"essTitle"]?response[0][@"essTitle"]:@""):@"";
////            
////        }
//        
//        
//        
//        
//    } error:nil HUDAddView:self.view];

}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"[_dataSour[indexPath.row/2][_dataSour[indexPath.row/2][_dataSour[indexPath.row/2]jsonWFPriceDic%@",_jsonWFPriceDic);
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollVH = 0;
   
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    
    
    UIView *headContenV = [[UIView alloc] init];
    headContenV.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:headContenV];
    
    
    
    
    
    
    
    
    
    
    NSString *str = @"提交订单 提交订单后,工作人员将尽快与您联系!";//提交订单后,3个工作日内将安排维修人员上门回收
    CGRect headlabelSize = [str boundingRectWithSize:CGSizeMake(BOUND_WIDTH-10, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
    CGFloat headLabelH = headlabelSize.size.height+20;
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _scrollVH, BOUND_WIDTH-10, headLabelH)];
    headContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, headLabelH);
    headLabel.backgroundColor = [UIColor whiteColor];
    
    NSString *banceStr = @"提交订单后,工作人员将尽快与您联系!";
    NSString *str1 =   [NSString stringWithFormat:@"提交订单  %@",banceStr];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str1];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:banceStr].location, [[noteStr string] rangeOfString:banceStr].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:redRange];
    [headLabel setAttributedText:noteStr];
    headLabel.adjustsFontSizeToFitWidth = YES;
  //  headLabel.text = str;
    headLabel.font = PFR15Font;
    headLabel.numberOfLines = 0;
    [headContenV addSubview:headLabel];
    _scrollVH += headLabelH+1;
    
    
    
    
    CGFloat addressViewH ;
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addressBtn.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:addressBtn];
    
    
    
    if (_userDefault == 1) {
        
        addressViewH = 75;
        addressBtn.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, addressViewH);
        [addressBtn addTarget:self action:@selector(ToAddressManageAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        userAddressName = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, (BOUND_WIDTH-16)/2.0, 30)];
        userAddressName.text = [_address objectForKey:@"userAddressName"];
        userAddressName.font = PFR15Font;
        userAddressName.numberOfLines = 0;
        userAddressName.adjustsFontSizeToFitWidth = YES;
        [addressBtn addSubview:userAddressName];
        
        
        userAddressPhone = [[UILabel alloc] initWithFrame:CGRectMake(8+(BOUND_WIDTH-16)/2.0, 5, (BOUND_WIDTH-18)/2.0 -15, 30)];
        userAddressPhone.textAlignment = NSTextAlignmentRight;
        userAddressPhone.text = [_address objectForKey:@"userAddressPhone"];
        userAddressPhone.font = PFR15Font;
        userAddressPhone.numberOfLines = 0;
        userAddressPhone.adjustsFontSizeToFitWidth = YES;
        [addressBtn addSubview:userAddressPhone];
        
        
        addressN = [[UILabel alloc] initWithFrame:CGRectMake(8, 5+30, (BOUND_WIDTH-18  -15), 40)];
        
        addressN.text = [NSString stringWithFormat:@"%@%@%@%@%@",[_address objectForKey:@"userProvince"],[_address objectForKey:@"userCity"],[_address objectForKey:@"userDistrict"],[_address objectForKey:@"userSite"],[_address objectForKey:@"userLocation"]];
        
        
        usrProvince =  [_address objectForKey:@"userProvince"];
        usrCity=  [_address objectForKey:@"userCity"];
        usrDistrict=  [_address objectForKey:@"userDistrict"];
        usrLocation=  [_address objectForKey:@"userLocation"];
        
        userAddressId = [_address objectForKey:@"userAddressId"];
        
        addressN.font = PFR15Font;
        addressN.numberOfLines = 0;
        addressN.adjustsFontSizeToFitWidth = YES;
        [addressBtn addSubview:addressN];
        
        
        
        
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake(BOUND_WIDTH-10-5, (75-19)/2.0, 10, 19);
        iv.image = [UIImage imageNamed:@"jiantou"];
        [addressBtn addSubview:iv];
        
        
        
    }else{
        
        
        addressViewH = 40;
        addressBtn.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, addressViewH);
        [addressBtn setTitle:@"+添加地址" forState:UIControlStateNormal];
        [addressBtn setTitleColor:MAINColor forState:UIControlStateNormal];
        [addressBtn addTarget:self action:@selector(addAddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    _scrollVH += addressViewH+5;
    
    
//    
//    UILabel *weixiuStyle = [[UILabel alloc] init];
//    weixiuStyle.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 40);
//    weixiuStyle.text = @"  请选择维修方式";
//    weixiuStyle.backgroundColor = [UIColor  whiteColor];
//    weixiuStyle.font = [UIFont systemFontOfSize:13];
//    weixiuStyle.textColor = [UIColor lightGrayColor];
//    [_scrollV addSubview:weixiuStyle];
//    _scrollVH += 40;
    
    
    
    
    UIView *yyWeiXiuContenV = [[UIView alloc] init];
    yyWeiXiuContenV.backgroundColor = [UIColor whiteColor];
    yyWeiXiuContenV.layer.borderWidth = 1;
    yyWeiXiuContenV.layer.borderColor = BGColor.CGColor;
    yyWeiXiuContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 50);
    [_scrollV addSubview:yyWeiXiuContenV];
    _scrollVH += 50;
    
    UILabel *yyyweiL = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 70, 30)];
    yyyweiL.text = @"预约维修:";
    yyyweiL.font = PFR13Font;
    [yyWeiXiuContenV addSubview:yyyweiL];
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(78, 10, BOUND_WIDTH-80, 30)];
    _tf.placeholder = @"请选择上门维修时间";
    _tf.delegate = self;
    //_tf.userInteractionEnabled = NO;
    _tf.font = [UIFont systemFontOfSize:13];
    
    _datePickerView = [[DatePickerView alloc] initWithCustomeHeight:250];
    __weak typeof (self) weakSelf = self;
    _datePickerView.confirmBlock = ^(NSString *choseDate, NSString *restDate) {
        weakSelf.tf.text = choseDate;//选择的日qi
    };
    _datePickerView.cannelBlock = ^(){
        [weakSelf.view endEditing:YES];
    };
    //设置textfield的键盘 替换为我们的自定义view
    _tf.inputView = _datePickerView;
    [yyWeiXiuContenV addSubview:_tf];
    
    
    
    
    
    
    
    
    
    UIImageView *jiantou = [[UIImageView alloc] init];
    jiantou.image = [UIImage imageNamed:@"jiantou"];
    jiantou.frame = CGRectMake(BOUND_WIDTH-30 , 16.5, 10,17);
    [yyWeiXiuContenV addSubview:jiantou];
    
    
    
    
#pragma mark-预计维修价格
    UIView *zfContenV = [[UIView alloc] init];
    zfContenV.backgroundColor = [UIColor whiteColor];
    zfContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 15+40 +40);
    [_scrollV addSubview:zfContenV];
    _scrollVH += 15+40 +40;
    
    
//    UILabel *lianjiu = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 85, 30)];
//    lianjiu.text = @"预计维修价格";
//    lianjiu.font = PFR13Font;
//    [zfContenV addSubview:lianjiu];
    
    
    UILabel *qita = [[UILabel alloc] initWithFrame:CGRectMake(8, 15, BOUND_WIDTH-16, 40)];
    
    
    
    qita.text = [_jsonWFPriceDic objectForKey:@"major"];// @"电池待机时间短自动关机";
    qita.font = PFR13Font;
    qita.textColor = [UIColor darkGrayColor];
    [zfContenV addSubview:qita];
    
    
    
    UILabel *huanDCL = [[UILabel alloc] initWithFrame:CGRectMake(8, 15+40, BOUND_WIDTH/3.0*2, 30)];
    huanDCL.text = [_jsonWFPriceDic objectForKey:@"majorData"];//@"换电磁";
    huanDCL.font = PFR13Font;
    huanDCL.textColor = [UIColor darkGrayColor];
    [zfContenV addSubview:huanDCL];
    //价格========
    UILabel *hMoneyL = [[UILabel alloc] initWithFrame:CGRectMake(BOUND_WIDTH/3.0*2, 15+30, BOUND_WIDTH/3.0-10, 30)];
    
    hMoneyL.text = [NSString stringWithFormat:@"¥%@元",[_jsonWFPriceDic objectForKey:@"priceAlliance"]];//@"";
    hMoneyL.textColor = MAINColor;
    hMoneyL.font = PFR18Font;
    hMoneyL.textAlignment = NSTextAlignmentRight;
    hMoneyL.numberOfLines = 0;
    hMoneyL.adjustsFontSizeToFitWidth = YES;
    [zfContenV addSubview:hMoneyL];
    
    
    
    
    
    CGFloat subViewH2 = BOUND_WIDTH/320.0*38;
    CGFloat subBtnW2 = BOUND_WIDTH/2;
    
    UIButton *kefuBtn = [UIButton buttonWithType:UIButtonTypeCustom];//客服
    kefuBtn.frame = CGRectMake(0, BOUND_HIGHT-BOUND_WIDTH/320.0*38, subBtnW2, subViewH2);
    [kefuBtn setBackgroundImage:[UIImage imageNamed:@"jpinKF"] forState:UIControlStateNormal];//UIControlStateHighlighted
    [kefuBtn setBackgroundImage:[UIImage imageNamed:@"jpinKF"] forState:UIControlStateHighlighted];
    kefuBtn.titleLabel.numberOfLines = 0;
    kefuBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [kefuBtn addTarget:self action:@selector(kefuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kefuBtn];

    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(subBtnW2, BOUND_HIGHT-BOUND_WIDTH/320.0*38, subBtnW2, subViewH2);
    //commitBtn.layer.cornerRadius = 5;
    commitBtn.backgroundColor = MAINColor;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    
    
    
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);
    _scrollV.scrollEnabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)commitBtnClick{
    NSLog(@"commitBtnClick");
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];

    if (uid.length==0) {
        [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }
    
    if (userAddressId.length==0) {
        [MBProgressHUD showNotPhotoError:@"请添加地址" toView:self.view];
        return;
    }
    
    if (_tf.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请选择预约维修时间" toView:self.view];
        return;
    }

    
    
    
    
    
    if (_selectColor) {
        [_jsonWFPriceDic setValue:_selectColor forKey:@"color"];
    }
   // [chuanArr addObject:_jsonWFPriceDic];
    NSData *data =  [NSJSONSerialization dataWithJSONObject:_jsonWFPriceDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    

    
    
    
    NSDictionary *para = @{@"userId":uid,@"orRepairVisitTime":_tf.text,@"orRepairScheme":string,@"addressId":userAddressId,@"productRepairId":_repairId,@"productRepairName":self.title};
    
    
    NSLog(@"string:##%@##  颜色:%@  para:%@",string,_selectColor,para);
    
    
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要提交订单？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        [networking AFNPOST:SUBMIT withparameters:para success:^(NSMutableDictionary *dic) {
            NSLog(@"weixiuOrderViewController:%@",dic);
            
            //手机快修
            WeiOrderViewController *uvc = [[WeiOrderViewController alloc] init];
            uvc.title = @"手机快修";
            
            uvc.isPay = @"fanhuiduoceng";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
            
            [MBProgressHUD showNotPhotoError:@"提交成功" toView:uvc.view];
            
            
        } error:^(NSError *error) {
            
            [MBProgressHUD showError:@"稍后重试" toView:self.view];
        } HUDAddView:self.view];

        
        
        
        
    }];
    [clear addAction:quXiao];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];

    
    
    
    
    
    
    
    
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
