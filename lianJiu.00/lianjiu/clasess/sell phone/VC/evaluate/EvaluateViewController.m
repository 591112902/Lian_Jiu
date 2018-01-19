//
//  EvaluateViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/12.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "EvaluateViewController.h"
#import "EvaluateHeadView.h"
#import "EvaluateFooterView.h"
//#import "OderViewController.h"
//#import "AllRecycleCarViewController.h"
#import "SegmentViewController.h"
#import "MainTouchTableTableView.h"
#import "MYSegmentView.h"
@interface EvaluateViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
     CGFloat  headViewHeight;
    NSMutableArray *_ProductDataSour;
    NSMutableArray *_JQDataSour;
    
    CALayer *layer;
    
    EvaluateFooterView *footerView;
    
    NSString *sellPhoneClick;NSString *jiaDianClick;
    
}

@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, strong) MainTouchTableTableView *tableView;
@property (nonatomic, strong) MYSegmentView *segmentView;
//@property (nonatomic, strong) UIImageView *headImageView;


@property (nonatomic,strong) EvaluateHeadView *headerView;
@property (nonatomic,strong) JDEvaluateHeadView *JDheaderView;



@end

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

@implementation EvaluateViewController
{
    UIWebView *_webView;
}
-(void)clickkefuView{
    if (self.isPhoneNotJD) {//手机
        
    }else{//家电
        
        
    }

    // 提示：不要将webView添加到self.view，如果添加会遮挡原有的视图
    // 懒加载
    
    // 提示：不要将webView添加到self.view，如果添加会遮挡原有的视图
    // 懒加载
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://4001818209"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
 
    
    
    
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001818209"];
//    UIWebView * callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:callWebview];
//    
    
}
-(void)clickhscView:(UITapGestureRecognizer *)tap{
    //UIView *imgeV = (UIImageView *)tap.view;
    //回收车
    if (self.isPhoneNotJD) {//手机
        
    }else{//家电
        
        
    }

    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [def boolForKey:@"islogin"];
    if (!islogin) {
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否登录？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self.tabBarController presentViewController:nav animated:YES completion:^{
            }];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        //[MBProgressHUD showNotPhotoError:@"尚未登录" toView:self.view];
        return;
    }
    
    
    //回收车
    CallBackCarViewController *uvc = [[CallBackCarViewController alloc] init];
    uvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uvc animated:YES];

}

-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 1.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 1.0f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [layer addAnimation:groups forKey:@"group"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    [anim def];
    if (anim == [layer animationForKey:@"group"]) {
        //_btn.enabled = YES;
        
        [layer removeFromSuperlayer];
        layer = nil;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [footerView.recycleImageView.layer addAnimation:shakeAnimation forKey:nil];
        
         [MBProgressHUD showNotPhotoError:@"加入回收车成功" toView:[UIApplication sharedApplication].keyWindow];
    }
}

