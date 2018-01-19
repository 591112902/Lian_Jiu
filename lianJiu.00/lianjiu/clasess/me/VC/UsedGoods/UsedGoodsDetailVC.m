//
//  UsedGoodsDetailVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/19.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "DCFillinOrderViewController.h"

#import "UsedGoodsDetailVC.h"

#import "UIImageView+WebCache.h"
#import "ProdctCanShu.h"//gai
#import "MainTouchTableTableView.h"
#import "MYSegmentView.h"
#import "ProdctPingJia.h"
#import "SHFW.h"
#import "DCFeatureSelectionViewController.h"

// Categories
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

@interface UsedGoodsDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, strong) MainTouchTableTableView *tableView;
@property (nonatomic, strong) MYSegmentView *segmentView;
//@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) NSMutableArray *spsxDataArr;
@property (nonatomic, strong) NSString *goodImageViewStr;

/* 通知 */
@property (weak ,nonatomic) id dcObj;

@end
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString *lastNum_;
static NSArray *lastSeleArray_;

@implementation UsedGoodsDetailVC
{
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
-(void)maiAction{
    NSLog(@"selllllll");
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    if (uid.length == 0) {
        
        
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

        
        
        
      //  [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    [manager GET:[NSString stringWithFormat:@"%@/%@",SELECTADDRESSDEFAULT,uid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dic[@"status"];
        int c = [code intValue];
        
        if (c==200) {
            
            NSDictionary *lianjiuData = [dic objectForKey:@"lianjiuData"];
            NSDictionary *address = [lianjiuData objectForKey:@"address"];
            BOOL b = (BOOL)[address objectForKey:@"userDefault"];
            
            DCFillinOrderViewController *dcFillVc = [[DCFillinOrderViewController alloc] init];
            dcFillVc.userDefault = b;
            dcFillVc.address = address;
            
            [self.navigationController pushViewController:dcFillVc animated:YES];
            
            if (_headerView.priceL.text.length>1) {
                
                dcFillVc.price = [_headerView.priceL.text substringFromIndex:1];
            }else{
                dcFillVc.price = _headerView.priceL.text;
            }

            //dcFillVc.price = _headerView.priceL.text;
            dcFillVc.name = _headerView.nameL.text;
            dcFillVc.nameDetail = _headerView.nameDetailL.text;
            dcFillVc.productId = _productId;
            dcFillVc.goodImageViewStr = _goodImageViewStr;
            
        }else if (c==500) {//没有设置默认地址",
           
            DCFillinOrderViewController *dcFillVc = [[DCFillinOrderViewController alloc] init];
            dcFillVc.userDefault = NO;
            
            [self.navigationController pushViewController:dcFillVc animated:YES];
            if (_headerView.priceL.text.length>1) {
                
                dcFillVc.price = [_headerView.priceL.text substringFromIndex:1];
            }else{
                dcFillVc.price = _headerView.priceL.text;
            }
            
            dcFillVc.name = _headerView.nameL.text;
            dcFillVc.nameDetail = _headerView.nameDetailL.text;
            dcFillVc.productId = _productId;
            dcFillVc.goodImageViewStr = _goodImageViewStr;

            
        }else{
            DCFillinOrderViewController *dcFillVc = [[DCFillinOrderViewController alloc] init];
            dcFillVc.userDefault = NO;
            
            [self.navigationController pushViewController:dcFillVc animated:YES];
            
            
            if (_headerView.priceL.text.length>1) {
                
                dcFillVc.price = [_headerView.priceL.text substringFromIndex:1];
            }else{
                dcFillVc.price = _headerView.priceL.text;
            }

            
            //dcFillVc.price = _headerView.priceL.text;
            dcFillVc.name = _headerView.nameL.text;
            dcFillVc.nameDetail = _headerView.nameDetailL.text;
            dcFillVc.productId = _productId;
            dcFillVc.goodImageViewStr = _goodImageViewStr;
            
            
           //  [MBProgressHUD showNotPhotoError:dic[@"msg"] toView:superView];
        }
        
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD showError:@"网络不给力" toView:superView];
    }];

    
    
    
    
    
    
    
    
    
    
    
    
    
