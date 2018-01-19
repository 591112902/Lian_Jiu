//
//  LoginViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/12/5.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//
#import "LoginViewController.h"
#import "ForgotViewController.h"
#import "RegisterVC.h"

#import "PRJTabBarViewController.h"
#import "NSString+MD5.h"
#import "AccountModel.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

#import "WXApi.h"
#import "AppDelegate.h"

#import "BindingUser_ViewController.h"

// 微信AppId：wx567ca296081c4142
// 微信AppSecret：d0eb638f14f10dc9d21af7477a00f352

// QQ APPID：101435461
//    APPKey：115ddcb80ea744fa836ca78e260a3ab1
#define APP_ID @"101435461"
#define URL_APPID @"wx567ca296081c4142"
#define URL_SECRET @"41038de2813c51f3a4b9ac104d899a31"


@interface LoginViewController ()<TencentSessionDelegate, WXApiDelegate>
{
    UIButton *btnItem ;
    
    TencentOAuth *_tencentOAuth;
    NSMutableArray *_permissionArray;
    
    AppDelegate *appdelegate;
}
@property (strong, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *luaguage;
@property (strong, nonatomic) IBOutlet UIButton *forgotPassword;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;



// 第三方登录请求参数
@property (nonatomic, strong) NSString *openId;

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *pricture;

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // static dispatch_once_t onceToken;
    
    //  初次进入时 language
//    dispatch_once(&onceToken, ^{
//        
//         [_luaguage setTitle:@"Language" forState:UIControlStateNormal];
//        
//    });
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
  //  self.accountTF.text = [defaults objectForKey:@"email"]?[defaults objectForKey:@"email"]:[defaults objectForKey:@"phone"];
    
    
    if ([[defaults objectForKey:@"email"] isEqualToString:@""]) {
        self.accountTF.text = [defaults objectForKey:@"phone"];
    }else{
        self.accountTF.text = [defaults objectForKey:@"email"];
        
    }
    
   
    self.accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.text = [defaults objectForKey:@"www"];
    self.passwordTF.secureTextEntry  = YES;
    btnItem= [UIButton buttonWithType:UIButtonTypeCustom];
    btnItem.frame =CGRectMake(self.view.frame.origin.x,0, BOUND_WIDTH-540, BOUND_HIGHT-550);
    btnItem.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;// 让其他语言可以显示
    [btnItem addTarget: self action: @selector(cansel) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:btnItem];
    self.navigationItem.leftBarButtonItem=item;
    
    // 开始显示language
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
//
//    static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//        [_luaguage setTitle:@"Language" forState:UIControlStateNormal];
//    });
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 40)];
    [btn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    btn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 5);
    [btn addTarget:self action:@selector(PasswordMingWen:) forControlEvents:UIControlEventTouchUpInside];
    btn.highlighted = NO;
    
    self.passwordTF.rightView = btn;
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    
    _duanxindlBtn.layer.cornerRadius = 5;
    _duanxindlBtn.layer.borderColor = MAINColor.CGColor;
    _duanxindlBtn.layer.borderWidth = 1;
    self.title = @"登录";
//    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    [btnItem setTitle:@"取消" forState:UIControlStateNormal];
    
    
}

-(void)PasswordMingWen:(UIButton *)sender//  password 明文
{
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry  = !self.passwordTF.secureTextEntry;
}

