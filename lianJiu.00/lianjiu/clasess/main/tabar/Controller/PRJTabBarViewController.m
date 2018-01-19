//
//  IWTabBarViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
/** tableBar */

#import "PRJTabBarViewController.h"
#import "UIImage+MJ.h"
#import "PRJTabBar.h"
#import "HomeVC.h"
#import "SellScrapVC.h"
#import "SellPhoneVC.h"
#import "HomeApliancesVC.h"
#import "MeVC.h"

#import "DCCommodityViewController.h"


@interface PRJTabBarViewController () <PRJTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) PRJTabBar *customTabBar;
@end

@implementation PRJTabBarViewController
{
    BOOL fistReload;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    //注册通知，用于接收改变语言的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
   // [self setupAllChildViewControllersWithXib];
    
    [self setupAllChildViewControllers];
   

//    [self changeLanguage];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
  
// 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    if (!fistReload) {
     //   [self changeLanguage];
        fistReload = YES;
    }
    
}
- (void)setToIndex:(NSInteger)toIndex
{
    _toIndex = toIndex;
    PRJTabBar *tab;
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[PRJTabBar class]]) {
            tab = (PRJTabBar*)child;
        }
    }
    [tab buttonClick:tab.subviews[toIndex]];
}
/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    PRJTabBar *customTabBar = [[PRJTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(PRJTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    
    HomeVC *homeVC = [[HomeVC alloc] init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"home" selectedImageName:@"home_ok"];
   
    
    
    
    SellScrapVC *scrapVC = [[SellScrapVC alloc] init];
    [self setupChildViewController:scrapVC title:@"卖废品" imageName:@"feipin" selectedImageName:@"feipin_ok"];

   
   
    
//    DCCommodityViewController *phoneVC = [[DCCommodityViewController alloc] init];
//    [self setupChildViewController:phoneVC title:@"卖手机" imageName:@"phone" selectedImageName:@"phone_ok"];
    
    SellPhoneVC *phoneVC = [[SellPhoneVC alloc] init];
    [self setupChildViewController:phoneVC title:@"卖手机" imageName:@"phone" selectedImageName:@"phone_ok"];
    
  
    
    
    
    
    
    
    HomeApliancesVC *recycleVC = [[HomeApliancesVC alloc] init];
    [self setupChildViewController:recycleVC title:@"卖家电" imageName:@"Sell-scrap" selectedImageName:@"Sell-scrap_ok"];
    
    
    
    
    MeVC *me = [[MeVC alloc] init];
    [self setupChildViewController:me title:@"个人中心" imageName:@"user" selectedImageName:@"user_ok"];
}

//storyboarg加载
//- (void)setupAllChildViewControllersWithXib
//{
//   
//    
//    // 2.供求信息
//    [self setupChildViewControllerWithXib:@"供求信息" imageName:@"mail_tag_gongqiu" selectedImageName:@"mail_tag_gongqiu_ok"];
//    // 1.现货交易
//    [self setupChildViewControllerWithXib:@"现货交易" imageName:@"mail_tag_jingbiao" selectedImageName:@"mail_tag_jingpai_ok"];
//    // 3.上门回收
//    [self setupChildViewControllerWithXib:@"资讯行情" imageName:@"zxhqNOSelect" selectedImageName:@"zxhq"];
//    
//    // 4.个人中心
//    [self setupChildViewControllerWithXib:@"个人中心" imageName:@"mail_tag_geren" selectedImageName:@"mail_tag_geren_ok"];
//    // 4.个人中心
//    [self setupChildViewControllerWithXib:@"个人中心" imageName:@"mail_tag_geren" selectedImageName:@"mail_tag_geren_ok"];
//    
//}
/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (isIOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}
- (void)setupChildViewControllerWithXib:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置图标
    UIImage *image= [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (isIOS7) {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:tabBarItem];
}
//- (void)changeLanguage
//{
//
//     NSArray *arr = @[@"供求信息",@"现货交易",@"资讯行情",@"个人中心",@"个人中心2"];
//    int j=0;
//    for (int i= 0;i<self.customTabBar.subviews.count;i++) {
//        UIView *childView = self.customTabBar.subviews[i];
//        if ([childView isKindOfClass:[PRJTabBarButton class]]) {
//            PRJTabBarButton *btn = (PRJTabBarButton *)childView;
//            [btn setTitle:CustomLocalizedString(arr[j], nil) forState:UIControlStateNormal];
//            [btn setTitle:CustomLocalizedString(arr[j], nil) forState:UIControlStateSelected];
//            j++;
//        }
//    }
//
//    for (int i =0; i<self.viewControllers.count; i++) {
//        UINavigationController *nav = self.viewControllers[i];
//        if (i==0) {
////            BidVC *bidVc = (BidVC *)nav.viewControllers.firstObject;
////            [bidVc reloadSubViews];
//            
//            
//            SupplyAndDemandTableVC *Vc = (SupplyAndDemandTableVC *)nav.viewControllers.firstObject;
//            [Vc reloadSubViews];
//
//        }else if(i==1){
////            SupplyAndDemandTableVC *Vc = (SupplyAndDemandTableVC *)nav.viewControllers.firstObject;
////            [Vc reloadSubViews];
//            
//            
//            BidVC *bidVc = (BidVC *)nav.viewControllers.firstObject;
//           
//            
//        }else if(i==2){
//            InformationViewController *Vc = (InformationViewController *)nav.viewControllers.firstObject;
//            [Vc reloadSubViews];
//        }else if(i==3){
//            MeVC *VC = (MeVC *)nav.viewControllers.firstObject;
//            [VC reloadSubViews];
//        }else if(i==4){
//            MeVC *VC2 = (MeVC *)nav.viewControllers.firstObject;
//          
//        }
//    }
//}
- (void)dealloc
{
    HZLog(@"%@---dealloc",self.class);
}
@end
