//
//  AddNewAddressVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/25.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "AddNewAddressVC.h"
#import "HXProvincialCitiesCountiesPickerview.h"

#import "HXAddressManager.h"

#import "UITextView+YLTextView.h"
#import "NewViewController.h"


@interface AddNewAddressVC ()

@property (nonatomic,strong) HXProvincialCitiesCountiesPickerview *regionPickerView;


@property (nonatomic, strong) AMapPOI *model;

@end

@implementation AddNewAddressVC
{
     BOOL isDefault;
}
#pragma mark--编辑时删除
-(void)editDeleteBtnPress{
     NSLog(@"editDeleteBtnPress");
    
    
    
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该地址?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        UIView *superView = [UIApplication sharedApplication].keyWindow;
        [MBProgressHUD showHUDAddedTo:superView animated:YES];
        [manager POST:[NSString stringWithFormat:@"%@/%@/%@/byUser",DELETEADRESS,_addressEditModel.userAddressId,_addressEditModel.userId] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideAllHUDsForView:superView animated:NO];
            
           
            
            NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
             NSLog(@"dict:%@",dict);
            
            NSNumber *code=dict[@"status"];
            int c = [code intValue];
            if (c==200) {
                
                [self.navigationController popViewControllerAnimated:YES];

            }else if (c==503) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                 [MBProgressHUD showSuccess:dict[@"msg"] toView:superView];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:superView animated:NO];
          [MBProgressHUD showError:@"网络不给力" toView:superView];
        }];
        
    }];
    [clear addAction:quXiao];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];
    
}