-(void)hscBtnAction{
 //加入回收车
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [def boolForKey:@"islogin"];
    NSString *uid = [def objectForKey:@"userId"];
    if (!islogin) {
        
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否登录？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self.tabBarController presentViewController:nav animated:YES completion:^{
            }];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        
       // [MBProgressHUD showNotPhotoError:@"尚未登录" toView:self.view];
        return;
    }
    
    
    if (sellPhoneClick.length>0 || jiaDianClick.length>0) {
        [MBProgressHUD showNotPhotoError:@"该商品已加入回收车" toView:self.view];
        return;
    }
    
    
    ProductModel *model = _ProductDataSour[0];
    NSLog(@"para:%@",@{@"orItemsProductId":model.productId?model.productId:@"",@"orItemsName":_titleStr?_titleStr:@"",@"orItemsPicture":model.productMasterPicture?model.productMasterPicture:@"",@"orItemsStemFrom":@"0",@"orItemsParam":model.productParamData?model.productParamData:@"",@"orItemsPrice":model.productPrice?model.productPrice:@"",@"orItemsVolume":@"1",@"userId":uid,@"orItemsPriceUnit":@"7"});
    
    
    if (self.isPhoneNotJD) {//手机
        [networking AFNPOST:ADDTOEXPRESSPRODUCTCAR withparameters:@{@"orItemsProductId":model.productId?model.productId:@"",@"orItemsName":_titleStr?_titleStr:@"",@"orItemsPicture":model.productMasterPicture?model.productMasterPicture:@"",@"orItemsStemFrom":@"0",@"orItemsParam":model.productParamData?model.productParamData:@"",@"orItemsPrice":model.productPrice?model.productPrice:@"",@"orItemsVolume":@"1",@"userId":uid,@"orItemsPriceUnit":@"7"} success:^(NSMutableDictionary *dic) {
            
            
            if (!layer) {
                
                sellPhoneClick = @"sellPhoneClick";
                
                layer = [CALayer layer];
                layer.contents = (__bridge id)[UIImage imageNamed:@"test0n.png"].CGImage;
                layer.contentsGravity = kCAGravityResizeAspectFill;
                layer.bounds = CGRectMake(0, 0, 25, 25);
                [layer setCornerRadius:CGRectGetHeight([layer bounds]) / 2];
                layer.masksToBounds = YES;
                layer.position =CGPointMake(50, 150);
                [self.view.layer addSublayer:layer];
            }
            [self groupAnimation];

            
            
            
            
            //[MBProgressHUD showNotPhotoError:@"加入回收车成功" toView:[UIApplication sharedApplication].keyWindow];
        } error:nil HUDAddView:self.view];

    }else{//家电
        [networking AFNPOST:INTRODUCTIONPRDUCT withparameters:@{@"orItemsProductId":model.productId?model.productId:@"",@"orItemsName":_titleStr?_titleStr:@"",@"orItemsPicture":model.productMasterPicture?model.productMasterPicture:@"",@"orItemsStemFrom":@"1",@"orItemsParam":model.productParamData?model.productParamData:@"",@"orItemsPrice":model.productPrice?model.productPrice:@"",@"orItemsNum":@"1",@"userId":uid,@"orItemsPriceUnit":@"4"} success:^(NSMutableDictionary *dic) {
            
            
            
            if (!layer) {
                jiaDianClick = @"jiaDianClick";
                
                layer = [CALayer layer];
                layer.contents = (__bridge id)[UIImage imageNamed:@"test0n.png"].CGImage;
                layer.contentsGravity = kCAGravityResizeAspectFill;
                layer.bounds = CGRectMake(0, 0, 25, 25);
                [layer setCornerRadius:CGRectGetHeight([layer bounds]) / 2];
                layer.masksToBounds = YES;
                layer.position =CGPointMake(50, 150);
                [self.view.layer addSublayer:layer];
            }
            [self groupAnimation];

            
            
           
        } error:nil HUDAddView:self.view];

    }
    
}
-(void)sellBtnAction{
    //立即卖掉
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [def boolForKey:@"islogin"];
    NSString *uid = [def objectForKey:@"userId"];
    if (!islogin) {
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否登录？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self.tabBarController presentViewController:nav animated:YES completion:^{
            }];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

       // [MBProgressHUD showNotPhotoError:@"尚未登录" toView:self.view];
        return;
    }
    
    
    
    
    if (self.isPhoneNotJD) {
        
        if ([_headerView.priceL.text doubleValue] < 50) {
            
            [MBProgressHUD showNotPhotoError: @"订单未满50元，可先加入回收车。" toView:self.view];
            return;

        }
        
    }else{
        if ([_JDheaderView.priceL.text doubleValue] < 10) {
            
            [MBProgressHUD showNotPhotoError: @"需要满10元才可以提交订单，请先加入回收车" toView:self.view];
            return;
            
        }
    }
    
    
    
    
    ProductModel *model = _ProductDataSour[0];
    if (self.isPhoneNotJD) {//手机--快递--立即卖掉
       // [footerView.sellBtn setTitle:@"立即卖掉" forState:UIControlStateNormal];
        
        NSLog(@"手机--快递--立即卖掉:%@",@{@"orItemsProductId":model.productId?model.productId:@"",@"orItemsName":_titleStr?_titleStr:@"",@"orItemsPicture":model.productMasterPicture?model.productMasterPicture:@"",@"orItemsStemFrom":@"0",@"orItemsParam":model.productParamData?model.productParamData:@"",@"orItemsPrice":model.productPrice?model.productPrice:@"",@"orItemsVolume":@"1",@"userId":uid,@"orItemsPriceUnit":@"7",@"orItemsNum":@"1"});
        
        [networking AFNPOST:DIRECTEXPRESSSALE withparameters:@{@"orItemsProductId":model.productId?model.productId:@"",@"orItemsName":_titleStr?_titleStr:@"",@"orItemsPicture":model.productMasterPicture?model.productMasterPicture:@"",@"orItemsStemFrom":@"0",@"orItemsParam":model.productParamData?model.productParamData:@"",@"orItemsPrice":model.productPrice?model.productPrice:@"",@"orItemsVolume":@"1",@"userId":uid,@"orItemsPriceUnit":@"7",@"orItemsNum":@"1"} success:^(NSMutableDictionary *dic) {
            
            
            
            ExpressRecycleOrderVC *uvc = [[ExpressRecycleOrderVC alloc] init];
            uvc.title = @"快递回收";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
            
            // [MBProgressHUD showNotPhotoError:@"成功加入" toView:self.view];
            
        } error:nil HUDAddView:self.view];

        
    } else {//家电--上门
       // [footerView.sellBtn setTitle:@"上门回收" forState:UIControlStateNormal];
        
        [networking AFNPOST:DIRECTSUBMIT withparameters:@{@"orItemsProductId":model.productId?model.productId:@"",@"orItemsName":_titleStr?_titleStr:@"",@"orItemsPicture":model.productMasterPicture?model.productMasterPicture:@"",@"orItemsStemFrom":@"1",@"orItemsParam":model.productParamData?model.productParamData:@"",@"orItemsPrice":model.productPrice?model.productPrice:@"",@"orItemsNum":@"1",@"orItemsVolume":@"1",@"userId":uid,@"orItemsPriceUnit":@"4"} success:^(NSMutableDictionary *dic) {
            
            NSLog(@"家电--上门%@",dic);
            NSDictionary *lianjiuData = dic[@"lianjiuData"];
            NSString *imageStr = lianjiuData[@"maximage"];
            NSArray *plArr = lianjiuData[@"productIdList"];
            NSString *totalprice = lianjiuData[@"totalprice"];
            
            
            
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *userId = [user objectForKey:@"userId"];
            AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            UIView *superView = [UIApplication sharedApplication].keyWindow;
            [MBProgressHUD showHUDAddedTo:superView animated:YES];
            [manager GET:[NSString stringWithFormat:@"%@/%@",SELECTADDRESSDEFAULT,userId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSNumber *code=dic[@"status"];
                int c = [code intValue];
                
                if (c==200) {
                    
                    NSDictionary *lianjiuData = [dic objectForKey:@"lianjiuData"];
                    NSDictionary *address = [lianjiuData objectForKey:@"address"];
                    BOOL b = (BOOL)[address objectForKey:@"userDefault"];
                    
                    
                    ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                    smVC.price = totalprice;
                    smVC.userDefault = b;
                    smVC.address = address;
                    smVC.goodImageViewStr = imageStr;
                    if (plArr.count>0) {
                        smVC.productIdList = plArr[0];
                    }
                    [self.navigationController pushViewController:smVC animated:YES];
                    
                    
                }else if (c==500) {//没有设置默认地址",
                    
                    ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                    smVC.price = totalprice;
                    smVC.userDefault = NO;
                    smVC.goodImageViewStr = imageStr;
                    if (plArr.count>0) {
                        smVC.productIdList = plArr[0];
                    }
                    [self.navigationController pushViewController:smVC animated:YES];
                    
                    
                }else{
                    
                    ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                    smVC.price = totalprice;
                    smVC.userDefault = NO;
                    smVC.goodImageViewStr = imageStr;
                    if (plArr.count>0) {
                        smVC.productIdList = plArr[0];
                    }
                    [self.navigationController pushViewController:smVC animated:YES];
                    
                }
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                [MBProgressHUD showError:@"网络不给力" toView:superView];
            }];
            
            
        } error:nil HUDAddView:self.view];

        
    }
    
    
}

