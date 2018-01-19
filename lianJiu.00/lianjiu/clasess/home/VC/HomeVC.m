//
//  HomeVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/8/24.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "HomeVC.h"
#import "SDCycleScrollView.h"
#import "CQMarqueeView.h"
#import "LLSearchViewController.h"
//#import "HRAdView.h"
#import <CoreLocation/CoreLocation.h>
#import "SGAdvertScrollView.h"

#define SYMAINColor [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1.0]//100 214 46




@interface HomeVC ()<SDCycleScrollViewDelegate,CQMarqueeViewDelegate,SGAdvertScrollViewDelegate,CLLocationManagerDelegate,UIScrollViewDelegate>
{
    UIButton* leftBtn;
    CLLocationManager *_locationManager;//定位属性必须是全局的
    UIScrollView *_scrollV;CGFloat _scrollVH;SDCycleScrollView *cycleScrollView;NSMutableArray *scrollPhotoList;NSMutableArray *adHotTopicsArr;NSMutableArray *lianjiuTouTiaoArr;
    
    NSString *hotPicture0;NSString *hotPicture1;NSString *hotPicture2;NSString *hotPicture3;NSString *hotPicture4;NSString *hotPicture5;//没用到
    NSString *hotTitle0;NSString *hotTitle1;NSString *hotTitle2;NSString *hotTitle3;NSString *hotTitle4;NSString *hotTitle5;
    NSString *proPrice0;NSString *proPrice1;NSString *proPrice2;NSString *proPrice3;NSString *proPrice4;NSString *proPrice5;////没用到
    
    UILabel *ttleftLabel;//卖手机
    UILabel *ttleftLabel2;//拒接脸盆换手机
    UIImageView *leftIV;//卖手机图片图片
    
    UIImageView *rightIV;//卖家电图片图片
    UILabel *rightSLabel;//卖家电
    UILabel *rightSLabel2;//丢掉麻烦,不如卖了
    
    UILabel *rightXLabel;//@"卖废品"
    UILabel *rightXLabel2;//这些也值钱
    UIImageView *rightXIV;//卖废品图片
    
    
    UIImageView *hmLeftIV;//adHotProduct1--1
    UILabel *hmleftLabel;//adHotProduct1--1苹果iPhone8
    UILabel *hmleftLabel2;//adHotProduct1--1最高回收价
    
    UIImageView *hmRightIV;//adHotProduct1--2
    UILabel *hmRightLabel;//adHotProduct1--2苹果iPhone8
    UILabel *hmRightLabel2;//adHotProduct1--2最高回收价
    
    
    UIImageView *hotBottomIV;//adHotProduct2--1
    UILabel *hotBLabel;//adHotProduct2--1苹果iPad
    UILabel *hotBLabel2;//adHotProduct2--1最高回收价

    
    UIImageView *hotBottomIVtwo;//adHotProduct2--2
    UILabel *hotBLabelTwo;//adHotProduct2--2苹果iPad
    UILabel *hotBLabelTwo2;//adHotProduct2--2最高回收价
    
    UIImageView *hotBottomIVthird;//adHotProduct2--3
    UILabel *hotBLabelThird;//adHotProduct2--3苹果iPad
    UILabel *hotBLabelThird2;//adHotProduct2--3最高回收价

    
    UIImageView *hotBottomIVfour;//adHotProduct2--4
    UILabel *hotBLabelFour;//adHotProduct2--4苹果iPad
    UILabel *hotBLabelFour2;//adHotProduct2--4最高回收价
    
    
    UIImageView *kxLeftIV;//手机维修
    UILabel *kxleftLabel;//手机维修
    UILabel *kxleftLabel2;//手机维修-=舍不得卖,就好好修
    
    
    UIImageView *jpIV;//二手精品
    UILabel *jpleftLabel;//二手精品
    UILabel *jpleftLabel2;//二手精品

    //最低部视图
    UIImageView *biv1;UIImageView *biv2;UIImageView *biv3;
    
    //热门回收下面6个
    NSString *leftBUrl;NSString *rightBUrl;NSString *ipadBtnUrl;NSString *ipadBtnUrl2;NSString *ipadBtnUrl3;NSString *ipadBtnUrl4;
    
    
    NSString *leftBId;NSString *rightBId;NSString *ipadBtnId;NSString *ipadBtnId2;NSString *ipadBtnId3;NSString *ipadBtnId4;
    
    NSString *leftBName;NSString *rightBName;NSString *ipadBtnName;NSString *ipadBtnName2;NSString *ipadBtnName3;NSString *ipadBtnName4;
    
    NSString *leftBPrice;NSString *rightBPrice;NSString *ipadBtnPrice;NSString *ipadBtnPrice2;NSString *ipadBtnPrice3;NSString *ipadBtnPrice4;
    
    
    
    
    
    
    
  NSString *bivUrl;NSString *bivUrl2;NSString *bivUrl3;
    
    NSMutableArray *touLinkArr;NSMutableArray *reMaiLinkArr;
    
}
@property (strong, nonatomic)  SGAdvertScrollView *advertScrollViewTop;
@property (strong, nonatomic)  SGAdvertScrollView *advertScrollViewTop0;
@property (strong, nonatomic) UILabel *refresh;

@end

@implementation HomeVC
#pragma mark * 添加搜索🔍导航条item
-(void)rightBtnAction{
    
    PRJTabBarViewController *tabar = (PRJTabBarViewController *)self.view.window.rootViewController;
    tabar.toIndex = 4;
    
}
-(void)addNavigationItem
{
    
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 70, 30);
    
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"城市" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, 50, 22)];//59 67
    leftBtn.titleLabel.font = PFR15Font;
    leftBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 8, 10, 6)];//32  18
    //leftImage.contentMode = UIViewContentModeScaleAspectFit;
    leftImage.image = [UIImage imageNamed:@"more"];
    
    [leftView addSubview:leftBtn];
    [leftView addSubview:leftImage];
    
    // 使用自定义的按钮初始化一个导航条按钮
    UIBarButtonItem* leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    // 使用数组给导航条添加多个控件
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"Personal"] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 20, 22)];//59 67
    // 使用自定义的按钮初始化一个导航条按钮
    UIBarButtonItem* rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
       // 使用数组给导航条添加多个控件
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
    
    
    
    CGFloat sLeftImageLeftGap = 10 ;
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 150, 30)];//30
    UIImage *image = [UIImage imageNamed:@"select_kuang"];
    [searchBtn setImage:image forState:UIControlStateNormal];
    
    UIImageView *sLeftImage = [[UIImageView alloc] initWithFrame:CGRectMake(sLeftImageLeftGap, 6, 18, 18)];
    sLeftImage.contentMode = UIViewContentModeScaleAspectFit;
    sLeftImage.image = [UIImage imageNamed:@"frone_fangdajing"];
    [searchBtn addSubview:sLeftImage];
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(sLeftImageLeftGap+25, 6, 130, 18)];//130
    searchLabel.font = PFR15Font;
    searchLabel.textColor = [UIColor grayColor];
    searchLabel.text = @"搜索你需要的内容";
    [searchBtn addSubview:searchLabel];
    self.navigationItem.titleView =searchBtn;
    

    
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)searchAction
{
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    seachVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seachVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   // [self requestScrollViewData];
    
#pragma mark-版本更新
    [self updateVersions];
    [self startLocation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  
    
}

-(void)clickSellPhone{
    
    NSLog(@"clickMaiPhone");
    
    PRJTabBarViewController *tabar = (PRJTabBarViewController *)self.view.window.rootViewController;
    tabar.toIndex = 2;

}
-(void)clickJiaDian{
    
    NSLog(@"clickJiaDian");
    PRJTabBarViewController *tabar = (PRJTabBarViewController *)self.view.window.rootViewController;
    tabar.toIndex = 3;

}
-(void)clickfeipin{
    
    NSLog(@"clickfeipin");
    PRJTabBarViewController *tabar = (PRJTabBarViewController *)self.view.window.rootViewController;
    tabar.toIndex = 1;

}

-(void)leftiphoneBtnCilck{
    
    ChooseConditionVC *vc = [[ChooseConditionVC alloc] init];
    vc.productID = leftBId;
    vc.titleStr = leftBName;
    vc.productPrice = leftBPrice;
    vc.hidesBottomBarWhenPushed = YES;
    vc.isPhoneNotJD = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)righiphoneBtnCilck{
    ChooseConditionVC *vc = [[ChooseConditionVC alloc] init];
    vc.productID = rightBId;
    vc.titleStr = rightBName;
    vc.productPrice = rightBPrice;
    vc.hidesBottomBarWhenPushed = YES;
    vc.isPhoneNotJD = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)clickiPadImage{
    ChooseConditionVC *vc = [[ChooseConditionVC alloc] init];
    vc.productID = ipadBtnId;
    vc.titleStr = ipadBtnName;
    vc.productPrice = ipadBtnPrice;
    vc.hidesBottomBarWhenPushed = YES;
    vc.isPhoneNotJD = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    LJWebViewController *ZSWWebView = [[LJWebViewController alloc] init];
//    ZSWWebView.title = @"链旧";
//    ZSWWebView.url= ipadBtnUrl;
//    ZSWWebView.hidesBottomBarWhenPushed = YES;
//    if (ipadBtnUrl.length>0) {
//        [self.navigationController pushViewController:ZSWWebView animated:YES];
//    }
}
-(void)clickiPadImageTwo{
    ChooseConditionVC *vc = [[ChooseConditionVC alloc] init];
    vc.productID = ipadBtnId2;
    vc.titleStr = ipadBtnName2;
    vc.productPrice = ipadBtnPrice2;
    vc.hidesBottomBarWhenPushed = YES;
    vc.isPhoneNotJD = YES;
    [self.navigationController pushViewController:vc animated:YES];}

-(void)clickiPadImageThird{
    ChooseConditionVC *vc = [[ChooseConditionVC alloc] init];
    vc.productID = ipadBtnId3;
    vc.titleStr = ipadBtnName3;
    vc.productPrice = ipadBtnPrice3;
    vc.hidesBottomBarWhenPushed = YES;
    vc.isPhoneNotJD = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)clickiPadImageFour{
    ChooseConditionVC *vc = [[ChooseConditionVC alloc] init];
    vc.productID = ipadBtnId4;
    vc.titleStr = ipadBtnName4;
    vc.productPrice = ipadBtnPrice4;
    vc.hidesBottomBarWhenPushed = YES;
    vc.isPhoneNotJD = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/// 代理方法
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    
    //NSLog(@"advertScrollView.tag:%zd  index:%zd",advertScrollView.tag,index);
   
    
    if (advertScrollView.tag == 1000) {//l000==链旧头条
        
        NSLog(@"1000advertScrollView.tag:%zd  index:%zd",advertScrollView.tag,index);
        
        if (touLinkArr.count>index) {
            NSString *URLStr= touLinkArr[index];
            LJWebViewController *ZSWWebView = [[LJWebViewController alloc] init];
            ZSWWebView.title = @"链旧";
            ZSWWebView.url= URLStr;
            ZSWWebView.hidesBottomBarWhenPushed = YES;
            if (URLStr.length>0) {
                [self.navigationController pushViewController:ZSWWebView animated:YES];
            }
        }
        
        
        
    }else{//热卖产品
        
        NSLog(@"2000advertScrollView.tag:%zd  index:%zd",advertScrollView.tag,index);
        
        
        if (reMaiLinkArr.count>index) {
            NSString *URLStr= reMaiLinkArr[index];
            LJWebViewController *ZSWWebView = [[LJWebViewController alloc] init];
            ZSWWebView.title = @"链旧";
            ZSWWebView.url= URLStr;
            ZSWWebView.hidesBottomBarWhenPushed = YES;
            if (URLStr.length>0) {
                [self.navigationController pushViewController:ZSWWebView animated:YES];
            }
        }

    }
//    DetailViewController *nextVC = [[DetailViewController alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
}
#pragma mark - CoreLocation 代理
#pragma mark - CoreLocation 代理

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                
                [_locationManager requestWhenInUseAuthorization];
                
            }break;
            
        default:break;
            
    }
    
}

