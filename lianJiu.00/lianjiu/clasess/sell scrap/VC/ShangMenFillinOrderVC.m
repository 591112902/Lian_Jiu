

#import "DatePickerView.h"
#import "ShangMenFillinOrderVC.h"
#import "AddNewAddressVC.h"
#import "DCReceiverAdressViewController.h"
#import "PaymentViewController.h"

@interface ShangMenFillinOrderVC ()<DCReceiverAdressVCdelegate,UITextFieldDelegate>
@property (strong,nonatomic) DatePickerView *datePickerView;
@property (strong,nonatomic) UITextField *tf;
@end

@implementation ShangMenFillinOrderVC
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
    
    //UILabel *chooseTimeLabel;
    UILabel *dataLabel;

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

    self.userDefault = YES;
    
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

-(void)requestDataDef{
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addressBtn.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:addressBtn];
    
    CGFloat addressViewH ;
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
        iv.frame = CGRectMake(BOUND_WIDTH-10-5, (75-19)/2.0, 10, 17);
        iv.image = [UIImage imageNamed:@"jiantou"];
        [addressBtn addSubview:iv];
        
    }else{//没有设置默认地址",500 502
        
        addressViewH = 40;
        addressBtn.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, addressViewH);
        [addressBtn setTitle:@"+添加地址" forState:UIControlStateNormal];
        [addressBtn setTitleColor:MAINColor forState:UIControlStateNormal];
        [addressBtn addTarget:self action:@selector(addAddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    
    _scrollVH += addressViewH+1;
    UIView* timeContenV = [[UIView alloc] init];
    timeContenV.backgroundColor = [UIColor whiteColor];
    timeContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 40);
    [_scrollV addSubview:timeContenV];
    _scrollVH += 41;
    
    UILabel *yyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    yyLabel.textAlignment = NSTextAlignmentLeft;
    yyLabel.font = [UIFont systemFontOfSize:15];
    yyLabel.text = @"预约上门时间:";
    
    UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 25, 12.5, 10, 17)];
    rightImgView.image = [UIImage imageNamed:@"jiantou"];
    
    
    //        chooseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, self.view.bounds.size.width - 115, 20)];
    //        chooseTimeLabel.text = @"请选择交易时间";
    //        chooseTimeLabel.textColor = [UIColor lightGrayColor];
    //        chooseTimeLabel.font = [UIFont systemFontOfSize:15];
    //        chooseTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, self.view.bounds.size.width - 135, 20)];
    _tf.placeholder = @"请选择交易时间";
    _tf.delegate = self;
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
    
    [timeContenV addSubview:yyLabel];
    [timeContenV addSubview:rightImgView];
    [timeContenV addSubview:_tf];
    
    //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDateBtnAction)];
    //        chooseTimeLabel.userInteractionEnabled = YES;
    //        [chooseTimeLabel addGestureRecognizer:tap];
    
    
#pragma mark-支付方式
    UIView *zfContenV = [[UIView alloc] init];
    zfContenV.backgroundColor = [UIColor whiteColor];
    zfContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 400);
    [_scrollV addSubview:zfContenV];
    _scrollVH += 400+5;
    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(10, 5+30+100, BOUND_WIDTH-20, 44);
    commitBtn.layer.cornerRadius = 5;
    commitBtn.backgroundColor = MAINColor;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [zfContenV addSubview:commitBtn];
    
    UILabel *quxiaoTS = [[UILabel alloc] initWithFrame:CGRectMake(10, 5+30+100 +44 , BOUND_WIDTH-20, 44)];
    quxiaoTS.text = @"工作人员将会在预约时间当天联系你";
    quxiaoTS.textColor = [UIColor lightGrayColor];
    quxiaoTS.textAlignment = NSTextAlignmentCenter;
    quxiaoTS.font = PFR12Font;
    quxiaoTS.numberOfLines = 0;
    quxiaoTS.adjustsFontSizeToFitWidth = YES;
    [zfContenV addSubview:quxiaoTS];
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);
    
    
    
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
    //        [MBProgressHUD showError:@"网络不给力" toView:superView];
    //    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = @"上门回收订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    
    