-(void)requestPrice{
    NSString *url;
    if (_isPhoneNotJD) {//shoji
        url = CALCULATIONPRICE;
    }else{//jia dian
        url = CALCULATIONJDPRICE;
    }
    [networking AFNPOST:url withparameters:@{@"TAKEN":_tokenStr} success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *lianjiuData = dic[@"lianjiuData"];
            if ([lianjiuData[@"product"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *product = lianjiuData[@"product"];
                ProductModel *model = [ProductModel ModelWith:product ];
                [_ProductDataSour addObject:model];
            }
            
            
            if (self.isPhoneNotJD) {
                _headerView.priceL.text = [NSString stringWithFormat:@"%@元",lianjiuData[@"productPrice"]?lianjiuData[@"productPrice"]:@""];
            }else{
                 _JDheaderView.priceL.text = [NSString stringWithFormat:@"%@元",lianjiuData[@"productPrice"]?lianjiuData[@"productPrice"]:@""];
            }
            
            
            
            
            
            
            if ([lianjiuData[@"item"] isKindOfClass:[NSArray class]]) {
                NSArray *item = lianjiuData[@"item"];
                for (NSDictionary *temp in item) {
                    
                    JinQiJiaModel *model = [JinQiJiaModel ModelWith:temp ];
                    
                    if (_isPhoneNotJD) {
                        model.hsfs = @"快递回收";//快递回收
                        
                    }else {
                        model.hsfs = @"上门回收";
                    }
                    
                    [_JQDataSour addObject:model];
                }
            }
            
            [_tableView reloadData];
            
        }
    } error:nil HUDAddView:self.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _ProductDataSour = [[NSMutableArray alloc] init];
    
    
    _JQDataSour = [[NSMutableArray alloc] init];
  
    
    
    
    NSLog(@"isPhone_BOOL:%d___",_isPhoneNotJD);
    
    self.title = _titleStr;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    headViewHeight = [UIScreen mainScreen].bounds.size.width/320.0*307;
  
    
    
    footerView = [[[NSBundle mainBundle]loadNibNamed:@"EvaluateFooterView" owner:nil options:nil]lastObject];
    footerView.frame = CGRectMake(0, BOUND_HIGHT-50, [UIScreen mainScreen].bounds.size.width, 50);
    
    if (self.isPhoneNotJD) {
        [footerView.sellBtn setTitle:@"立即卖掉" forState:UIControlStateNormal];
    } else {
        [footerView.sellBtn setTitle:@"上门回收" forState:UIControlStateNormal];
    }
    
    UITapGestureRecognizer *kefuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickkefuView)];
    [footerView.kefuView addGestureRecognizer:kefuTap];
    footerView.kefuView.userInteractionEnabled = YES;

    UITapGestureRecognizer *hscTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhscView:)];
    [footerView.huishoucheView addGestureRecognizer:hscTap];
    footerView.huishoucheView.userInteractionEnabled = YES;

    [footerView.hscBtn addTarget:self action:@selector(hscBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView.sellBtn addTarget:self action:@selector(sellBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:[self tableView]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leaveTop:) name:@"leaveTop" object:nil];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    if (self.isPhoneNotJD) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"EvaluateHeadView" owner:nil options:nil]lastObject];
        _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*307);
        _headerView.hsfsL.text = @"回收方式:快递回收";//回收方式:快递回收
        [_headerView.pgBtn addTarget:self action:@selector(pgBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableHeaderView =_headerView;

    }else{
        _JDheaderView = [[[NSBundle mainBundle]loadNibNamed:@"JDEvaluateHeadView" owner:nil options:nil]lastObject];
        _JDheaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*153);
        _JDheaderView.hsfsL.text = @"回收方式:上门回收";
        [_JDheaderView.pgBtn addTarget:self action:@selector(pgBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableHeaderView =_JDheaderView;
    }
    
    
    
    
    
    
    
    [self.view addSubview:footerView];
    [self requestPrice];
    
    self.path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/8.0*5, [UIScreen mainScreen].bounds.size.height-50)];
    [_path addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/8.0*3, [UIScreen mainScreen].bounds.size.height-50) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0)];
}