- (void)cansel{
    if (self.isBackMain) {
        PRJTabBarViewController *tabar = (PRJTabBarViewController *)self.view.window.rootViewController;
        tabar.toIndex = 0;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)ForgotPpassword:(id)sender {
    ForgotViewController *forgotVC = [[ForgotViewController alloc] init];
    [self.navigationController pushViewController:forgotVC animated:YES];
}
- (IBAction)ToLogin:(id)sender {
//以下写会出现问题 text 不等于空  也可以  self.accountTF.text.length=0;

    
    if (self.accountTF.text.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请输入你的手机号码" toView:self.view];
        return;
    }
    if (self.passwordTF.text.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请输入你的密码" toView:self.view];
        return;
    }

    
    
    if (![self.accountTF.text isEqualToString:@""]&&![self.passwordTF.text isEqualToString:@""]) {
        if ([self CheckInputEail:self.accountTF.text]) {
//            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//            NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            NSString *deviceTokenStr =[defaults objectForKey:@"plusToken"];
//            NSString *str = @"";
//#if TARGET_IPHONE_SIMULATOR
//            
//              str = @"111";
//#else
//              str = @"888888888888888888888888888888";
//
//#endif
//            deviceTokenStr = deviceTokenStr?deviceTokenStr:str;
//            
//            
//          //  NSLog(@"currentVersion%@",currentVersion);
//            
//            NSDictionary *parameters = @{@"name":self.accountTF.text,@"pwd":self.passwordTF.text,@"equipment":@"IOS",@"edition":currentVersion,@"token":deviceTokenStr};
          //  [NSString stringWithFormat:@"%@/%@/%@",LOGIN,self.accountTF.text,self.passwordTF.text];
            
            [networking AFNPOSTNotCode:[NSString stringWithFormat:@"%@/%@/%@/%@",LOGIN,self.accountTF.text,self.passwordTF.text,@"2"] withparameters:nil success:^(NSMutableDictionary *dic) {
//                HZLog(@"%@---%@",dic,dic[@"message"]);
                NSNumber *code=dic[@"status"];
                if ([code isEqualToNumber:@200]) {
                    NSDictionary *responseDic = dic[@"lianjiuData"];
                    [MBProgressHUD showSuccess:@"登录成功" toView:self.view.window];
                    
                    NSLog(@"%@   %@ %@ ",dic,responseDic[@"userId"],responseDic[@"userPhone"]);
                    [defaults setObject:responseDic[@"username"] forKey:@"username"];
                    [defaults setObject:responseDic[@"userPhone"] forKey:@"userPhone"];
                    [defaults setObject:responseDic[@"userId"] forKey:@"userId"];
                   // [defaults setObject:parameters[@"pwd"] forKey:@"www"];
                   
                    [defaults setBool:YES forKey:@"islogin"];
                    [defaults setObject:[NSDate date] forKey:@"loginDate"];
                    [self queryReadNameID];
                    [self queryBdyhkID];
                    [defaults synchronize];
                    AccountModel *model = [AccountModel ModelWith:responseDic];
                    [NSKeyedArchiver archiveRootObject:model toFile:ACCOUNTPATH];
                    
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    
                
                    
                    
                }else if([code isEqualToNumber:@2]){
                    [MBProgressHUD showError:@"网络不给力,重新启动应用试试" toView:self.view];
                }else{

//                    [MBProgressHUD showError:dic[@"message"] toView:self.view];
                      [MBProgressHUD showError:dic[@"msg"] toView:self.view];


                }
                
            } error:nil HUDAddView:self.view];
           
        }
        
    }else{
        [MBProgressHUD showNotPhotoError:@"账户或密码不能为空" toView:self.view];
    }
}



//4、判断邮箱
- (BOOL)CheckInputEail:(NSString *)text {
//    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//
//
//    if (![emailTest evaluateWithObject:text]) {
//        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"您输入的账号不存在", nil) toView:[UIApplication sharedApplication].keyWindow];
//        return NO;
//    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.accountTF) {
        [self.passwordTF becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


- (IBAction)dxLoginAction:(id)sender {
    
//    SetUpMimaViewController *svc = [[SetUpMimaViewController alloc] init];
//    svc.isTiaoGou = YES;
//    [self.navigationController pushViewController:svc animated:YES];

    DXLoginViewController *dx = [[DXLoginViewController alloc] init];
    
    [self.navigationController pushViewController:dx animated:YES];
    
    
}

#pragma mark --- QQ登录

- (IBAction)qqLoginAction:(id)sender {
    
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:APP_ID andDelegate:self];
    
    //设置权限数据 ， 具体的权限名，在sdkdef.h 文件中查看。
    _permissionArray = [NSMutableArray arrayWithObjects: kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,nil];
    
    //登录操作
    [_tencentOAuth authorize:_permissionArray inSafari:NO];
    
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    
    /** Access Token凭证，用于后续访问各开放接口 */
    if (_tencentOAuth.accessToken) {
        
        //获取用户信息。 调用这个方法后，qq的sdk会自动调用
        //- (void)getUserInfoResponse:(APIResponse*) response
        //这个方法就是 用户信息的回调方法。
        [_tencentOAuth getUserInfo];
        
        self.openId = _tencentOAuth.openId;
       
        self.openId = _tencentOAuth.openId;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: @"1", @"type", self.openId, @"openId",@"2",@"udetailsEquipment",nil];
        NSLog(@"++++++++++%@", dict);
        
        [networking AFNPOSTNotHUD:[NSString stringWithFormat:@"%@", QWLOGIN] withparameters:dict success:^(NSMutableDictionary *dic) {
            
             NSLog(@"QWLOGIN++++++++++%@", dic);
            
            if ([dic[@"status"] integerValue]== 500) {
                // 新用户
                BindingUser_ViewController *bingVC = [[BindingUser_ViewController alloc] init];
                bingVC.openId = self.openId?self.openId:@"";
                bingVC.QWnickname = self.nickname?self.nickname:@"";
                bingVC.pictrue = self.pricture?self.pricture:@"";
                
               //[self presentViewController:bingVC animated:YES completion:nil];
                
                [MBProgressHUD showNotPhotoError:@"请绑定您的手机号吗" toView:bingVC.view];
                
                [self.navigationController pushViewController:bingVC animated:YES];
            } else if ([dic[@"status"] integerValue]== 200) {
                // 老用户
                
                NSDictionary *responseDic = dic[@"lianjiuData"];
                [MBProgressHUD showSuccess:@"登录成功" toView:self.view.window];
                NSLog(@"%@   %@ %@ ",dic,responseDic[@"userId"],responseDic[@"userPhone"]);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:responseDic[@"username"] forKey:@"username"];
                [defaults setObject:responseDic[@"userPhone"] forKey:@"userPhone"];
                [defaults setObject:responseDic[@"userId"] forKey:@"userId"];
                
                [defaults setBool:YES forKey:@"islogin"];
                [defaults setObject:[NSDate date] forKey:@"loginDate"];
                [defaults synchronize];
                
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }

        } error:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
        
        
    }else{
        
        NSLog(@"accessToken 没有获取成功");
    }
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
    }else{
        NSLog(@"其他原因， 导致登录失败");
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog(@"没有网络了， 怎么登录成功呢");
}

/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    
    // incrAuthWithPermissions是增量授权时需要调用的登录接口
    // permissions是需要增量授权的权限列表
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO; // 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}

/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    return YES;
}