//    UIView *headContenV = [[UIView alloc] init];
//    headContenV.backgroundColor = [UIColor whiteColor];
//    [_scrollV addSubview:headContenV];
//    //productIdList
//    
//    NSString *str = [NSString stringWithFormat:@"订单编号:%@",_productIdList];
//    CGRect headlabelSize = [str boundingRectWithSize:CGSizeMake(BOUND_WIDTH-20, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil];
//    CGFloat headLabelH = headlabelSize.size.height+20;
//    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _scrollVH, BOUND_WIDTH/5*4.0, headLabelH)];
//    
//    headContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, headLabelH);
//    headLabel.backgroundColor = [UIColor whiteColor];
//    headLabel.text = str;
//    headLabel.font = PFR15Font;
//    headLabel.numberOfLines = 0;
//    [headContenV addSubview:headLabel];
//    _scrollVH += headLabelH+1;
    
    
    
    
    UIView *ddContenV = [[UIView alloc] init];
    ddContenV.backgroundColor = [UIColor whiteColor];
    ddContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 100);
    [_scrollV addSubview:ddContenV];
    _scrollVH += 100+5;
    //90   70
    UIImageView *tImge = [[UIImageView alloc] initWithFrame:CGRectMake(8, 15,90, 70)];
    //tImge.image = [UIImage imageNamed:@"esjpr"];
    
    [tImge sd_setImageWithURL:[NSURL URLWithString:_goodImageViewStr] placeholderImage:[UIImage imageNamed:@"esjpr"]];
    
    [ddContenV addSubview:tImge];
    
    
    UILabel *h3 = [[UILabel alloc] initWithFrame:CGRectMake( 100, 30, self.view.bounds.size.width - 110, 40)];
    h3.text = [NSString stringWithFormat:@"预估总价：%.2f元", _price.floatValue];;
    h3.textColor = MAINColor;
    h3.textAlignment = NSTextAlignmentRight;
    h3.font = PFR15Font;
    h3.numberOfLines = 0;
    h3.adjustsFontSizeToFitWidth = YES;
    [ddContenV addSubview:h3];
    
    
//    dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width - 10, 40)];
//    dataLabel.textAlignment = NSTextAlignmentRight;
//    dataLabel.font = [UIFont systemFontOfSize:12];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
//    NSDate *datenow = [NSDate date];
//    NSString *currentTimeString = [formatter stringFromDate:datenow];
//    dataLabel.text = currentTimeString;
//    dataLabel.textColor = [UIColor lightGrayColor];
//    [ddContenV addSubview:dataLabel];
    
    
    [self requestDataDef];
    
    
    
    NSLog(@"DCFillinOrderViewController:%@    bbb:%d",_address,_userDefault);
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
}
//-(void)chooseDateBtnAction{
//    
//    //__weak ViewController *vc = self;
//    [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
//       // __strong ViewController *ss = vc;
//        
//        NSLog(@"current Date:%@",date);
//        NSString *str = [NSString stringWithFormat:@"%@",date];
//        [str substringToIndex:10];
//        
//       chooseTimeLabel.text =[str substringToIndex:10];
//        chooseTimeLabel.textColor = [UIColor blackColor];
//    } cancelBlock:^{
//        
//    }];
//
//}

-(void)commitBtnClick{
    NSLog(@"commitBtnClick");
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];

    
    
    
    
    NSLog(@"commitBtnClick_userAddressId%@",userAddressId);
    
    
    
    
    
    if (userAddressId.length==0) {
        
        [MBProgressHUD showNotPhotoError:@"请添加地址" toView:self.view];
        return;
    }

    if (_tf.text.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请预约上门时间" toView:self.view];
        return;
    }
    
    NSDictionary *para = @{@"userId":uid,@"addressId":userAddressId,@"orFacefaceVisittime":_tf.text,};
    NSLog(@"commitBtnClick%@",para);

    
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否提交订单？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [networking AFNPOST:SUBMITFACEFACE withparameters:para success:^(NSMutableDictionary *dic) {
            NSLog(@"shangmenFillinOrderViewController:%@",dic);
            
            ShangMenOrderViewController *uvc = [[ShangMenOrderViewController alloc] init];
            uvc.title = @"上门回收";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
            
            [MBProgressHUD showNotPhotoError:@"订单提交成功" toView:uvc.view];
            
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
