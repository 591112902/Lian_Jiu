//
//  DCFillinOrderViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/27.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "DCFillinOrderViewController.h"
#import "AddNewAddressVC.h"
#import "DCReceiverAdressViewController.h"
#import "PaymentViewController.h"

@interface DCFillinOrderViewController ()<DCReceiverAdressVCdelegate>

@end

@implementation DCFillinOrderViewController
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
}


-(void)viewWillAppear:(BOOL)animated{
    self.title = @"确认订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    

    
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    
    
    UIView *headContenV = [[UIView alloc] init];
    headContenV.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:headContenV];
    NSString *str = @"订单详情";
    CGRect headlabelSize = [str boundingRectWithSize:CGSizeMake(BOUND_WIDTH-20, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil];
    CGFloat headLabelH = headlabelSize.size.height+20;
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _scrollVH, BOUND_WIDTH/5*4.0, headLabelH)];
    
    headContenV.frame = CGRectMake(0, 0, BOUND_WIDTH, headLabelH);
    headLabel.backgroundColor = [UIColor whiteColor];
    headLabel.text = str;
    headLabel.font = PFR15Font;
    headLabel.numberOfLines = 0;
    [headContenV addSubview:headLabel];
    _scrollVH += headLabelH+1;
    
    
    
    
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
    
    
    UILabel *h1 = [[UILabel alloc] initWithFrame:CGRectMake(98+10, 5, BOUND_WIDTH-108-3, 30)];
    h1.text = _name;
    h1.font = PFR15Font;
    h1.numberOfLines = 0;
    h1.adjustsFontSizeToFitWidth = YES;
    [ddContenV addSubview:h1];
    
    UILabel *h2 = [[UILabel alloc] initWithFrame:CGRectMake(98+10, 5+30, BOUND_WIDTH-108-3, 30)];
    h2.text = _nameDetail;
    h2.font = PFR15Font;
    h2.textColor = [UIColor lightGrayColor];
    h2.numberOfLines = 0;
    h2.adjustsFontSizeToFitWidth = YES;
    [ddContenV addSubview:h2];
    
    UILabel *h3 = [[UILabel alloc] initWithFrame:CGRectMake(98+10, 5+60, BOUND_WIDTH-108-3, 30)];
    
    
    h3.text = [NSString stringWithFormat:@"¥%@",_price];
    h3.textColor = MAINColor;
    h3.font = PFR15Font;
    h3.numberOfLines = 0;
    h3.adjustsFontSizeToFitWidth = YES;
    [ddContenV addSubview:h3];
    
    
    NSLog(@"DCFillinOrderViewController:%@    bbb:%d",_address,_userDefault);
    
    
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
    _scrollVH += addressViewH+1;
    
    
    
    
    
    
#pragma mark-支付方式
    UIView *zfContenV = [[UIView alloc] init];
    zfContenV.backgroundColor = [UIColor whiteColor];
    zfContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 600);
    [_scrollV addSubview:zfContenV];
    _scrollVH += 600;
    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(10, 5+30+100, BOUND_WIDTH-20, 44);
    commitBtn.layer.cornerRadius = 5;
    commitBtn.backgroundColor = MAINColor;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [zfContenV addSubview:commitBtn];
    
    
    UILabel *quxiaoTS = [[UILabel alloc] initWithFrame:CGRectMake(10, 5+30+100 +44 , BOUND_WIDTH-20, 44)];
    quxiaoTS.text = @"若不及时支付，订单将在30分钟内自动取消";
    quxiaoTS.textColor = [UIColor lightGrayColor];
    quxiaoTS.textAlignment = NSTextAlignmentCenter;
    quxiaoTS.font = PFR12Font;
    quxiaoTS.numberOfLines = 0;
    quxiaoTS.adjustsFontSizeToFitWidth = YES;
    [zfContenV addSubview:quxiaoTS];
    
    
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);
    
    _scrollV.scrollEnabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}
-(void)commitBtnClick{
    NSLog(@"commitBtnClick");
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];

    
    NSLog(@"commitBtnClick");
    
    if (uid.length==0) {
        [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }

    
    if (userAddressId.length==0) {
        [MBProgressHUD showNotPhotoError:@"请添加地址" toView:self.view];
        return;
    }
    
    
    
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"30分钟不付款则取消订单！" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        
        NSDictionary *para = @{@"ordersExcellent.userId":uid,@"ordersExcellent.addressId":userAddressId,@"itemList[0].orItemsProductId":_productId,@"itemList[0].orItemsNum":[NSNumber numberWithInteger:1],};
        NSLog(@"commitBtnClick%@",para);
        [networking AFNPOST:SUBMITEXCELLENT withparameters:para success:^(NSMutableDictionary *dic) {
            NSLog(@"DCFillinOrderViewController:%@",dic);
            
            
            PaymentViewController *pvc = [[PaymentViewController alloc] init];
            pvc.goodImageViewStr = _goodImageViewStr;
            pvc.name = _name;
            pvc.price = _price;
            pvc.nameDetail = _nameDetail;
            
            
            
            pvc.orderID = [dic objectForKey:@"lianjiuData"];
            
            [self.navigationController pushViewController:pvc animated:YES];
            
            
            [MBProgressHUD showNotPhotoError:@"订单提交成功" toView:pvc.view];
            
            
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
