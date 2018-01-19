

#import "PRJTabBarViewController.h"
#import "LianjiuMoneyVC.h"
#import "LjMoney2TableViewCell.h"
#import "LjMoneyTableViewCell.h"
#import "LoginViewController.h"
#import "AccountModel.h"
#import "FDAlertView.h"
#import "CustomMessageView.h"
#import "MJRefresh.h"


#define SCREENWIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREENHEIGHT ([[UIScreen mainScreen] bounds].size.height)


//#import "ReleaseTableViewController.h"
@interface LianjiuMoneyVC ()<UITableViewDataSource,UITableViewDelegate,sendTheValueDelegate>

@property (nonatomic,strong)AccountModel *userModel;
@property (nonatomic,strong)NSString *userAssetZCStr;
@end

@implementation LianjiuMoneyVC
{
    CustomMessageView * contentView;
    FDAlertView *alert;
    UITableView *_tableView;
    NSMutableArray *_dataSouc;
    NSMutableArray *_headDataSouc;
    UILabel *balbel;//消息个数
    AccountModel *model;
    BOOL isRealName;
    NSMutableArray *realNameArr;
    BOOL isBdyhk;
    NSMutableArray *bdyhkArr;
    NSString *code;
    BOOL isDown;
}
#pragma mark----提现按钮提现按钮
//提现按钮
-(void)txBtnClick{
    
    if (_userAssetZCStr.floatValue<=0) {
        [MBProgressHUD showNotPhotoError:@"您没有可用来提现的资产了" toView:self.view];
        return;
    }
    
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userNP = [def objectForKey:@"username"];
    NSString *uid = [def objectForKey:@"userId"];
    
    if (userNP.length>7) {
        userNP = [userNP stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    [networking AFNPOST:[NSString stringWithFormat:@"%@",TXSENDSMS] withparameters:@{@"userId":uid} success:^(NSMutableDictionary *dic) {
        
        code = dic[@"lianjiuData"];
        NSLog(@"获取验证码:%@",dic);
        alert = [[FDAlertView alloc] init];
        contentView=[[CustomMessageView alloc]initWithFrame:CGRectMake(0, 0, 290, 170)];
        contentView.delegate=self;
        //contentView.frame = CGRectMake(0, 0, 320, 160);
        alert.contentView = contentView;
        [alert show];
        contentView.titleLab.text = @"钱包验证";
        contentView.contentLab.text=[NSString stringWithFormat:@"已经向%@发送验证码,请输入验证码",userNP];
        [contentView.authCodeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
        
    } error:^(NSError *error) {
        
    } HUDAddView:self.view];
    
}

-(void)getCodeAction{
     NSLog(@"getCodeAction:%@",contentView.messageField.text);
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //NSString *userNP = [def objectForKey:@"username"];
    NSString *uid = [def objectForKey:@"userId"];

    [networking AFNPOST:[NSString stringWithFormat:@"%@",TXSENDSMS] withparameters:@{@"userId":uid} success:^(NSMutableDictionary *dic) {
        
        [MBProgressHUD showNotPhotoError:@"发送成功" toView:self.view];
//        code = dic[@"lianjiuData"];
//        NSLog(@"获取验证码:%@",dic);
//        alert = [[FDAlertView alloc] init];
//        contentView=[[CustomMessageView alloc]initWithFrame:CGRectMake(0, 0, 290, 170)];
//        contentView.delegate=self;
//        //contentView.frame = CGRectMake(0, 0, 320, 160);
//        alert.contentView = contentView;
//        [alert show];
//        contentView.titleLab.text = @"钱包验证";
//        contentView.contentLab.text=[NSString stringWithFormat:@"已经向%@发送验证码,请输入验证码",userNP];
//        [contentView.authCodeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    } error:^(NSError *error) {
        
    } HUDAddView:self.view];
}
//点击确认后调用==
-(void)getTimeToValue:(NSString *)theTimeStr
{
    NSLog(@"文本框里的值是：%@",theTimeStr);
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    [networking AFNPOST:TXCHECKWSMS withparameters:@{@"userId":uid,@"code":theTimeStr} success:^(NSMutableDictionary *dic) {
        
        FDAlertView *alertt = (FDAlertView *)contentView.superview;
        [alertt hide];
        TXVC *tvc = [[TXVC alloc] init];
        [self.navigationController pushViewController:tvc animated:YES];
        
    } error:nil HUDAddView:self.view];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if (alert)
    {
        [alert hide];
    }
    
}


- (void) keyboardWillShow1:(NSNotification *)notify {
    
    CGFloat kbHeight = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    
    NSLog(@"键盘出来了");
    
    [UIView animateWithDuration:0.3 animations:^{
        
        alert.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-kbHeight);
        alert.contentView.center=alert.center;
        
    }];
    
    
    
}


- (void) keyboardWillHidden2:(NSNotification *)notify {
    
    
    
    NSLog(@"键盘下去了");
    
    [UIView animateWithDuration:0.3 animations:^{
        
        alert.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        alert.contentView.center=alert.center;
        
    }];
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"链旧钱包";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow1:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘即将消失的事件. UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden2:) name:UIKeyboardWillHideNotification object:nil];

    
    
  
     [self addTableView];
    
    
    
    UIButton *txBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    txBtn.frame = CGRectMake(0, BOUND_HIGHT-44, BOUND_WIDTH, 44);
    
    [txBtn setTitle:@"提现" forState:UIControlStateNormal];
    [txBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [txBtn addTarget:self action:@selector(txBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [txBtn setBackgroundColor:MAINColor];
    [self.view addSubview:txBtn];

    
    
    
    _dataSouc = [[NSMutableArray alloc] init];
    _headDataSouc = [[NSMutableArray alloc] init];
    
    [self requestData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    realNameArr = [[NSMutableArray alloc] init];
    bdyhkArr = [[NSMutableArray alloc] init];
    [self queryReadNameID];
    [self queryBdyhkID];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    BOOL islogin = [defaults boolForKey:@"islogin"];
//    if (!islogin) {
//        self.isRequestData = YES;
//        LoginViewController *loginVc = [[LoginViewController alloc] init];
//        loginVc.isBackMain = YES;
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
//        [self.tabBarController presentViewController:nav animated:YES completion:^{
//            
//        }];
//    }else{
//        
//        if (self.isRequestData) {
//            [self addUserDetail];
//  
//        }
//    }
}

#pragma mark -data
//-(AccountModel *)userModel{
//    if (_userModel==nil) {
//        _userModel=[[AccountModel alloc]init];
//    }
//    return _userModel;
//}



-(void)requestData
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *vip = [def objectForKey:@"userId"];
    
    NSLog(@"userId%@",vip);
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",SELECTASSETDETAILS,vip] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"%@",dic);
        
        if (isDown) {
            [_headDataSouc removeAllObjects];
            [_dataSouc removeAllObjects];
        }

        
        
        
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *lianjiuData = dic[@"lianjiuData"];
             [_headDataSouc addObject:lianjiuData];
            
            if ([lianjiuData[@"list"] isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *temp in lianjiuData[@"list"]) {
                    
                    [_dataSouc addObject:temp];
                    
                }
            }

        }
       
       
        
         [_tableView reloadData];
    } error:nil HUDAddView:self.view];
    
    
//    [networking AFNPOSTNotCode:@"" withparameters:@{@"vip":vip} success:^(NSMutableDictionary *dic) {
//
////        NSNumber *code=dic[@"code"];
////        if ([code isEqualToNumber:@0]) {
////            NSDictionary *response = dic[@"response"];
////            self.zuJi = response[@"zjtj"];
////            _souCang = response[@"sctj"];
////            self.xiaoXi = response[@"MessAge"];
////            self.isHuiShouShang = response[@"HS"];
////#pragma 帐号信息 余额查询网络请求
////            self.userModel = [AccountModel ModelWith:response[@"user"]];
////
////            [_tableView reloadData];
////            self.isRequestData = NO;
////            [NSKeyedArchiver archiveRootObject:self.userModel toFile:ACCOUNTPATH];
////            
////        }else{
////            if ([code isEqualToNumber:@-2]) {
////                [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请重新登录", nil) toView:self.view];
////                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////                //                    [defaults removeObjectForKey:@"vip"];
////                //                    [defaults removeObjectForKey:@"sessionid"];
////                [defaults setObject:@"" forKey:@"vip"];
////                [defaults setBool:NO forKey:@"islogin"];
////                [defaults setBool:NO forKey:@"isRealName"];
////                [defaults synchronize];
////                //    删除归档模型
////                NSFileManager *defaultManager = [NSFileManager defaultManager];
////                if ([defaultManager isDeletableFileAtPath:ACCOUNTPATH]) {
////                    [defaultManager removeItemAtPath:ACCOUNTPATH error:nil];
////                }
////            }
////     
////            self.userModel=[NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNTPATH];
////            [_tableView reloadData];
////            
////        }
//    } error:^(NSError *error) {
//        self.userModel=[NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNTPATH];
//        [_tableView reloadData];
//        
//    } HUDAddView:self.view];
}