//    
//    [networking AFNRequest: [NSString stringWithFormat:@"%@/%@",SELECTADDRESSDEFAULT,uid] withparameters:nil success:^(NSMutableDictionary *dic) {
//        
//        
//        
//    } error:^(NSError *error) {
//         [MBProgressHUD showNotPhotoError:@"稍后重试" toView:self.view];
//    } HUDAddView:self.view];
//
    
    
   

    
}
-(void)skuViewTap{
    
    DCFeatureSelectionViewController *dcFeaVc = [DCFeatureSelectionViewController new];
    dcFeaVc.lastNum = lastNum_;
    dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
    
    dcFeaVc.featureAttr = [NSMutableArray arrayWithArray:_spsxDataArr];
    
    dcFeaVc.goodImageView = _goodImageViewStr;
    
    dcFeaVc.goodPriceStr = _headerView.priceL.text;
    
    dcFeaVc.goodTitieStr = _headerView.nameL.text;
    
    [self setUpAlterViewControllerWith:dcFeaVc WithDistance:BOUND_HIGHT * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    
    //_headerView.skuL.text = @"fjaljfd";
}
-(void)viewWillAppear:(BOOL)animated{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _spsxDataArr = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor =BGColor;
    
    [UIApplication sharedApplication].keyWindow.backgroundColor = BGColor;
    
    
    
    UIView* bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    //            subView.layer.borderWidth = 1;
    //            subView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    CGFloat subViewH2 = BOUND_WIDTH/320.0*38;
    CGFloat subBtnW2 = BOUND_WIDTH/2;
    
    UIButton *kefuBtn = [UIButton buttonWithType:UIButtonTypeCustom];//客服
    kefuBtn.frame = CGRectMake(0, 0, subBtnW2, subViewH2);
    [kefuBtn setBackgroundImage:[UIImage imageNamed:@"jpinKF"] forState:UIControlStateNormal];//UIControlStateHighlighted
    [kefuBtn setBackgroundImage:[UIImage imageNamed:@"jpinKF"] forState:UIControlStateHighlighted];
    kefuBtn.titleLabel.numberOfLines = 0;
    kefuBtn.titleLabel.adjustsFontSizeToFitWidth = YES;

    [kefuBtn addTarget:self action:@selector(kefuAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:kefuBtn];
    
    
    UIButton *maiBtn = [UIButton buttonWithType:UIButtonTypeCustom];//立即购买
    maiBtn.frame = CGRectMake(subBtnW2, 0, subBtnW2, subViewH2);
    [maiBtn addTarget:self action:@selector(maiAction) forControlEvents:UIControlEventTouchUpInside];
    [maiBtn setBackgroundImage:[UIImage imageNamed:@"JpoijMaoi"] forState:UIControlStateNormal];
    [maiBtn setBackgroundImage:[UIImage imageNamed:@"JpoijMaoi"] forState:UIControlStateHighlighted];
    [bottomView addSubview:maiBtn];
    
    bottomView.frame = CGRectMake(0, BOUND_HIGHT-subViewH2, BOUND_WIDTH, subViewH2);
    
    
    
    
     [self.view addSubview:[self tableView]];
    [self.view addSubview:bottomView];
    
    //初始化
    lastSeleArray_ = [NSArray array];
    lastNum_ = 0;
    [self acceptanceNote];

  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leaveTop:) name:@"leaveTop" object:nil];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    
    
    _headerView = [[UsedGDheadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.917875+12)];
    //_headerView.pID = _productId;
     self.tableView.tableHeaderView =_headerView;
   
    
    
    
    //头部scrollView--------------------------------------------------------------
    // NSArray *_headPhotosUrl = @[@"",@"",@"",@""];
    
    CGFloat headImageH = self.view.frame.size.width*0.496;
    UIView *priceAreaView = [[UIView alloc] init];
    priceAreaView.backgroundColor = [UIColor whiteColor];
    priceAreaView.frame = CGRectMake(0, headImageH+1, self.view.frame.size.width, self.view.frame.size.width/320.0*97);
    [_headerView addSubview:priceAreaView];
    
    //_productId
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/ById",GETEXCELLENT,_productId] withparameters:nil success:^(NSMutableDictionary *dic) {//1508813957065-77dc768d-7d2b-47ba-8c53-a6c00fb0f128
       // NSLog(@"UsedGoodsDetailVC-dic--:%@",dic);
        
        NSDictionary *pDetailsDic = dic[@"lianjiuData"];
        NSString *str = pDetailsDic[@"excellentMasterPicture"];
        
        if ([pDetailsDic[@"excellentAttributePicture"] isKindOfClass:[NSString class]]) {
        
            _goodImageViewStr = [pDetailsDic[@"excellentAttributePicture"] excisionForFistString];
        }
        
        NSString *spxqStr = pDetailsDic[@"excellentParamData"];
        NSData *nsData=[spxqStr dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *spsxArr =[NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *childrenArr =[spsxArr[0] objectForKey:@"children"];
      
        // [_mutStrID appendString:becomeArr[6]];
        NSMutableString *mutString = [[NSMutableString alloc] init];
         NSMutableString *mutString2 = [[NSMutableString alloc] init];
        
        
        for (int i =0; i<3; i++) {
            if (childrenArr.count>2) {
                 NSDictionary *temp = childrenArr[i];
                [mutString appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"retrieveType"]]];
                [mutString2 appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"major"]]];
            }
        }
        [_spsxDataArr addObjectsFromArray:childrenArr];
        