/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
    NSLog(@"增量授权完成");
    if (tencentOAuth.accessToken
        && 0 != [tencentOAuth.accessToken length])
    { // 在这里第三方应用需要更新自己维护的token及有效期限等信息
        // **务必在这里检查用户的openid是否有变更，变更需重新拉取用户的资料等信息** _labelAccessToken.text = tencentOAuth.accessToken;
    }
    else
    {
        NSLog(@"增量授权不成功，没有获取accesstoken");
    }
    
}

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
- (void)tencentFailedUpdate:(UpdateFailType)reason{
    
    switch (reason)
    {
        case kUpdateFailNetwork:
        {
            //            _labelTitle.text=@"增量授权失败，无网络连接，请设置网络";
            NSLog(@"增量授权失败，无网络连接，请设置网络");
            break;
        }
        case kUpdateFailUserCancel:
        {
            //            _labelTitle.text=@"增量授权失败，用户取消授权";
            NSLog(@"增量授权失败，用户取消授权");
            break;
        }
        case kUpdateFailUnknown:
        default:
        {
            NSLog(@"增量授权失败，未知错误");
            break;
        }
    }
    
    
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response{
    NSLog(@" *****+ response %@ - %@ - %@",response.message,response.jsonResponse[@"nickname"],response.jsonResponse[@"figureurl_qq_2"]);
    
    self.nickname = response.jsonResponse[@"nickname"];
    self.pricture = response.jsonResponse[@"figureurl_qq_2"];
    
}


#pragma mark --- 微信登录

- (IBAction)wxLoginAction:(id)sender {
   // if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.openID = URL_APPID;
        req.state = @"1245";
        appdelegate = [UIApplication sharedApplication].delegate;
        appdelegate.wxDelegate = self;
        
        [WXApi sendReq:req];
   // }else{
        //把微信登录的按钮隐藏掉。
   // }
}

#pragma mark 微信登录回调。
-(void)loginSuccessByCode:(NSString *)code{
    NSLog(@"code %@",code);
    __weak typeof(*&self) weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
    //通过 appid  secret 认证code . 来发送获取 access_token的请求
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",URL_APPID,URL_SECRET,code] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {  //获得access_token，然后根据access_token获取用户信息请求。
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic %@",dic);
        
        /*
         access_token	接口调用凭证
         expires_in	access_token接口调用凭证超时时间，单位（秒）
         refresh_token	用户刷新access_token
         openid	授权用户唯一标识
         scope	用户授权的作用域，使用逗号（,）分隔
         unionid	 当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
         */
        NSString* accessToken=[dic valueForKey:@"access_token"];
        NSString* openID=[dic valueForKey:@"openid"];
        [weakSelf requestUserInfoByToken:accessToken andOpenid:openID];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.localizedFailureReason);
    }];
    
}