-(void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT-64-44) style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [_tableView registerNib:[UINib nibWithNibName:@"LjMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"LjMoneyTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"LjMoney2TableViewCell" bundle:nil] forCellReuseIdentifier:@"LjMoney2TableViewCell"];
   
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = BGColor;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    __weak UITableView *tableView = _tableView;
    WS(weakSelf);
    //下拉刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        isDown = YES;
        [weakSelf requestData];
        // 结束刷新
        [tableView.header endRefreshing];
    }];
   // [tableView.header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
    
}
#pragma mark - tabelViewDegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
       return _dataSouc.count;
    }
    
   
}

//实名认证
-(void)smrzBtnAction{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL def_isRealName = [defaults boolForKey:@"isRealName"];
//    BOOL def_isBdyhk = [defaults boolForKey:@"isBdyhk"];
//    NSDictionary *bdyhkDic = [defaults objectForKey:@"bdyhkDic"];
    NSDictionary *realNameDic = [defaults objectForKey:@"realNameDic"];
    
    if (def_isRealName) {
       
        SmrzViewController *svc = [[SmrzViewController alloc] init];
        svc.smrzDic = realNameDic;
        svc.isSMRZ = def_isRealName;
        [self.navigationController pushViewController:svc animated:YES];
        
        
        
    }else{
        SmrzViewController *svc = [[SmrzViewController alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
    }
    
   
    
}
//绑定银行卡
-(void)bdyhkBtnAction{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL def_isRealName = [defaults boolForKey:@"isRealName"];
    BOOL def_isBdyhk = [defaults boolForKey:@"isBdyhk"];
    NSDictionary *bdyhkDic = [defaults objectForKey:@"bdyhkDic"];
    NSDictionary *realNameDic = [defaults objectForKey:@"realNameDic"];
    
    if (def_isRealName) {//shiming l
        if (def_isBdyhk) {//bangding l
            
            YetBdyhkViewController *svc = [[YetBdyhkViewController alloc] init];
            svc.bdyhkDic = bdyhkDic;
            svc.isBdyhk = def_isBdyhk;
            
            svc.smrzDic = realNameDic;
            svc.isSMRZ = def_isRealName;

            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            BdyhkViewController *svc = [[BdyhkViewController alloc] init];
            svc.smrzDic = realNameDic;
            svc.isSMRZ = def_isRealName;
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else{
        [MBProgressHUD showNotPhotoError:@"请先进行实名认证" toView:self.view];
    }
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        LjMoney2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LjMoney2TableViewCell"];
        
        
        
        [cell.smrzBtn addTarget:self action:@selector(smrzBtnAction) forControlEvents:UIControlEventTouchUpInside];
       
         [cell.bdyhkBtn addTarget:self action:@selector(bdyhkBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (_headDataSouc.count>0) {
            
            cell.accumulatedAmountL.text = [NSString stringWithFormat:@"%@元",[_headDataSouc[0] objectForKey:@"accumulatedAmount"]];//赚取
            cell.walletDrawingL.text =  [NSString stringWithFormat:@"%@元",[_headDataSouc[0] objectForKey:@"walletDrawing"]];//提现中
             cell.userAssetL.text =  [NSString stringWithFormat:@"%@元",[_headDataSouc[0] objectForKey:@"userAsset"]];//资产
            
            _userAssetZCStr = [NSString stringWithFormat:@"%@",[_headDataSouc[0] objectForKey:@"userAsset"]];//资产
        }
        
        
        return cell;
    }else{
        LjMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LjMoneyTableViewCell"];
        
        
        
        if (_dataSouc.count>0) {
            
           // _dataSouc[indexPath.row];
            
            NSString *isIncome =  [NSString stringWithFormat:@"%@",[_dataSouc[indexPath.row] objectForKey:@"isIncome"]];
            
            NSString *price =  [NSString stringWithFormat:@"%@元",[_dataSouc[indexPath.row] objectForKey:@"recordPrice"]];
            
            cell.timeL.text = [NSString stringWithFormat:@"%@",[_dataSouc[indexPath.row] objectForKey:@"recordUpdated"]];
            
       
            
//            
//            上门回收获得50元     5
//            快递回收获得80元     6
//            微信提现100元       0
//            支付宝提现100元      1
//            银行卡提现100元      2
//            钱包支付            4
            
            if ([isIncome isEqualToString:@"0"]) {
                cell.label.text =  [NSString stringWithFormat:@"- 微信提现%@",price];
            }else if ([isIncome isEqualToString:@"1"]) {
                cell.label.text =  cell.label.text =  [NSString stringWithFormat:@"微信待提现%@",price];
            }else if ([isIncome isEqualToString:@"2"]) {
                cell.label.text =   [NSString stringWithFormat:@"- 银行卡提现%@",price];
            }else if ([isIncome isEqualToString:@"3"]) {
                cell.label.text =   [NSString stringWithFormat:@"- 回收支付%@",price];
            }else if ([isIncome isEqualToString:@"4"]) {
                cell.label.text =  [NSString stringWithFormat:@"- 钱包支付%@",price];
            }else if ([isIncome isEqualToString:@"5"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 上门回收获得%@",price];
            }else if ([isIncome isEqualToString:@"6"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 快递回收获得%@",price];
            }else if ([isIncome isEqualToString:@"7"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 恋旧优品退款%@",price];
            }else if ([isIncome isEqualToString:@"8"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 钱包退款%@",price];
            }else if ([isIncome isEqualToString:@"9"]) {
                cell.label.text =  [NSString stringWithFormat:@"银行卡待提现%@",price];
            }else if ([isIncome isEqualToString:@"10"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 推荐注册奖励%@",price];
            }else if ([isIncome isEqualToString:@"11"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 推荐快递回收%@",price];
            }else if ([isIncome isEqualToString:@"12"]) {
                cell.label.text =  [NSString stringWithFormat:@"- 家具处理支付%@",price];
            }else if ([isIncome isEqualToString:@"13"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 家具处理获得%@",price];
            }else if ([isIncome isEqualToString:@"14"]) {
                cell.label.text =  [NSString stringWithFormat:@"- 押金处罚%@",price];
            }else if ([isIncome isEqualToString:@"15"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 押金充值%@",price];
            }else if ([isIncome isEqualToString:@"16"]) {
                cell.label.text =  [NSString stringWithFormat:@"+ 大宗交易获得%@",price];
            }
        }
      
        
//        NSArray *arr = _dataSouc[indexPath.section];
//        NSDictionary *dic = arr[indexPath.row];
//        cell.label.text = [dic allKeys].lastObject;
//        cell.image.contentMode = UIViewContentModeScaleAspectFit;
//        cell.image.image = [UIImage imageNamed:dic[[dic allKeys].lastObject]];
      //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
       return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 165;
    }else if (indexPath.section==1){
        return 50;
    }else{
        
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section>1) {
//        NSArray *arr = _dataSouc[indexPath.section];
//        NSDictionary *dic = arr[indexPath.row];
//        model= self.userModel?self.userModel:[[AccountModel alloc] init];
//        UIViewController *view;
//        if (indexPath.section==2) {
//            
//            if (indexPath.row==0) {
//                AuthenticateViewController *VC = [[AuthenticateViewController alloc] init];
//                VC.userModel = model;
//                [tableView deselectRowAtIndexPath:indexPath animated:NO];
//                view = VC;
//                
//            }else{
//                AccountInformationViewController *VC = [[AccountInformationViewController alloc] init];
//                VC.userModel = model;
//                [tableView deselectRowAtIndexPath:indexPath animated:NO];
//                view =VC;
//            }
//            
//        }else if(indexPath.section==3){
//            self.isRequestData = YES;
//            
//            if (indexPath.row==0) {
//                
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                BOOL islogin = [defaults boolForKey:@"islogin"];
//                if (islogin) {
//                    ReleaseTableViewController *releaseVC = [[ReleaseTableViewController alloc] init];
//                    releaseVC.userModel=model;
//                    view=releaseVC;
//                    releaseVC.hidesBottomBarWhenPushed = YES;
//                    
//                }else{
//                    [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请先登录", nil) toView:self.view];
//                }}
//            else if  (indexPath.row==1) {
//                MyOrderViewController *VC = [[MyOrderViewController alloc] init];
//                view =VC;
//            }
//            else{
//                view = [[BidmanageViewController alloc] init];
//            }
//        }else{
//            
//            if (indexPath.row==0) {
//                CreditViewController *VC = [[CreditViewController alloc] init];
//                [tableView deselectRowAtIndexPath:indexPath animated:NO];
//                VC.userModel = model;
//                view = VC;
//            }
//            else if(indexPath.row==1){
//                BalanceViewController *VC = [[BalanceViewController alloc] init];
//                [tableView deselectRowAtIndexPath:indexPath animated:NO];
//                VC.userModel = model;
//                view = VC;
//            }
//            else{
//                view = [[SetUpViewController alloc] init];
//                [tableView deselectRowAtIndexPath:indexPath animated:NO];
//            }
//            
//        }
//        view.hidesBottomBarWhenPushed = YES;
//        view.title = [dic allKeys].lastObject;
//        [self.navigationController pushViewController:view animated:YES];
    }
}

//#warning 查询是否已经实名认证
-(void)queryReadNameID{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [defaults boolForKey:@"islogin"];
    NSString *vip = [defaults objectForKey:@"userId"];
    if (!islogin) {
        return;
    }else{
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        UIView *superView = [UIApplication sharedApplication].keyWindow;
        [manager GET:[NSString stringWithFormat:@"%@/%@",ISCERTIFICATION,vip] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSNumber *status=dict[@"status"];
            int c = [status intValue];
            if (c==200) {
                if ([dict[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
                    isRealName = YES;
                    [defaults setBool:YES forKey:@"isRealName"];
                    
                    NSDictionary *lianjiuData = dict[@"lianjiuData"];
                    [realNameArr addObject:lianjiuData];
                    
                    [defaults setObject:lianjiuData forKey:@"realNameDic"];
                }
            }else if (c==400){
                isRealName = NO;
                [defaults setBool:NO forKey:@"isRealName"];
            }else{
                 [MBProgressHUD showNotPhotoError:dict[@"msg"] toView:superView];
            }
            [defaults synchronize];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}
//#warning 查询是否yhk
-(void)queryBdyhkID{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [defaults boolForKey:@"islogin"];
    NSString *vip = [defaults objectForKey:@"userId"];
    if (!islogin) {
        return;
    }else{
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        UIView *superView = [UIApplication sharedApplication].keyWindow;
        [manager GET:[NSString stringWithFormat:@"%@/%@",ISUSERBANKCARD,vip] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSNumber *status=dict[@"status"];
            int c = [status intValue];
            if (c==200) {
                if ([dict[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
                    isBdyhk = YES;
                    [defaults setBool:YES forKey:@"isBdyhk"];
                    
                    NSDictionary *lianjiuData = dict[@"lianjiuData"];
                    [bdyhkArr addObject:lianjiuData];
                    
                    [defaults setObject:lianjiuData forKey:@"bdyhkDic"];
                }
            }else if (c==400){
                isBdyhk = NO;
                 [defaults setBool:NO forKey:@"isBdyhk"];
            }else{
                [MBProgressHUD showNotPhotoError:dict[@"msg"] toView:superView];
            }
            
            [defaults synchronize];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}


@end