//        for (NSDictionary *temp in childrenArr) {
//        // _spsxDataArr addObject:[temp objectForKey:@"retrieveType"];
//            
//        }
       
        
       // NSLog(@"spsxArr商品属性:%@    count:%zd   childrenArrcount:%zd    mutString%@    mutString2%@   _spsxDataArr%@"    ,spsxArr,spsxArr.count,childrenArr.count,mutString,mutString2,_spsxDataArr);
        
        UIScrollView *headSCView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headImageH)];
        headSCView.delegate = self;
        headSCView.backgroundColor = [UIColor whiteColor];
        headSCView.tag = 199999;
        for (int i = 0; i<1; i++) {
            UIImageView *headImag = [[UIImageView alloc] initWithFrame:CGRectMake(i*(self.view.frame.size.width), 0, self.view.frame.size.width, headImageH)];
            //            NSString *urlStr = [@"" stringByAppendingString:_headPhotosUrl[i]?_headPhotosUrl[i]:@""];
            //            urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            [headImag sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"jinpinshang"] options:  SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            [headSCView addSubview:headImag];
            headImag = nil;
        }
        headSCView.showsHorizontalScrollIndicator = NO;
        headSCView.pagingEnabled = YES;
        headSCView.contentSize = CGSizeMake(1*(self.view.frame.size.width), headImageH);
        [_headerView addSubview:headSCView];
        headSCView = nil;
        
        
        
        
        CGFloat pageItemW = 15;
        UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.frame.size.width-pageItemW*1)/2, headImageH-25, pageItemW*1, 10)];
        page.tag = 44;
        page.numberOfPages = 1;
        page.currentPageIndicatorTintColor = MAINColor;
        //[_headerView addSubview:page];
        page = nil;
        
        
        
        
        
        
        
        
        
        
        
        _headerView.nameL = [[UILabel alloc] initWithFrame:CGRectMake(BOUND_WIDTH/320.0*8, BOUND_WIDTH/320.0*8, BOUND_WIDTH/320.0*260, BOUND_WIDTH/320.0*21)];
        _headerView.nameL.text = pDetailsDic[@"excellentName"];
        _headerView.nameL.font = PFR15Font;
        [priceAreaView addSubview:_headerView.nameL];
        
        _headerView.nameDetailL = [[UILabel alloc] initWithFrame:CGRectMake(BOUND_WIDTH/320.0*8, BOUND_WIDTH/320.0*36, BOUND_WIDTH/320.0*304, BOUND_WIDTH/320.0*21)];
        _headerView.nameDetailL.text = mutString;
        
        _headerView.nameDetailL.numberOfLines = 0;
        _headerView.nameDetailL.adjustsFontSizeToFitWidth = YES;
        
        _headerView.nameDetailL.textColor = [UIColor darkGrayColor];
        _headerView.nameDetailL.font = PFR15Font;
        [priceAreaView addSubview:_headerView.nameDetailL];
        
        
        // [NSString stringWithFormat:@"¥%@",pDetailsDic[@"excellentPrice"]];
        
        
        _headerView.priceL = [[UILabel alloc] initWithFrame:CGRectMake(BOUND_WIDTH/320.0*8, BOUND_WIDTH/320.0*65, BOUND_WIDTH/320.0*147, BOUND_WIDTH/320.0*21)];
        _headerView.priceL.text = [NSString stringWithFormat:@"¥%@",pDetailsDic[@"excellentPrice"]];//excellentPrice
        _headerView.priceL.textColor = MAINColor;
        _headerView.priceL.font = PFR15Font;
        [priceAreaView addSubview:_headerView.priceL];
        
        
        // [NSString stringWithFormat:@"已经出售%zd台",lianjiuData[@"soldCount"]]
        _headerView.sellL = [[UILabel alloc] initWithFrame:CGRectMake(BOUND_WIDTH/320.0*170, BOUND_WIDTH/320.0*65, BOUND_WIDTH/320.0*142, BOUND_WIDTH/320.0*21)];
        
        NSNumber *soldCount = pDetailsDic[@"soldCount"];
        
        _headerView.sellL.text = [NSString stringWithFormat:@"已出售%@台",soldCount];
        _headerView.sellL.textAlignment = NSTextAlignmentRight;
        _headerView.sellL.textColor = [UIColor darkGrayColor];
        _headerView.sellL.font = PFR15Font;
        [priceAreaView addSubview:_headerView.sellL];
        
        
        
        _headerView.skuView = [[UIView alloc] init];
        _headerView.skuView.backgroundColor = [UIColor whiteColor];
        _headerView.skuView.frame = CGRectMake(0, BOUND_WIDTH/320.0*97+headImageH+6, BOUND_WIDTH, BOUND_WIDTH/320.0*38);
        [_headerView addSubview:_headerView.skuView];
        
        _headerView.skuL = [[UILabel alloc] initWithFrame:CGRectMake(BOUND_WIDTH/320.0*8, BOUND_WIDTH/320.0*0, BOUND_WIDTH/320.0*260, BOUND_WIDTH/320.0*38)];
        _headerView.skuL.text = mutString2;
        _headerView.skuL.numberOfLines = 0;
        _headerView.skuL.adjustsFontSizeToFitWidth = YES;
        _headerView.skuL.font = PFR15Font;
        [_headerView.skuView addSubview:_headerView.skuL];
        
        
        UIImageView *jianIV = [[UIImageView alloc] initWithFrame:CGRectMake(BOUND_WIDTH/320.0*301, BOUND_WIDTH/320.0*6, BOUND_WIDTH/320.0*11, BOUND_WIDTH/320.0*26)];
        jianIV.image = [UIImage imageNamed:@"con_btn_open.png"];
        [_headerView.skuView addSubview:jianIV];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skuViewTap)];
        [_headerView.skuView addGestureRecognizer:tap];
        
        
        
    } error:nil HUDAddView:nil];
    
   // [self acceptanceNote];
    
   
}