-(void)pgBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leaveTop:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     * 处理联动
     */
    //获取滚动视图y值的偏移量
    // CGFloat yOffset  = scrollView.contentOffset.y;
    // self.navigationController.navigationBar.alpha = (headViewHeight+yOffset)/(headViewHeight-64);
    
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y-64.0f;
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"EEEEtabOffsetY:%f   offsetY: %f",tabOffsetY,offsetY);

    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    
    if (offsetY >= tabOffsetY) {
        
        //不能滑动
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
        
    }else{
        
        //可以滑动
        _isTopIsCanNotMoveTabView = NO;
        
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"子视图控制器滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"父视图控制器滑动到顶端");
            if (!_canScroll) {
                
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[MainTouchTableTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //_tableView.contentInset = UIEdgeInsetsMake(headViewHeight, 0, 0, 0);
        _tableView.rowHeight = KHeight;
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ProductModel *model = _ProductDataSour.count>0?_ProductDataSour[0]:[[ProductModel  alloc]init];
    SegmentViewController *jqVC = [[SegmentViewController alloc] init];
    jqVC.typeStr = @"近期交易";
    jqVC.productId = model.productId;
    jqVC.tokenS = _tokenStr;
    jqVC.isPhone =_isPhoneNotJD;
    jqVC.dataSour = _JQDataSour;
    [jqVC reloadJQTableView];
    
    PLSegmentViewController *secondViewController = [[PLSegmentViewController alloc] init];
    // secondViewController.typeStr = @"用户评价";
    secondViewController.productId = model.productId;
    if (self.isPhoneNotJD) {//手机kudaidii；快递回收4
        secondViewController.type = @"4";
    }else{//家电sahgnmen 上门回收，3
        secondViewController.type = @"3";
    }
    
    
    
    secondViewController.isDown = YES;
    [secondViewController requestDataPingLun:secondViewController.productId];
    secondViewController.tokenS = _tokenStr;
    NSArray *controllerArray = @[jqVC, secondViewController];
    NSArray *titleArray = @[@"近期交易", @"用户评价"];
    CGFloat lineWidth = [@"用户评价" boundingRectWithSize:CGSizeMake(100, 21) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.width;
    MYSegmentView *tempView = [[MYSegmentView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-64) controllers:controllerArray titleArray:titleArray ParentController:self lineWidth:lineWidth lineHeight:3.];
    _segmentView = tempView;
     [cell.contentView addSubview:self.segmentView];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