-(void)requestUserInfoByToken:(NSString *)token andOpenid:(NSString *)openID{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //开发人员拿到相关微信用户信息后， 需要与后台对接，进行登录
        NSLog(@"login success dic  ==== %@",dict);
        
        
        NSString *wxopenid = dict[@"openid"];
        if (wxopenid.length>0) {
            [networking AFNPOSTNotHUD:[NSString stringWithFormat:@"%@", QWLOGIN] withparameters:@{@"openId":wxopenid,@"type":@"0",@"udetailsEquipment":@"2"} success:^(NSMutableDictionary *dic) {
            if ([dic[@"status"] integerValue]== 501) {
                // 新用户
                BindingUser_ViewController *bingVC = [[BindingUser_ViewController alloc] init];
                bingVC.openId = dict[@"openid"];
                bingVC.QWnickname = dict[@"nickname"];
                bingVC.pictrue = dict[@"headimgurl"];
                bingVC.isWeiXin = @"isWeiXin";
                // [self presentViewController:bingVC animated:YES completion:nil];
                
                [MBProgressHUD showNotPhotoError:@"请绑定您的手机号吗" toView:bingVC.view];
                
                [self.navigationController pushViewController:bingVC animated:YES];
            } else if ([dic[@"status"] integerValue]== 200) {
                // 老用户
                
                NSDictionary *responseDic = dic[@"lianjiuData"];
                [MBProgressHUD showSuccess:@"登录成功" toView:self.view.window];
                NSLog(@"%@   %@ %@ ",dic,responseDic[@"userId"],responseDic[@"userPhone"]);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:responseDic[@"username"] forKey:@"username"];
                [defaults setObject:responseDic[@"userPhone"] forKey:@"userPhone"];
                [defaults setObject:responseDic[@"userId"] forKey:@"userId"];
                
                [defaults setBool:YES forKey:@"islogin"];
                [defaults setObject:[NSDate date] forKey:@"loginDate"];
                [defaults synchronize];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
            
        } error:^(NSError *error) {
            NSLog(@"error = %@", error);
        }];
        
        
    }else{
    
        NSLog(@"accessToken 没有获取成功");
    }

        
//        //提示框
//        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",dic] preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        
//        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [clear addAction:quXiao];
//        [clear addAction:queRen];
//        [self presentViewController:clear animated:YES completion:nil];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %ld",(long)error.code);
    }];
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
                    [defaults setBool:YES forKey:@"isRealName"];
                    
                    NSDictionary *lianjiuData = dict[@"lianjiuData"];
                    [defaults setObject:lianjiuData forKey:@"realNameDic"];
                }
            }else if (c==400){
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
                    [defaults setBool:YES forKey:@"isBdyhk"];
                    
                    NSDictionary *lianjiuData = dict[@"lianjiuData"];
                    [defaults setObject:lianjiuData forKey:@"bdyhkDic"];
                }
            }else if (c==400){
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