#pragma mark - 接受通知
- (void)acceptanceNote
{
    
    NSLog(@"接受通知===");
    
    //选择Item通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"itemSelectBack" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSArray *selectArray = note.userInfo[@"Array"];
        NSString *num = note.userInfo[@"Num"];
        NSString *buttonTag = note.userInfo[@"Tag"];
        
        
        
        lastNum_ = num;
        lastSeleArray_ = selectArray;
        
       // [weakSelf.collectionView reloadData];
        
        if ([buttonTag isEqualToString:@"8888"]) { //加入购物车
            
            
            // 提示：不要将webView添加到self.view，如果添加会遮挡原有的视图
            // 懒加载
//            if (_webView == nil) {
//                _webView = [[UIWebView alloc] init];
//            }
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://4001818209"]];
//            NSURLRequest *request = [NSURLRequest requestWithURL:url];
//            [_webView loadRequest:request];
            NSLog(@"执行了kefuAction=======");
            
            [self kefuAction];
          
            
        }else if ([buttonTag isEqualToString:@"8889"]) { //立即购买
            
            NSLog(@"执行了maiAction=======");
            [self maiAction];
            
//            DCFillinOrderViewController *dcFillVc = [DCFillinOrderViewController new];
//            [weakSelf.navigationController pushViewController:dcFillVc animated:YES];
        }
        
    }];
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
    
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y-64.f;
   
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    NSLog(@"tabOffsetY:%f   offsetY: %f",tabOffsetY,offsetY);
    
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    
    if (offsetY +3>= tabOffsetY) {
        
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
        _tableView = [[MainTouchTableTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-BOUND_WIDTH/320.0*38) style:UITableViewStylePlain];
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
    [cell.contentView addSubview:self.segmentView];
    return cell;
}

- (UIView *)segmentView
{
   // if(!_segmentView){
        
        ProdctCanShu *canshuVC = [[ProdctCanShu alloc] init];
        canshuVC.pid  =_productId;
        
        
        
        ProdctPingJia *pingjiaVC = [[ProdctPingJia alloc] init];
        pingjiaVC.pid  =_productId;
        [pingjiaVC requestData:pingjiaVC.pid];
        
        
        SHFW *sVC = [[SHFW alloc] init];
        
        NSArray *controllerArray = @[canshuVC, pingjiaVC, sVC];
        NSArray *titleArray = @[@"产品参数" , @"产品评价",@"售后服务"];
        
        CGFloat lineWidth = [@"产品参数" boundingRectWithSize:CGSizeMake(100, 21) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size.width;
        
        MYSegmentView *tempView = [[MYSegmentView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-64-BOUND_WIDTH/320.0*38) controllers:controllerArray titleArray:titleArray ParentController:self lineWidth:lineWidth lineHeight:3.];
        _segmentView = tempView;
   // }
    return _segmentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}
#pragma 退出界面
- (void)selfAlterViewback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObj];
}

@end