#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
  //  NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //使用反地理编码
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}
#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *placemark=[placemarks firstObject];
//        NSLog(@"地名;%@",placemark);
        for (CLPlacemark *place in placemarks) {
          
            NSLog(@"name,%@",place.name);                      // 位置名
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            NSLog(@"locality,%@",place.locality);              // 市
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            NSLog(@"country,%@",place.country);                // 国家
          // [self.mytableviewreloadData];
            
             [leftBtn setTitle:place.locality forState:UIControlStateNormal];
            
        }
    }];
}
-(void)updateVersions{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *oldVersion = infoDict[@"CFBundleShortVersionString"];
    oldVersion = [oldVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@", @"1315969751"];//1315969751//1093687868
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript", nil, nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@",responseObject);
        NSNumber *number = responseObject[@"resultCount"];
        if (number.intValue == 1) {
            NSString *trackViewUrl = responseObject[@"results"][0][@"trackViewUrl"];
            NSString *releaseNotes = responseObject[@"results"][0][@"releaseNotes"];
            NSString *newVersion = responseObject[@"results"][0][@"version"];
            newVersion = [newVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSLog(@"新版本号:%zd  当前版本:%zd",(long)[newVersion integerValue],[oldVersion integerValue]);
            if ([newVersion integerValue]>[oldVersion integerValue]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"有新的版本(%@)",responseObject[@"results"][0][@"version"]] message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
                    
                }];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:cancleAction];
                [alertController addAction:okAction];
                
                
                [self presentViewController:alertController animated:YES completion:nil];
                
//                //初始化UIWindows//AppDelegate.m中添加不上的解决办法
//                UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//                aW.rootViewController = [[UIViewController alloc]init];
//                aW.windowLevel = UIWindowLevelAlert + 1;
//                [aW makeKeyAndVisible];
//                [aW.rootViewController presentViewController:alertController animated:YES completion:nil];
                
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];


}