#pragma mark--添加新地址时--=       保存
-(void)AddSaveBtnPress{
    NSLog(@"Add--SaveBtnPress");
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    if (uid.length==0) {
        [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }
    
    if (_nameTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写收货人" toView:self.view];
        return;
    }
    if (_phoneTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写联系电话" toView:self.view];
        return;
    }
    if ([_addressBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showNotPhotoError:@"请选择地址" toView:self.view];
        return;
    }
    if (_menpaiTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写详细地址" toView:self.view];
        return;
    }
   
    
    NSDictionary *para = @{@"userId":uid,@"userAddressName":_nameTF.text,@"userAddressPhone":_phoneTF.text,@"userProvince":self.model.province,@"userCity":self.model.city,@"userDistrict":self.model.district,@"userLocation":[NSString stringWithFormat:@"%@",_menpaiTF.text],@"userDefault": [NSString stringWithFormat:@"%d",isDefault],@"latitude":[NSString stringWithFormat:@"%f",self.model.location.latitude],@"longitude":[NSString stringWithFormat:@"%f",self.model.location.longitude],@"userSite":self.model.name};
    
    
    
    [networking AFNPOST:ADDADRESS withparameters:para success:^(NSMutableDictionary *dic) {
        
        DCReceiverAdressViewController* dcrVC =nil;
        for(UIViewController* VC in self.navigationController.viewControllers){
            
            if([VC isKindOfClass:[DCReceiverAdressViewController class]]){
                dcrVC =(DCReceiverAdressViewController*) VC;
                
                [self.navigationController popToViewController:dcrVC animated:YES];
                
                [MBProgressHUD showNotPhotoError:@"添加新地址成功" toView:dcrVC.view];
                
                return ;
            }
        }

        
         NSLog(@"para:%@   dic %@",para,dic);
        
        if ([dic[@"lianjiuData"]isKindOfClass:[NSArray class]] ) {
            NSArray *array = dic[@"lianjiuData"];
            NSDictionary *addrDic = array.count>0?array[0]:@{};
            
            ShangMenFillinOrderVC* oneVC =nil;
            DCFillinOrderViewController* DCFilVC =nil;
            WeiXiuOrderViewController* WeiFilVC =nil;
            for(UIViewController* VC in self.navigationController.viewControllers){
                
                
                
                
                if([VC isKindOfClass:[ShangMenFillinOrderVC class]]){
                    
                    oneVC =(ShangMenFillinOrderVC*) VC;
                    if (array.count>0) {
                        oneVC.userDefault = YES;
                    }else{
                        oneVC.userDefault = NO;
                    }
                    
                    oneVC.address = addrDic;
                    [self.navigationController popToViewController:oneVC animated:YES];
                    
                }else if([VC isKindOfClass:[DCFillinOrderViewController class]]){
                    DCFilVC =(DCFillinOrderViewController*) VC;
                    if (array.count>0) {
                        DCFilVC.userDefault = YES;
                    }else{
                        DCFilVC.userDefault = NO;
                    }
                    
                    DCFilVC.address = addrDic;
                    [self.navigationController popToViewController:DCFilVC animated:YES];
                }else  if([VC isKindOfClass:[WeiXiuOrderViewController class]]){
                    WeiFilVC =(WeiXiuOrderViewController*) VC;
                    if (array.count>0) {
                        WeiFilVC.userDefault = YES;
                    }else{
                        WeiFilVC.userDefault = NO;
                    }
                    WeiFilVC.address = addrDic;
                    [self.navigationController popToViewController:WeiFilVC animated:YES];
                    
                }

                
                
            }


        }
        
        
      
        
        
        
      
        
        
        
       // [self.navigationController popViewControllerAnimated:YES];
        
    } error:^(NSError *error) {
        
    } HUDAddView:self.view];
//
    
    
    
    self.preVc.isRequestData = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isDefault = YES;
    
    if (_isEdit) {
        self.title = @"编辑地址";
        self.saveBtn.hidden = NO;
       // self.morenView.hidden = YES;
        self.nameTF.text = _addressEditModel.userAddressName?_addressEditModel.userAddressName:@"";
        self.phoneTF.text = _addressEditModel.userAddressPhone;
        [self.addressBtn setTitle:[NSString stringWithFormat:@"%@",_addressEditModel.userSite?_addressEditModel.userSite:@""] forState:UIControlStateNormal];
        
      
        self.menpaiTF.text = _addressEditModel.userLocation?_addressEditModel.userLocation:@"";
       
        
      
        
        
    }else{
        self.title = @"添加新地址";
       // self.morenView.hidden = NO;
        self.saveBtn.hidden = YES;
    }
    

    // 先初始化左边按钮控件，导航条左右按钮都是UIBarButtonItem这个类对象
    UIBarButtonItem* rightBtn;
    if (_isEdit) {
       rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(editDeleteBtnPress)];
    }else{
        rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(AddSaveBtnPress)];
        
    }
    
   
    // 把Leftbtn设置为导航条左边的按钮
    self.navigationItem.rightBarButtonItem = rightBtn;

   
   _menpaiTF.placeholder = @"例如:5楼504";
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addressBtnAction:(UIButton *)sender {
    
//    NSString *address = @"广东 深圳 南山区";
//    NSArray *array = [address componentsSeparatedByString:@" "];
//    
//    NSString *province = @"";//省
//    NSString *city = @"";//市
//    NSString *county = @"";//县
//    if (array.count > 2) {
//        province = array[0];
//        city = array[1];
//        county = array[2];
//    } else if (array.count > 1) {
//        province = array[0];
//        city = array[1];
//    } else if (array.count > 0) {
//        province = array[0];
//    }
//    
//    [self.regionPickerView showPickerWithProvinceName:province cityName:city countyName:county];
    
    NewViewController *mapVC = [[NewViewController alloc] init];
    
    
    mapVC.sendAMapAPIBlock = ^(AMapPOI *poi) {
        
        self.model = poi;
        
        [self.addressBtn setTitle:[NSString stringWithFormat:@"%@",poi.name] forState:UIControlStateNormal];

        
    };
    
     [self.navigationController pushViewController:mapVC animated:YES];
    
    
    NSLog(@"self.molel:%@", self.model);
    
   

    
}
#pragma mark-编辑时的保存
- (IBAction)saveBtnAction:(id)sender {
    NSLog(@"编辑时的保存");
    
    
    
   
    
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    if (uid.length==0) {
        [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }
    
    if (_nameTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写联系人" toView:self.view];
        return;
    }
    if (_phoneTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写联系电话" toView:self.view];
        return;
    }
    if ([_addressBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showNotPhotoError:@"请选择地址" toView:self.view];
        return;
    }
    if (_menpaiTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写门牌号" toView:self.view];
        return;
    }
    
    
    NSString *lat;
    NSString *lon;
//    self.model.location.latitude;
//    self.model.location.longitude;
    if (self.model.location.latitude>0) {
        lat = [NSString stringWithFormat:@"%f",self.model.location.latitude];
    }else{
        lat = _addressEditModel.latitude;
    }
    
    if (self.model.location.longitude>0) {
        lon = [NSString stringWithFormat:@"%f",self.model.location.longitude];
    }else{
        lon = _addressEditModel.longitude;
    }
    NSLog(@"lat:%f*lon%f",self.model.location.latitude,self.model.location.longitude);
    
    NSDictionary *para = @{@"userAddressId":_addressEditModel.userAddressId,@"userId":uid,@"userAddressName":_nameTF.text,@"userAddressPhone":_phoneTF.text,@"userProvince":self.model.province?self.model.province:_addressEditModel.userProvince,@"userCity":self.model.city?self.model.city:_addressEditModel.userCity,@"userDistrict":self.model.district?self.model.district:_addressEditModel.userDistrict,@"userLocation":[NSString stringWithFormat:@"%@",_menpaiTF.text],@"userDefault": [NSString stringWithFormat:@"%d",isDefault],@"latitude":lat,@"longitude":lon,@"userSite":self.model.name?self.model.name:_addressEditModel.userSite};
    
     NSLog(@"para:%@",para);

    
    
    
    
    
    
    
    [networking AFNPOST:MODIFYADRESS withparameters:para success:^(NSMutableDictionary *dic) {
        
     
        [self.navigationController popViewControllerAnimated:YES];
        
    } error:^(NSError *error) {
    
    } HUDAddView:self.view];

    
    
    self.preVc.isRequestData = YES;
}

- (IBAction)morenSwitchAction:(id)sender {
    
     UISwitch* switchControl = sender;
    
    if (switchControl.on) {
        isDefault = YES;
    }else{
        isDefault = NO;
    }
    
}
- (HXProvincialCitiesCountiesPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[HXProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName) {
            __strong typeof(wself) self = wself;
            
            [self.addressBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName] forState:UIControlStateNormal];
            [self.addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           // self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}




@end