-(void)requestScrollViewData{
#pragma mark---数据请求..
    [networking AFNRequest:[NSString stringWithFormat:@"%@/0",LIANJIU] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        //轮播图
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        if ([lianjiuData[@"adCarousel"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"adCarousel"];
            //NSLog(@"首页接口:%@",response);
            //NSLog(@"广告接口内容:%@",response);
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            scrollPhotoList = [[NSMutableArray alloc] init];
            for (NSDictionary *temp in response) {
                NSString *str = temp[@"caPicture"]?temp[@"caPicture"]:@"";
                NSString *urlStr = [str excisionForFistString];
                urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                [arr addObject:[@"" stringByAppendingString:urlStr]];
                [scrollPhotoList addObject:temp[@"c_url"]?temp[@"c_url"]:@""];
            }
            cycleScrollView.imageURLStringsGroup =arr;
        }
        
        //链旧头条-----的轮播文字===
        if ([lianjiuData[@"adHotTopics"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"adHotTopics"];
            for (NSDictionary *temp in response) {
                NSString *str = temp[@"topContent"]?temp[@"topContent"]:@"";
                [lianjiuTouTiaoArr addObject:str];
                [touLinkArr addObject:temp[@"topPicLink"]?temp[@"topPicLink"]:@""];
                
            }
            _advertScrollViewTop0.titles = lianjiuTouTiaoArr;
        }
        
        
        //热门话题-热门产品-----热卖产品的轮播文字===
        if ([lianjiuData[@"ordersItem"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"ordersItem"];
            for (NSDictionary *temp in response) {
                
                NSString *orItemsUser = [NSString stringWithFormat:@"%@",temp[@"orItemsUser"]?temp[@"orItemsUser"]:@""];
                if (orItemsUser.length>9) {
                    
                    orItemsUser = [orItemsUser stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                }
                
                NSString *str =  [NSString stringWithFormat:@"用户%@卖掉了手机%@",orItemsUser,temp[@"orItemsName"]?temp[@"orItemsName"]:@""];
                
                
                [adHotTopicsArr addObject:str];
                
                //  [reMaiLinkArr addObject:temp[@"orItemsName"]?temp[@"orItemsName"]:@""];
                
            }
            _advertScrollViewTop.titles = adHotTopicsArr;
        }
        
        //热卖产品下面的2个iPhone8====
        if ([lianjiuData[@"adHotProduct1"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"adHotProduct1"];
            //图片网址:
            leftBUrl = response.count>0?(response[0][@"hotPicLink"]?response[0][@"hotPicLink"]:@""):@"";
            rightBUrl = response.count>1?(response[1][@"hotPicLink"]?response[1][@"hotPicLink"]:@""):@"";
            
            
            leftBId = response.count>0?(response[0][@"hotPicLink"]?response[0][@"hotPicLink"]:@""):@"";
            rightBId = response.count>1?(response[1][@"hotPicLink"]?response[1][@"hotPicLink"]:@""):@"";
            
            
            leftBName = response.count>0?(response[0][@"hotTitle"]?response[0][@"hotTitle"]:@""):@"";
            rightBName = response.count>1?(response[1][@"hotTitle"]?response[1][@"hotTitle"]:@""):@"";
            
            
            leftBPrice = response.count>0?(response[0][@"proPrice"]?response[0][@"proPrice"]:@""):@"";
            rightBPrice = response.count>1?(response[1][@"proPrice"]?response[1][@"proPrice"]:@""):@"";
            
            
            [hmLeftIV sd_setImageWithURL:[NSURL URLWithString:response.count>0?(response[0][@"hotPicture"]?response[0][@"hotPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            hmleftLabel.text = response.count>0?(response[0][@"hotTitle"]?response[0][@"hotTitle"]:@""):@"";//iPhone8
            //hmleftLabel2.text = [NSString stringWithFormat:@"最高回收价%@",response.count>0?(response[0][@"proPrice"]?response[0][@"proPrice"]:@""):@""];
            //不同颜色label
            NSString *accessStr = [NSString stringWithFormat:@"%@",response.count>0?(response[0][@"proPrice"]?response[0][@"proPrice"]:@""):@""];//要变色的字
            NSString *str3 = [NSString stringWithFormat:@"最高回收价%@",accessStr];
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:str3];
            NSRange redRange2 = NSMakeRange([[attribute string] rangeOfString:accessStr].location, [[attribute string] rangeOfString:accessStr].length);
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1] range:redRange2];
            [attribute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:redRange2];
            [hmleftLabel2 setAttributedText:attribute];
            
            
            
            
            
            
            
            
            
            [hmRightIV sd_setImageWithURL:[NSURL URLWithString:response.count>1?(response[1][@"hotPicture"]?response[1][@"hotPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            hmRightLabel.text = response.count>1?(response[1][@"hotTitle"]?response[1][@"hotTitle"]:@""):@"";//iPhone8
            // hmRightLabel2.text = [NSString stringWithFormat:@"最高回收价%@",response.count>1?(response[1][@"proPrice"]?response[1][@"proPrice"]:@""):@""];
            
            
            
            
            //不同颜色label
            NSString *accessStrR = [NSString stringWithFormat:@"%@",response.count>1?(response[1][@"proPrice"]?response[1][@"proPrice"]:@""):@""];//要变色的字
            NSString *strR = [NSString stringWithFormat:@"最高回收价%@",accessStrR];
            NSMutableAttributedString *attributeR = [[NSMutableAttributedString alloc] initWithString:strR];
            NSRange redRangeR = NSMakeRange([[attributeR string] rangeOfString:accessStrR].location, [[attributeR string] rangeOfString:accessStrR].length);
            [attributeR addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1] range:redRange2];
            [attributeR addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:redRangeR];
            [hmRightLabel2 setAttributedText:attributeR];
            
            
            
            
        }
        //热卖产品下面的4个iPad====
        if ([lianjiuData[@"adHotProduct2"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"adHotProduct2"];
            
            ipadBtnUrl = response.count>0?(response[0][@"hotPicLink"]?response[0][@"hotPicLink"]:@""):@"";
            ipadBtnUrl2 = response.count>1?(response[1][@"hotPicLink"]?response[1][@"hotPicLink"]:@""):@"";
            ipadBtnUrl3 = response.count>2?(response[2][@"hotPicLink"]?response[2][@"hotPicLink"]:@""):@"";
            ipadBtnUrl4 = response.count>3?(response[3][@"hotPicLink"]?response[3][@"hotPicLink"]:@""):@"";
            
            
            
            ipadBtnId = response.count>0?(response[0][@"hotPicLink"]?response[0][@"hotPicLink"]:@""):@"";
            ipadBtnId2 = response.count>1?(response[1][@"hotPicLink"]?response[1][@"hotPicLink"]:@""):@"";
            ipadBtnId3 = response.count>2?(response[2][@"hotPicLink"]?response[2][@"hotPicLink"]:@""):@"";
            ipadBtnId4 = response.count>3?(response[3][@"hotPicLink"]?response[3][@"hotPicLink"]:@""):@"";

            ipadBtnName = response.count>0?(response[0][@"hotTitle"]?response[0][@"hotTitle"]:@""):@"";
            ipadBtnName2 = response.count>1?(response[1][@"hotTitle"]?response[1][@"hotTitle"]:@""):@"";
            ipadBtnName3 = response.count>2?(response[2][@"hotTitle"]?response[2][@"hotTitle"]:@""):@"";
            ipadBtnName4 = response.count>3?(response[3][@"hotTitle"]?response[3][@"hotTitle"]:@""):@"";

            ipadBtnPrice = response.count>0?(response[0][@"proPrice"]?response[0][@"proPrice"]:@""):@"";
            ipadBtnPrice2 = response.count>1?(response[1][@"proPrice"]?response[1][@"proPrice"]:@""):@"";
            ipadBtnPrice3 = response.count>2?(response[2][@"proPrice"]?response[2][@"proPrice"]:@""):@"";
            ipadBtnPrice4 = response.count>3?(response[3][@"proPrice"]?response[3][@"proPrice"]:@""):@"";

            
            
            
            
            
            
            
            
            
            
            
            
            
            [hotBottomIV sd_setImageWithURL:[NSURL URLWithString:response.count>0?(response[0][@"hotPicture"]?response[0][@"hotPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            hotBLabel.text = response.count>0?(response[0][@"hotTitle"]?response[0][@"hotTitle"]:@""):@"";//iPhone8
            hotBLabel2.text = [NSString stringWithFormat:@"%@",response.count>0?(response[0][@"proPrice"]?response[0][@"proPrice"]:@""):@""];
            
            
            [hotBottomIVtwo sd_setImageWithURL:[NSURL URLWithString:response.count>1?(response[1][@"hotPicture"]?response[1][@"hotPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            hotBLabelTwo.text = response.count>1?(response[1][@"hotTitle"]?response[1][@"hotTitle"]:@""):@"";//iPhone8
            hotBLabelTwo2.text = [NSString stringWithFormat:@"%@",response.count>1?(response[1][@"proPrice"]?response[1][@"proPrice"]:@""):@""];
            
            
            [hotBottomIVthird sd_setImageWithURL:[NSURL URLWithString:response.count>2?(response[2][@"hotPicture"]?response[2][@"hotPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            hotBLabelThird.text = response.count>2?(response[2][@"hotTitle"]?response[2][@"hotTitle"]:@""):@"";//iPhone8
            hotBLabelThird2.text = [NSString stringWithFormat:@"%@",response.count>2?(response[2][@"proPrice"]?response[2][@"proPrice"]:@""):@""];
            
            
            [hotBottomIVfour sd_setImageWithURL:[NSURL URLWithString:response.count>3?(response[3][@"hotPicture"]?response[3][@"hotPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            hotBLabelFour.text = response.count>3?(response[3][@"hotTitle"]?response[3][@"hotTitle"]:@""):@"";//iPhone8
            hotBLabelFour2.text = [NSString stringWithFormat:@"%@",response.count>3?(response[3][@"proPrice"]?response[3][@"proPrice"]:@""):@""];
            
            
        }
        //手机维修,,二手精品===
        if ([lianjiuData[@"adSecond"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"adSecond"];
            
            
            [kxLeftIV sd_setImageWithURL:[NSURL URLWithString:response.count>0?(response[0][@"secPicture"]?response[0][@"secPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            kxleftLabel.text = response.count>0?(response[0][@"secTitle"]?response[0][@"secTitle"]:@""):@"";//iPhone8
            kxleftLabel2.text = response.count>0?(response[0][@"secContent"]?response[0][@"secContent"]:@""):@"";
            
            
            [jpIV sd_setImageWithURL:[NSURL URLWithString:response.count>1?(response[1][@"secPicture"]?response[1][@"secPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            jpleftLabel.text = response.count>1?(response[1][@"secTitle"]?response[1][@"secTitle"]:@""):@"";//iPhone8
            jpleftLabel2.text = response.count>1?(response[1][@"secContent"]?response[1][@"secContent"]:@""):@"";
            
            
            
        }
        //卖手机",,卖家电","卖废品"===
        if ([lianjiuData[@"adThemeList"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"adThemeList"];
            
            //卖手机
            [leftIV sd_setImageWithURL:[NSURL URLWithString:response.count>0?(response[0][@"thePicture"]?response[0][@"thePicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            ttleftLabel.text = response.count>0?(response[0][@"theTitle"]?response[0][@"theTitle"]:@""):@"";//iPhone8
            ttleftLabel2.text = response.count>0?(response[0][@"theContent"]?response[0][@"theContent"]:@""):@"";
            
            //卖家电
            [rightIV sd_setImageWithURL:[NSURL URLWithString:response.count>1?(response[1][@"thePicture"]?response[1][@"thePicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            rightSLabel.text = response.count>1?(response[1][@"theTitle"]?response[1][@"theTitle"]:@""):@"";//iPhone8
            rightSLabel2.text = response.count>1?(response[1][@"theContent"]?response[1][@"theContent"]:@""):@"";
            
            
            //卖废品"
            [rightXIV sd_setImageWithURL:[NSURL URLWithString:response.count>2?(response[2][@"thePicture"]?response[2][@"thePicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            rightXLabel.text = response.count>2?(response[2][@"theTitle"]?response[2][@"theTitle"]:@""):@"";//iPhone8
            rightXLabel2.text = response.count>2?(response[2][@"theContent"]?response[2][@"theContent"]:@""):@"";
        }
        
        
        //最下面的三张图片
        if ([lianjiuData[@"adThird"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"adThird"];
            
            bivUrl = response.count>0?(response[0][@"thiPicLink"]?response[0][@"thiPicLink"]:@""):@"";
            bivUrl2 = response.count>1?(response[1][@"thiPicLink"]?response[1][@"thiPicLink"]:@""):@"";
            bivUrl3 = response.count>2?(response[2][@"thiPicLink"]?response[2][@"thiPicLink"]:@""):@"";
            
            
            
            
            
            //
            [biv1 sd_setImageWithURL:[NSURL URLWithString:response.count>0?(response[0][@"thiPicture"]?response[0][@"thiPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            //
            [biv2 sd_setImageWithURL:[NSURL URLWithString:response.count>1?(response[1][@"thiPicture"]?response[1][@"thiPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            
            //
            [biv3 sd_setImageWithURL:[NSURL URLWithString:response.count>2?(response[2][@"thiPicture"]?response[2][@"thiPicture"]:@""):@""] placeholderImage:[UIImage imageNamed:@"esjp2"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            
            
        }
        
        
        
        
        
        
        
    } error:nil HUDAddView:self.view];
    

}


//第二步：实现UIScrollViewDelegate

//offset发生改变

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y <= -50) {
        
        if (self.refresh.tag == 0) {
            
            self.refresh.text = @"松开刷新";
            
        }
        
        self.refresh.tag = 1;
        
    }else{
        
        //防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
        
        self.refresh.tag = 0;
        
        self.refresh.text = @"下拉刷新";
        
    }
    
}

#pragma mark - 下拉刷新
- (void)headRefresh{
    
    [self requestScrollViewData];
    [_scrollV.header endRefreshing];
}

#pragma mark-开始定位
-(void)startLocation{
    _locationManager = [[CLLocationManager alloc] init];
    //开始定位
    _locationManager.delegate = self;
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    _locationManager.distanceFilter = 10.0f;
    [_locationManager startUpdatingLocation];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    
    
    
//    _locationManager=[[CLLocationManager alloc]init];
//    if (![CLLocationManager locationServicesEnabled]) {
//        HZLog(@"定位服务当前可能尚未打开，请设置打开！");
//        return;
//    }
//    //如果没有授权则请求用户授权
//    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
//        [_locationManager requestWhenInUseAuthorization];
//    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
//        //设置代理
//        _locationManager.delegate=self;
//        //设置定位精度
//        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
//        //定位频率,每隔多少米定位一次
//        CLLocationDistance distance=10.0;//米定位一次
//        _locationManager.distanceFilter=distance;
//        //启动跟踪定位
//        [_locationManager startUpdatingLocation];
//    }

    
    
    
    
    
    
    [self addNavigationItem];
    adHotTopicsArr = [[NSMutableArray alloc] init];
    lianjiuTouTiaoArr = [[NSMutableArray alloc] init];
    touLinkArr = [[NSMutableArray alloc] init];
    reMaiLinkArr = [[NSMutableArray alloc] init];
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    _scrollV.delegate = self;
    [self.view addSubview:_scrollV];
    
    
    
    
    
    
    
    //图片轮播器
    CGFloat headImageH = BOUND_WIDTH/1125.0*383;
//    // 本地加载 --- 创建不带标题的图片轮播器
    cycleScrollView = [[SDCycleScrollView alloc ] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, headImageH)];
    cycleScrollView.backgroundColor = BGColor;
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.dotColor = MAINColor; // 自定义分页控件小圆标颜色
    //cycleScrollView.imageURLStringsGroup =@[@"",@""];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"symrhead"];
    [_scrollV addSubview:cycleScrollView];
    _scrollVH +=5+headImageH;
    
    //头条-跑马灯
//    marqueeView = [[CQMarqueeView alloc] initWithFrame:CGRectMake(0, _scrollVH, self.view.frame.size.width, 30)];
//    [_scrollV addSubview:marqueeView];
    
    
    
    
#pragma mark-隐藏头条
//    UIView *hhV = [[UIView alloc] init];
//    hhV.backgroundColor = [UIColor whiteColor];
//    hhV.frame =CGRectMake(0, _scrollVH, BOUND_WIDTH, 30);
//    [_scrollV addSubview:hhV];
//    
//    UIImageView *tImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 5, 17, 16)];
//    tImageView.backgroundColor = [UIColor whiteColor];
//    tImageView.image = [UIImage imageNamed:@"Headlines"];
//    [hhV addSubview:tImageView];
//    _advertScrollViewTop0 = [[SGAdvertScrollView alloc]init];
//    _advertScrollViewTop0.frame = CGRectMake(30, 0, self.view.frame.size.width-30, 30);
//    _advertScrollViewTop0.titles = @[@"", @"", @""];
//    _advertScrollViewTop0.delegate = self;
//    _advertScrollViewTop0.tag = 1000;
//    _advertScrollViewTop0.titleColor = [UIColor darkGrayColor];
//    _advertScrollViewTop0.textAlignment = NSTextAlignmentCenter;
//    [hhV addSubview:_advertScrollViewTop0];
//    _scrollVH +=1+30;
    
    
    
    
    
    
    
    
    
#pragma mark-请求数据
    _scrollV.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
   // [self requestScrollViewData];
    [_scrollV.header beginRefreshing];
   // [_scrollV.header endRefreshing];
    
//    marqueeView.marqueeText = @"链旧头条:李知恩，艺名IU，1993年5月16日出生于韩国首尔特别市，韩国女歌手、演员、主持人。";
//    marqueeView.delegate = self;
#pragma mark- //头条下面的一个视图-卖手机家电
    UIView *touTiaoV = [[UIView alloc] init];
    touTiaoV.backgroundColor = [UIColor whiteColor];
    touTiaoV.frame = CGRectMake(0, _scrollVH, (BOUND_WIDTH-2)/2.0, 160);
    [_scrollV addSubview:touTiaoV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSellPhone)];
    [touTiaoV addGestureRecognizer:tap];
    touTiaoV.userInteractionEnabled = YES;
    
    
    
    
    
    //家电
    UIView *jiadianV = [[UIView alloc] init];
    jiadianV.backgroundColor = [UIColor whiteColor];
    jiadianV.frame = CGRectMake((BOUND_WIDTH-2)/2.0, _scrollVH, (BOUND_WIDTH-2)/2.0, 79);
    //_scrollVH +=160;
    [_scrollV addSubview:jiadianV];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickJiaDian)];
    [jiadianV addGestureRecognizer:tap2];
    jiadianV.userInteractionEnabled = YES;
    
    
    
    
    
    //废品
    UIView *feipinV = [[UIView alloc] init];
    feipinV.backgroundColor = [UIColor whiteColor];
    feipinV.frame = CGRectMake((BOUND_WIDTH-2)/2.0, _scrollVH+80, (BOUND_WIDTH-2)/2.0, 79);
    //_scrollVH +=160;
    [_scrollV addSubview:feipinV];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickfeipin)];
    [feipinV addGestureRecognizer:tap3];
    feipinV.userInteractionEnabled = YES;
    
    
    
    
    _scrollVH +=160;
    
    
    
    
    
    //左一文字
    ttleftLabel = [[UILabel alloc] init];
    ttleftLabel.text = @"卖手机";
    ttleftLabel.numberOfLines = 0;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    ttleftLabel.font = PFR15Font;
    ttleftLabel.textAlignment = NSTextAlignmentCenter;
    ttleftLabel.frame = CGRectMake(5, 5, (BOUND_WIDTH-2)/2.0-10, 30);
    [touTiaoV addSubview:ttleftLabel];
    //左二文字
    ttleftLabel2 = [[UILabel alloc] init];
    ttleftLabel2.text = @"拒接脸盆换手机";
    ttleftLabel2.numberOfLines = 0;
    ttleftLabel2.textColor = [UIColor darkGrayColor];
    //ttleftLabel.backgroundColor = [UIColor redColor];
    ttleftLabel2.font = PFR12Font;
    ttleftLabel2.textAlignment = NSTextAlignmentCenter;
    ttleftLabel2.frame = CGRectMake(5, ttleftLabel.frame.origin.y+ttleftLabel.frame.size.height, (BOUND_WIDTH-2)/2.0-10, 30);
    [touTiaoV addSubview:ttleftLabel2];

    //左边一图片
    leftIV =[[UIImageView alloc] init];
    leftIV.image = [UIImage imageNamed:@"maishoujiM"];
   // leftIV.backgroundColor = [UIColor greenColor];
    leftIV.frame = CGRectMake(((BOUND_WIDTH-2)/2.0 - 79)/2.0, 63, 79, 95);
    [touTiaoV addSubview:leftIV];
    
    
    //分割线
    UIImageView *cutLine = [[UIImageView alloc] init];
    cutLine.frame = CGRectMake((BOUND_WIDTH-4)/2.0, _scrollVH-160, 2, touTiaoV.frame.size.height);
    cutLine.backgroundColor = BGColor;
    [_scrollV addSubview:cutLine];
    
    
    
    
    
  
    
    
    
    //右上图片
    rightIV =[[UIImageView alloc] init];
    rightIV.image = [UIImage imageNamed:@"maijiadianM"];
   // rightIV.backgroundColor = [UIColor greenColor];
    rightIV.frame = CGRectMake(2, (79 - (BOUND_WIDTH-2)/6.0/183*147)/2.0, (BOUND_WIDTH-2)/2.0/3.0,(BOUND_WIDTH-2)/6.0/183*147);
    [jiadianV addSubview:rightIV];
    //右上一文字
    rightSLabel = [[UILabel alloc] init];
    rightSLabel.text = @"卖家电";
    rightSLabel.numberOfLines = 0;
    //rightSLabel.backgroundColor = [UIColor redColor];
    rightSLabel.font = PFR15Font;
    rightSLabel.textAlignment = NSTextAlignmentCenter;
    rightSLabel.frame = CGRectMake(rightIV.frame.origin.x+rightIV.frame.size.width+2, touTiaoV.frame.size.height/16.0, (BOUND_WIDTH-2)/3.0-4, 30);
    [jiadianV addSubview:rightSLabel];
    //右上二文字
    rightSLabel2 = [[UILabel alloc] init];
    rightSLabel2.text = @"丢掉麻烦,不如卖了";
    rightSLabel2.textColor = [UIColor darkGrayColor];
    //rightSLabel2.backgroundColor = [UIColor redColor];
    rightSLabel2.font = PFR12Font;
    rightSLabel2.numberOfLines = 0;
    rightSLabel2.adjustsFontSizeToFitWidth = YES;
    rightSLabel2.textAlignment = NSTextAlignmentCenter;
    rightSLabel2.frame = CGRectMake(rightIV.frame.origin.x+rightIV.frame.size.width+2, rightSLabel.frame.origin.y+rightSLabel.frame.size.height, (BOUND_WIDTH-2)/3.0-4, 30);
    [jiadianV addSubview:rightSLabel2];

    
    
    
    //分割线2
    UIImageView *cutLine2 = [[UIImageView alloc] init];
    cutLine2.frame = CGRectMake(cutLine.frame.origin.x, (touTiaoV.frame.size.height-1)/2.0, (BOUND_WIDTH-2)/2.0, 1);
    cutLine2.backgroundColor = BGColor;
    [touTiaoV addSubview:cutLine2];

    
    
    
    //右下一文字
    rightXLabel = [[UILabel alloc] init];
    rightXLabel.text = @"卖废品";
    rightXLabel.numberOfLines = 0;
    //rightXLabel.backgroundColor = [UIColor redColor];
    rightXLabel.font = PFR15Font;
    rightXLabel.textAlignment = NSTextAlignmentCenter;
    rightXLabel.frame = CGRectMake(0, 0, (BOUND_WIDTH-2)/4.0-4, 30);
    [feipinV addSubview:rightXLabel];
    //右下二文字
    rightXLabel2 = [[UILabel alloc] init];
    rightXLabel2.text = @"这些也值钱";
    rightXLabel2.textColor = [UIColor darkGrayColor];
    //rightXLabel2.backgroundColor = [UIColor redColor];
    rightXLabel2.font = PFR12Font;
    rightXLabel2.numberOfLines = 0;
    rightXLabel2.adjustsFontSizeToFitWidth = YES;
    rightXLabel2.textAlignment = NSTextAlignmentCenter;
    rightXLabel2.frame = CGRectMake(0, rightXLabel.frame.origin.y+rightXLabel.frame.size.height, (BOUND_WIDTH-2)/4.0+10, 30);
    [feipinV addSubview:rightXLabel2];
    //右下图片
    rightXIV =[[UIImageView alloc] init];
    rightXIV.image = [UIImage imageNamed:@"maifeipinM"];
   // rightXIV.backgroundColor = [UIColor greenColor];
    rightXIV.frame = CGRectMake(rightXLabel.frame.origin.x+rightXLabel.frame.size.width+2, (79-(BOUND_WIDTH-2)/4.0/222*161)/2, (BOUND_WIDTH-2)/4.0,(BOUND_WIDTH-2)/4.0/222*161);
    [feipinV addSubview:rightXIV];

    
    
    _scrollVH +=5;
#pragma mark-//热卖视图
    //热卖头部
    UIView *HeadhotMailV = [[UIView alloc] init];
    HeadhotMailV.backgroundColor = [UIColor whiteColor];
    HeadhotMailV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 33);
     _scrollVH +=33;
    [_scrollV addSubview:HeadhotMailV];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 5, 16, 20)];
    imageView.image = [UIImage imageNamed:@"Selling"];
    [HeadhotMailV addSubview:imageView];
    
    UILabel *hotL = [[UILabel alloc] init];
    hotL.text = @"热门回收";//热卖产品-热门回收
    //hotL.backgroundColor = [UIColor redColor];
    hotL.font = PFR13Font;
    hotL.frame = CGRectMake(35, 0, 55, 30);
    [HeadhotMailV addSubview:hotL];
#pragma mark-垂直滚动文字
    _advertScrollViewTop = [[SGAdvertScrollView alloc]init];
    _advertScrollViewTop.frame = CGRectMake(hotL.frame.origin.x+hotL.frame.size.width, 0, BOUND_WIDTH-95, 33);
    //_advertScrollViewTop.titles = @[@"3京东、天猫等 app 首页常见的广告滚动视图", @"3采用代理设计模式进行封装, 可进行事件点击处理", @"3建议在 github 上下载"];
    _advertScrollViewTop.delegate = self;
    _advertScrollViewTop.tag = 2000;
    _advertScrollViewTop.titleColor = [UIColor darkGrayColor];
    _advertScrollViewTop.textAlignment = NSTextAlignmentCenter;
    _advertScrollViewTop.titleFont = [UIFont systemFontOfSize:11];
    [HeadhotMailV addSubview:_advertScrollViewTop];
    
    
    
    
    
    
    
    
    
    _scrollVH +=1;
    //热卖主体内容
    UIView *hotMailV = [[UIView alloc] init];
    hotMailV.backgroundColor = [UIColor whiteColor];
    hotMailV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 168+ 140);
    _scrollVH +=168 + 140;
    [_scrollV addSubview:hotMailV];


    
#pragma mark-热门回收的6个view//(BOUND_WIDTH-2)/2.0, 0, 2, hotMailV.frame.size.height
    UIView *leftBView = [[UIView alloc] init];
    leftBView.frame = CGRectMake(0, 0, (BOUND_WIDTH-2)/2.0, 168);
    //leftBView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *leftBViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftiphoneBtnCilck)];
    [leftBView addGestureRecognizer:leftBViewTap];
    leftBView.userInteractionEnabled = YES;
    [hotMailV addSubview:leftBView];
    
    UIView *rightBView = [[UIView alloc] init];
    rightBView.frame = CGRectMake((BOUND_WIDTH-2)/2.0 +2, 0, (BOUND_WIDTH-2)/2.0, 168);
    //leftBView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *rightBViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(righiphoneBtnCilck)];
    [rightBView addGestureRecognizer:rightBViewTap];
    rightBView.userInteractionEnabled = YES;
    [hotMailV addSubview:rightBView];
    
    UIView *ipadView = [[UIView alloc] init];
    ipadView.frame = CGRectMake(0, 169, (BOUND_WIDTH-6)/4.0, 140);
    UITapGestureRecognizer *ipadViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImage)];
    [ipadView addGestureRecognizer:ipadViewTap];
    ipadView.userInteractionEnabled = YES;
    [hotMailV addSubview:ipadView];
    
    UIView *ipadView2 = [[UIView alloc] init];
    ipadView2.frame = CGRectMake((BOUND_WIDTH-6)/4.0+2, 169, (BOUND_WIDTH-6)/4.0, 140);
    UITapGestureRecognizer *ipadView2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImageTwo)];
    [ipadView2 addGestureRecognizer:ipadView2Tap];
    ipadView2.userInteractionEnabled = YES;
    [hotMailV addSubview:ipadView2];

    UIView *ipadView3 = [[UIView alloc] init];
    ipadView3.frame = CGRectMake((BOUND_WIDTH-6)/2.0+2, 169, (BOUND_WIDTH-6)/4.0, 140);
    UITapGestureRecognizer *ipadView3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImageThird)];
    [ipadView3 addGestureRecognizer:ipadView3Tap];
    ipadView3.userInteractionEnabled = YES;
    [hotMailV addSubview:ipadView3];
    
    UIView *ipadView4 = [[UIView alloc] init];
    ipadView4.frame = CGRectMake((BOUND_WIDTH-2)/4.0*3, 169, (BOUND_WIDTH-6)/4.0, 140);
    UITapGestureRecognizer *ipadView4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImageFour)];
    [ipadView4 addGestureRecognizer:ipadView4Tap];
    ipadView4.userInteractionEnabled = YES;
    [hotMailV addSubview:ipadView4];

    
    

    
    
    
    
    
    
    hmLeftIV = [[UIImageView alloc] init];
    hmLeftIV.frame = CGRectMake(((BOUND_WIDTH-2)/2.0 - 79)/2.0, 15, 79, 73);
    // hmLeftIV.image = [UIImage imageNamed:@"iphone8M"];//图片11
    [hmLeftIV sd_setImageWithURL:[NSURL URLWithString:hotPicture0] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
    // hmLeftIV.backgroundColor = [UIColor greenColor];
    hmLeftIV.contentMode = UIViewContentModeScaleAspectFit;
    [leftBView addSubview:hmLeftIV];
    
    
    //热卖-左一文字
    hmleftLabel = [[UILabel alloc] init];
    hmleftLabel.text = hotTitle0;//第一个iPhone88
    hmleftLabel.textColor = SYMAINColor;
    hmleftLabel.numberOfLines = 0;
    //hmleftLabel.backgroundColor = [UIColor redColor];
    hmleftLabel.font = PFR15Font;
    hmleftLabel.textAlignment = NSTextAlignmentCenter;
    hmleftLabel.frame = CGRectMake(5, hmLeftIV.frame.origin.y+hmLeftIV.frame.size.height+2, (BOUND_WIDTH-2)/2.0-10, 20);
    [leftBView addSubview:hmleftLabel];
    //左二文字
    hmleftLabel2 = [[UILabel alloc] init];
    hmleftLabel2.text = [NSString stringWithFormat:@"最高回收价%@",proPrice0];
    hmleftLabel2.numberOfLines = 0;
    hmleftLabel2.textColor = [UIColor darkGrayColor];
    //hmleftLabel2.backgroundColor = [UIColor redColor];
    hmleftLabel2.font = PFR13Font;
    hmleftLabel2.textAlignment = NSTextAlignmentCenter;
    hmleftLabel2.frame = CGRectMake(5, hmleftLabel.frame.origin.y+hmleftLabel.frame.size.height, (BOUND_WIDTH-2)/2.0-10, 20);
    [leftBView addSubview:hmleftLabel2];
    
#pragma mark-//左边马上卖掉按钮
    UIButton *hmMDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hmMDBtn.frame = CGRectMake(10, hmleftLabel2.frame.origin.y+hmleftLabel2.frame.size.height, (BOUND_WIDTH-2)/2.0-20,30);
    hmMDBtn.backgroundColor = MAINColor;
    hmMDBtn.layer.cornerRadius = 5;
    [hmMDBtn setTitle:@"马上卖掉" forState:UIControlStateNormal];
    [hmMDBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hmMDBtn addTarget:self action:@selector(leftiphoneBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [leftBView addSubview:hmMDBtn];
    
    
    
    
    //分割线
    UIImageView *hmCutLine = [[UIImageView alloc] init];
    hmCutLine.frame = CGRectMake((BOUND_WIDTH-2)/2.0, 0, 2, hotMailV.frame.size.height);
    hmCutLine.backgroundColor = BGColor;
    [hotMailV addSubview:hmCutLine];
    
    
    
    ////热卖-右一图片
    hmRightIV = [[UIImageView alloc] init];
    hmRightIV.frame = CGRectMake(((BOUND_WIDTH-2)/2.0 - 79)/2.0, 15, 79, 73);
   [hmRightIV sd_setImageWithURL:[NSURL URLWithString:hotPicture1] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
    hmRightIV.contentMode = UIViewContentModeScaleAspectFit;
    [rightBView addSubview:hmRightIV];
    //热卖-右一文字
    hmRightLabel = [[UILabel alloc] init];
    hmRightLabel.text = hotTitle1;//第二个iPhone8888
    hmRightLabel.textColor = SYMAINColor;
    hmRightLabel.numberOfLines = 0;
    //hmleftLabel.backgroundColor = [UIColor redColor];
    hmRightLabel.font = PFR15Font;
    hmRightLabel.textAlignment = NSTextAlignmentCenter;
    hmRightLabel.frame = CGRectMake(5, hmRightIV.frame.origin.y+hmRightIV.frame.size.height+2, (BOUND_WIDTH-2)/2.0-10, 20);
    [rightBView addSubview:hmRightLabel];
    //右二文字
    hmRightLabel2 = [[UILabel alloc] init];
    hmRightLabel2.text = [NSString stringWithFormat:@"最高回收价%@",proPrice1];
    hmRightLabel2.numberOfLines = 0;
    hmRightLabel2.textColor = [UIColor darkGrayColor];
    //hmleftLabel2.backgroundColor = [UIColor redColor];
    hmRightLabel2.font = PFR13Font;
    hmRightLabel2.textAlignment = NSTextAlignmentCenter;
    hmRightLabel2.frame = CGRectMake(5, hmRightLabel.frame.origin.y+hmRightLabel.frame.size.height, (BOUND_WIDTH-2)/2.0-10, 20);
    [rightBView addSubview:hmRightLabel2];
    
#pragma mark-//右边马上卖掉按钮
    UIButton *hmMDrightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hmMDrightBtn.frame = CGRectMake(10, hmRightLabel2.frame.origin.y+hmRightLabel2.frame.size.height, (BOUND_WIDTH-2)/2.0-20, 30);
    hmMDrightBtn.backgroundColor = MAINColor;
    hmMDrightBtn.layer.cornerRadius = 5;
    [hmMDrightBtn setTitle:@"马上卖掉" forState:UIControlStateNormal];
    [hmMDrightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hmMDrightBtn addTarget:self action:@selector(righiphoneBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [rightBView addSubview:hmMDrightBtn];
    
    
    _scrollVH +=1;
    
    
    
    //分割线
    UIImageView *centerLine = [[UIImageView alloc] init];
    centerLine.frame = CGRectMake(0, 0+168, BOUND_WIDTH, 1);
    centerLine.backgroundColor = BGColor;
    [hotMailV addSubview:centerLine];
    
    
    //    //热卖底部view
    //    UIView *hotBottomV = [[UIView alloc] init];
    //    hotBottomV.backgroundColor = [UIColor whiteColor];
    //    hotBottomV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 140);
    //    _scrollVH +=140;
    //    [_scrollV addSubview:hotBottomV];
    
#pragma mark-热卖底部 1 View
    //左一文字
    hotBLabel = [[UILabel alloc] init];
    hotBLabel.text = hotTitle2;//第三条数据
    hotBLabel.numberOfLines = 0;
    hotBLabel.adjustsFontSizeToFitWidth = YES;
    hotBLabel.textColor = SYMAINColor;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabel.font = PFR11Font;
    hotBLabel.textAlignment = NSTextAlignmentCenter;
    hotBLabel.frame = CGRectMake(2, 10, (BOUND_WIDTH-6)/4.0-4, 25);//Y4
    [ipadView addSubview:hotBLabel];
    //左二文字
    hotBLabel2 = [[UILabel alloc] init];
    hotBLabel2.text = [NSString stringWithFormat:@"%@",proPrice2];
    hotBLabel2.numberOfLines = 0;
    hotBLabel2.adjustsFontSizeToFitWidth = YES;
    hotBLabel2.textColor = [UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1];
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabel2.font = PFR11Font;
    hotBLabel2.textAlignment = NSTextAlignmentCenter;
    hotBLabel2.frame = CGRectMake(2, hotBLabel.frame.origin.y+hotBLabel.frame.size.height, (BOUND_WIDTH-6)/4.0-4, 25);
  //  [ipadView addSubview:hotBLabel2];
    
    //左边一图片
    hotBottomIV =[[UIImageView alloc] init];
    // hotBottomIV.image = [UIImage imageNamed:@"ipadM"];
    [hotBottomIV sd_setImageWithURL:[NSURL URLWithString:hotPicture2] placeholderImage:[UIImage imageNamed:@"ipadM"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
    hotBottomIV.contentMode = UIViewContentModeScaleAspectFit;
    // hotBottomIV.backgroundColor = [UIColor greenColor];
    hotBottomIV.frame = CGRectMake(((BOUND_WIDTH-6)/4.0-55)/2, hotBLabel2.frame.origin.y+hotBLabel2.frame.size.height, 55, 80);
    [ipadView addSubview:hotBottomIV];
    UITapGestureRecognizer *ipadTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImage)];
    [hotBottomIV addGestureRecognizer:ipadTap];
    hotBottomIV.userInteractionEnabled = YES;
    
    //分割线
    UIImageView *cutBLine = [[UIImageView alloc] init];
    cutBLine.frame = CGRectMake((BOUND_WIDTH-6)/4.0, 0+168, 2, 140);
    cutBLine.backgroundColor = BGColor;
    [hotMailV addSubview:cutBLine];
    
#pragma mark-热卖底部 2 View
    //左一文字
    hotBLabelTwo = [[UILabel alloc] init];
    hotBLabelTwo.text = hotTitle3;//第四条数据
    hotBLabelTwo.numberOfLines = 0;
    
    hotBLabelTwo.adjustsFontSizeToFitWidth = YES;
    hotBLabelTwo.textColor = SYMAINColor;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabelTwo.font = PFR11Font;
    hotBLabelTwo.textAlignment = NSTextAlignmentCenter;
    hotBLabelTwo.frame = CGRectMake(2, 10, (BOUND_WIDTH-6)/4.0-4, 25);
    [ipadView2 addSubview:hotBLabelTwo];
    //左二文字
    hotBLabelTwo2 = [[UILabel alloc] init];
    hotBLabelTwo2.text = [NSString stringWithFormat:@"%@",proPrice3];
    hotBLabelTwo2.numberOfLines = 0;
    hotBLabelTwo2.adjustsFontSizeToFitWidth = YES;
    hotBLabelTwo2.textColor = [UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1];
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabelTwo2.font = PFR11Font;
    hotBLabelTwo2.textAlignment = NSTextAlignmentCenter;
    hotBLabelTwo2.frame = CGRectMake(0, hotBLabelTwo.frame.origin.y+hotBLabel.frame.size.height, (BOUND_WIDTH-6)/4.0, 25);
    //[ipadView2 addSubview:hotBLabelTwo2];
    
    //左边一图片
    hotBottomIVtwo =[[UIImageView alloc] init];
    // hotBottomIVtwo.image = [UIImage imageNamed:@"sanxingM"];
    [hotBottomIVtwo sd_setImageWithURL:[NSURL URLWithString:hotPicture3] placeholderImage:[UIImage imageNamed:@"sanxingM"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
    hotBottomIVtwo.contentMode = UIViewContentModeScaleAspectFit;
    // hotBottomIVtwo.backgroundColor = [UIColor greenColor];
    hotBottomIVtwo.frame = CGRectMake(((BOUND_WIDTH-6)/4.0-70)/2, hotBLabel2.frame.origin.y+hotBLabelTwo2.frame.size.height, 70, 80);
    [ipadView2 addSubview:hotBottomIVtwo];
    
    
    UITapGestureRecognizer *ipadTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImageTwo)];
    [hotBottomIVtwo addGestureRecognizer:ipadTap2];
    hotBottomIVtwo.userInteractionEnabled = YES;

    
    //分割线
    UIImageView *cutBLine2 = [[UIImageView alloc] init];
    cutBLine2.frame = CGRectMake((BOUND_WIDTH-2)/2.0, 0+168, 2, 140);
    cutBLine2.backgroundColor = BGColor;
    [hotMailV addSubview:cutBLine2];
#pragma mark-热卖底部  3 View
    //左一文字
    hotBLabelThird = [[UILabel alloc] init];
    hotBLabelThird.text = hotTitle4;//第五条数据
    hotBLabelThird.numberOfLines = 0;
    hotBLabelThird.adjustsFontSizeToFitWidth = YES;
    hotBLabelThird.textColor = SYMAINColor;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabelThird.font = PFR11Font;
    hotBLabelThird.textAlignment = NSTextAlignmentCenter;
    hotBLabelThird.frame = CGRectMake(2, 10, (BOUND_WIDTH-6)/4.0-4, 25);
    [ipadView3 addSubview:hotBLabelThird];
    //左二文字
    hotBLabelThird2 = [[UILabel alloc] init];
    hotBLabelThird2.text = [NSString stringWithFormat:@"%@",proPrice4];
    hotBLabelThird2.numberOfLines = 0;
    hotBLabelThird2.adjustsFontSizeToFitWidth = YES;
    hotBLabelThird2.textColor = [UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1];
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabelThird2.font = PFR11Font;
    hotBLabelThird2.textAlignment = NSTextAlignmentCenter;
    hotBLabelThird2.frame = CGRectMake(2, hotBLabelTwo.frame.origin.y+hotBLabel.frame.size.height, (BOUND_WIDTH-6)/4.0-4, 25);
    //[ipadView3 addSubview:hotBLabelThird2];
    
    //左边一图片
    hotBottomIVthird =[[UIImageView alloc] init];
    // hotBottomIVthird.image = [UIImage imageNamed:@"ipadM"];
    hotBottomIVthird.contentMode = UIViewContentModeScaleAspectFit;
    
    [hotBottomIVthird sd_setImageWithURL:[NSURL URLWithString:hotPicture4] placeholderImage:[UIImage imageNamed:@"ipadM"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
    
    UITapGestureRecognizer *ipadTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImageThird)];
    [hotBottomIVthird addGestureRecognizer:ipadTap3];
    hotBottomIVthird.userInteractionEnabled = YES;
    
    
    
    
    
    
    // hotBottomIVthird.backgroundColor = [UIColor greenColor];
    hotBottomIVthird.frame = CGRectMake(((BOUND_WIDTH-6)/4.0-55)/2, hotBLabel2.frame.origin.y+hotBLabelTwo2.frame.size.height, 55, 80);
    [ipadView3 addSubview:hotBottomIVthird];
    
    //分割线
    UIImageView *cutBLine3 = [[UIImageView alloc] init];
    cutBLine3.frame = CGRectMake((BOUND_WIDTH-2)/4.0*3, 0+168, 2, 140);
    cutBLine3.backgroundColor = BGColor;
    [hotMailV addSubview:cutBLine3];
#pragma mark-热卖底部  4 View
    //左一文字
    hotBLabelFour = [[UILabel alloc] init];
    hotBLabelFour.text = hotTitle5;//第六条数据
    hotBLabelFour.numberOfLines = 0;
    hotBLabelFour.adjustsFontSizeToFitWidth = YES;
    hotBLabelFour.textColor = SYMAINColor;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabelFour.font = PFR11Font;
    hotBLabelFour.textAlignment = NSTextAlignmentCenter;
    hotBLabelFour.frame = CGRectMake(2, 10, (BOUND_WIDTH-6)/4.0-4, 25);
    [ipadView4 addSubview:hotBLabelFour];
    //左二文字
    hotBLabelFour2 = [[UILabel alloc] init];
    hotBLabelFour2.text = [NSString stringWithFormat:@"%@",proPrice5];
    hotBLabelFour2.numberOfLines = 0;
    hotBLabelFour2.adjustsFontSizeToFitWidth = YES;
    hotBLabelFour2.textColor = [UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1];
    //ttleftLabel.backgroundColor = [UIColor redColor];
    hotBLabelFour2.font = PFR11Font;
    hotBLabelFour2.textAlignment = NSTextAlignmentCenter;
    hotBLabelFour2.frame = CGRectMake(2, hotBLabelTwo.frame.origin.y+hotBLabel.frame.size.height, (BOUND_WIDTH-6)/4.0-4, 25);
   // [ipadView4 addSubview:hotBLabelFour2];
    
    //左边一图片
    hotBottomIVfour =[[UIImageView alloc] init];
    // hotBottomIVfour.image = [UIImage imageNamed:@"sanxingM"];
    [hotBottomIVfour sd_setImageWithURL:[NSURL URLWithString:hotPicture5] placeholderImage:[UIImage imageNamed:@"sanxingM"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
    // hotBottomIVfour.backgroundColor = [UIColor greenColor];
    hotBottomIVfour.frame = CGRectMake(((BOUND_WIDTH-6)/4.0-70)/2, hotBLabel2.frame.origin.y+hotBLabelTwo2.frame.size.height, 70, 80);
    hotBottomIVfour.contentMode = UIViewContentModeScaleAspectFit;
    [ipadView4 addSubview:hotBottomIVfour];

    UITapGestureRecognizer *ipadTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickiPadImageFour)];
    [hotBottomIVfour addGestureRecognizer:ipadTap4];
    hotBottomIVfour.userInteractionEnabled = YES;
    
    
    _scrollVH +=5;
     //手机快修-二手精品-视图
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = [UIColor whiteColor];
    contentV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, BOUND_WIDTH*0.426);
    _scrollVH +=BOUND_WIDTH*0.426;
    [_scrollV addSubview:contentV];
    
    
#pragma mark-手机快修
    UIView *kuaixiuV = [[UIView alloc] init];
    kuaixiuV.frame = CGRectMake(0, 0, (BOUND_WIDTH-2)/2.0, BOUND_WIDTH*0.426);
    UITapGestureRecognizer *kxTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kxTapAction)];
    [kuaixiuV addGestureRecognizer:kxTap];
    kuaixiuV.userInteractionEnabled = YES;
    [contentV addSubview:kuaixiuV];

    //左一文字
    kxleftLabel = [[UILabel alloc] init];
    kxleftLabel.text = @"手机维修";
    kxleftLabel.numberOfLines = 0;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    kxleftLabel.font = PFR15Font;
    kxleftLabel.textAlignment = NSTextAlignmentCenter;
    kxleftLabel.frame = CGRectMake(5, 5, (BOUND_WIDTH-2)/2.0-10, 30);
    [kuaixiuV addSubview:kxleftLabel];
    //左二文字
    kxleftLabel2 = [[UILabel alloc] init];
    kxleftLabel2.text = @"舍不得卖,就好好修";
    kxleftLabel2.numberOfLines = 0;
    kxleftLabel2.textColor = [UIColor darkGrayColor];
    //ttleftLabel.backgroundColor = [UIColor redColor];
    kxleftLabel2.font = PFR12Font;
    kxleftLabel2.textAlignment = NSTextAlignmentCenter;
    kxleftLabel2.frame = CGRectMake(5, kxleftLabel.frame.origin.y+kxleftLabel.frame.size.height, (BOUND_WIDTH-2)/2.0-10, 30);
    [kuaixiuV addSubview:kxleftLabel2];
    
    //(BOUND_WIDTH-2)/4.0*0.86/1.72*3.72;
    //左边一图片
    kxLeftIV =[[UIImageView alloc] init];
    kxLeftIV.contentMode = UIViewContentModeScaleAspectFit;
    kxLeftIV.image = [UIImage imageNamed:@"kuaixiuM"];
    //kxLeftIV.backgroundColor = [UIColor greenColor];
    kxLeftIV.frame = CGRectMake(0, kxleftLabel2.frame.origin.y+kxleftLabel2.frame.size.height, (BOUND_WIDTH-2)/4.0*0.86/1.72*3.72, (BOUND_WIDTH-2)/4.0*0.86);//x:(BOUND_WIDTH-2)/8.0 h: (BOUND_WIDTH-2)/4.0
    [kuaixiuV addSubview:kxLeftIV];
    
    //分割线
    UIImageView *kxCutLine = [[UIImageView alloc] init];
    kxCutLine.frame = CGRectMake((BOUND_WIDTH-2)/2.0, 0, 2, contentV.frame.size.height);
    kxCutLine.backgroundColor = BGColor;
    [contentV addSubview:kxCutLine];

#pragma mark-二手精品
    UIView *jinpinV = [[UIView alloc] init];
    jinpinV.frame = CGRectMake((BOUND_WIDTH-2)/2.0+2, 0, (BOUND_WIDTH-2)/2.0, BOUND_WIDTH*0.426);
    
    UITapGestureRecognizer *jpTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jpTapAction)];
    [jinpinV addGestureRecognizer:jpTap];
    jinpinV.userInteractionEnabled = YES;

    
    [contentV addSubview:jinpinV];

    
    //左一文字
    jpleftLabel = [[UILabel alloc] init];
    jpleftLabel.text = @"二手精品";
    jpleftLabel.numberOfLines = 0;
    //ttleftLabel.backgroundColor = [UIColor redColor];
    jpleftLabel.font = PFR15Font;
    jpleftLabel.textAlignment = NSTextAlignmentCenter;
    jpleftLabel.frame = CGRectMake(5, 5, (BOUND_WIDTH-2)/2.0-10, 30);
    [jinpinV addSubview:jpleftLabel];
    //左二文字
    jpleftLabel2 = [[UILabel alloc] init];
    jpleftLabel2.text = @"舍不得卖,就好好修";
    jpleftLabel2.numberOfLines = 0;
    jpleftLabel2.textColor = [UIColor darkGrayColor];
    //ttleftLabel.backgroundColor = [UIColor redColor];
    jpleftLabel2.font = PFR12Font;
    jpleftLabel2.textAlignment = NSTextAlignmentCenter;
    jpleftLabel2.frame = CGRectMake(5, jpleftLabel.frame.origin.y+jpleftLabel.frame.size.height, (BOUND_WIDTH-2)/2.0-10, 30);
    [jinpinV addSubview:jpleftLabel2];
    
    //左边一图片
   jpIV =[[UIImageView alloc] init];
    jpIV.contentMode = UIViewContentModeScaleAspectFit;
    jpIV.image = [UIImage imageNamed:@"jinpinM"];
  //  jpIV.backgroundColor = [UIColor greenColor];
    jpIV.frame = CGRectMake(0, jpleftLabel2.frame.origin.y+jpleftLabel2.frame.size.height, (BOUND_WIDTH-2)/4.0*0.86/1.72*3.72, (BOUND_WIDTH-2)/4.0*0.86);
    [jinpinV addSubview:jpIV];
    
    _scrollVH +=5;
    
    
    
    
#pragma mark-最底部视图
    //最底部-视图
    UIView *allBottomV = [[UIView alloc] init];
    allBottomV.backgroundColor = [UIColor whiteColor];
    allBottomV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, BOUND_WIDTH*0.245);
    _scrollVH +=BOUND_WIDTH*0.245+8;
    [_scrollV addSubview:allBottomV];
    
    
    
    biv1 =[[UIImageView alloc] init];
    biv1.image = [UIImage imageNamed:@"huaibaoM"];
    //biv1.backgroundColor = [UIColor greenColor];
    biv1.frame = CGRectMake(0, 0, (BOUND_WIDTH-2)/3.0, allBottomV.frame.size.height);
    [allBottomV addSubview:biv1];

    
    UITapGestureRecognizer *bivTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBivImage)];
    [biv1 addGestureRecognizer:bivTap1];
    biv1.userInteractionEnabled = YES;

    
    
    biv2 =[[UIImageView alloc] init];
    biv2.image = [UIImage imageNamed:@"qiyeM"];
   // biv2.backgroundColor = [UIColor greenColor];
    biv2.frame = CGRectMake((BOUND_WIDTH-2)/3.0+1, 0, (BOUND_WIDTH-2)/3.0, allBottomV.frame.size.height);
    [allBottomV addSubview:biv2];

    
    UITapGestureRecognizer *bivTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBivImage2)];
    [biv2 addGestureRecognizer:bivTap2];
    biv2.userInteractionEnabled = YES;

    
    biv3 =[[UIImageView alloc] init];
    biv3.image = [UIImage imageNamed:@"jiamengM"];
   // biv3.backgroundColor = [UIColor greenColor];
    biv3.frame = CGRectMake((BOUND_WIDTH-2)/3.0+1+(BOUND_WIDTH-2)/3.0+1, 0, (BOUND_WIDTH-2)/3.0, allBottomV.frame.size.height);
    [allBottomV addSubview:biv3];

    
    UITapGestureRecognizer *bivTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBivImage3)];
    [biv3 addGestureRecognizer:bivTap3];
    biv3.userInteractionEnabled = YES;
    
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);
}


-(void)clickBivImage{
//    DaZongRecycleVC *qvc = [[DaZongRecycleVC alloc] init];
//    qvc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:qvc animated:YES];
}
-(void)clickBivImage2{//企业回收
//    QiYeRecycleVC *qvc = [[QiYeRecycleVC alloc] init];
//    qvc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:qvc animated:YES];
    
    DaZongRecycleVC *qvc = [[DaZongRecycleVC alloc] init];
    qvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qvc animated:YES];

    
}
-(void)clickBivImage3{
    
    
    JMSApplyViewController *qvc = [[JMSApplyViewController alloc] init];
    qvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qvc animated:YES];

//    LJWebViewController *ZSWWebView = [[LJWebViewController alloc] init];
//    ZSWWebView.title = @"链旧";
//    ZSWWebView.url= ipadBtnUrl2;
//    ZSWWebView.hidesBottomBarWhenPushed = YES;
//    if (ipadBtnUrl2.length>0) {
//        [self.navigationController pushViewController:ZSWWebView animated:YES];
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //    if (scrollPhotoList.count>0) {
    //
    //    }
}
#pragma mark - 跑马灯view上的关闭按钮点击时回调
- (void)marqueeView:(CQMarqueeView *)marqueeView{
    NSLog(@"点击了视图");
}
#pragma mark - 二手精品
-(void)jpTapAction{
    //二手精品
    UsedGoodsVC *uvc = [[UsedGoodsVC alloc] init];
    uvc.title = @"恋旧优品";
    uvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uvc animated:YES];
}
#pragma mark - 手机快修
-(void)kxTapAction{
    //手机快修
    PhoneMaintainVC *uvc = [[PhoneMaintainVC alloc] init];
    uvc.title = @"手机快修";
    uvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uvc animated:YES];

}
@end
