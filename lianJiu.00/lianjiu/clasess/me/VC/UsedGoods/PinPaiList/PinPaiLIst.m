//
//
//  zaiShang
//
//  Created by cnmobi on 17/5/24.
//  Copyright © 2017年 . All rights reserved.
//

#import "PinPaiLIst.h"
#import "PinPaiTableViewCell.h"
//#import "ExhibitionViewController.h"
//#import "NewsViewController.h"
//#import "CommentViewController.h"

#import "MJRefresh.h"
@interface PinPaiLIst ()<UITableViewDataSource,UITableViewDelegate,SLSlideMenuProtocol>

@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSMutableArray *sxDataArr;
@property (nonatomic, strong) NSMutableArray *sxDataArr2;



/**
 duo选择数组
 */
@property (nonatomic,strong)NSMutableArray *duoSelectIdArr;
@property (nonatomic,strong)NSMutableArray *duoSelectNameArr;
/**
 duo选择
 */
//@property (nonatomic,strong)NSString *duoSelectStr;
//@property (nonatomic,strong)NSString *duoSelectStrName;

/**
 dan选择
 */
@property (nonatomic,strong)NSMutableArray *danSelectIdArr;
@property (nonatomic,strong)NSMutableArray *danSelectNameArr;



//@property (nonatomic,strong)NSString *chuanSelectStr;
//@property (nonatomic,strong)NSString *chuanSelectStrName;




@property (nonatomic,strong) UIButton *selectedBtn;



@end

@implementation PinPaiLIst{
    
    SLSlideMenu *menu;
}
-(NSMutableDictionary *)parameters1
{
    if (!_parameters1) {
        _parameters1 = [[NSMutableDictionary alloc] initWithDictionary:@{@"pageNum":@1,@"pageSize":@"10",@"brand":_mingcheng?_mingcheng:@"",@"orderBy":@"1"}];//价格==低到高
    }
    return _parameters1;
}
-(NSMutableDictionary *)parameters2
{
    if (!_parameters2) {
        _parameters2 = [[NSMutableDictionary alloc] initWithDictionary:@{@"pageNum":@1,@"pageSize":@"10",@"brand":_mingcheng?_mingcheng:@"",@"orderBy":@"4"}];//销量===高-低
    }
    return _parameters2;
}
-(NSMutableDictionary *)parameters3
{
    if (!_parameters3) {
        _parameters3 = [[NSMutableDictionary alloc] initWithDictionary:@{@"pageNum":@1,@"pageSize":@"10",@"brands":@"",@"categoryIds":@"",@"orderBy":@"1"}];
    }
    return _parameters3;
}


//-(void)backBtnAction{
//    [self.navigationController popViewControllerAnimated:YES];  [SLSlideMenu dismiss];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 80, 50);
//    [btn setTitle:@"< 返回" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
    
   _danSelectIdArr = [[NSMutableArray alloc] init];
    _danSelectNameArr = [[NSMutableArray alloc] init];
    
    
    _duoSelectIdArr = [[NSMutableArray alloc] init];
    _duoSelectNameArr = [[NSMutableArray alloc] init];
    
    self.title = _mingcheng?_mingcheng:@"";
    
    _sxDataArr = [[NSMutableArray alloc] init];
    _sxDataArr2 = [[NSMutableArray alloc] init];
    
    
    NSDictionary *dic = @{@"key":@"test"};
    _dic = dic;
//    [SLSlideMenu prepareSlideMenuWithFrame:self.view.frame
//                                  delegate:self
//                                 direction:SLSlideMenuSwipeDirectionLeft
//                               slideOffset:300
//                   allowSlideMenuSwipeShow:YES
//                       allowSwipeCloseMenu:YES
//                                  aboveNav:YES
//                                identifier:@"swipeLeft"
//                                    object:_dic];
//    [SLSlideMenu prepareSlideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuSwipeDirectionRight slideOffset:300 allowSlideMenuSwipeShow:YES allowSwipeCloseMenu:YES aboveNav:YES identifier:@"swipeRight" object:_dic];

    

    
    
    
    
    
    
    
    
    
    self.TenderVo = [[NSMutableArray alloc] init];
    self.PurchaseVo = [[NSMutableArray alloc] init];
    self.SupplyVo = [[NSMutableArray alloc] init];
    _dataSouc = self.TenderVo;
    //[self  requestData];
    [self requestDataNew:NO];
//    [self requestDataComment:YES];
//    [self requestDataExhibi:YES];
    CGFloat segementedH = 44;
   NSArray* arr = @[@"价格",@"销量",@"筛选"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, segementedH)];
    view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*BOUND_WIDTH/arr.count, 0, BOUND_WIDTH/arr.count, segementedH)];
        [btn addTarget:self action:@selector(chooseClass:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        [btn setTitleColor:MAINColor forState:UIControlStateSelected];
        [btn setTitle:arr[i] forState:UIControlStateSelected];
        btn.tag = 400+i;//靠tag区分是哪个数据源
        [view addSubview:btn];
        if (i==0) {
            btn.selected =YES;
            self.currBtn = btn;
        }
//        if (i!=arr.count-1) {
//            UIView *gapView = [[UIView alloc] initWithFrame:CGRectMake((i+1)*BOUND_WIDTH/arr.count, 8, 1, segementedH-8*2)];
//            gapView.backgroundColor = [UIColor lightGrayColor];
//            [view addSubview:gapView];
//        }
    }
    UIView *gapView = [[UIView alloc] initWithFrame:CGRectMake(0, segementedH-0.8, BOUND_WIDTH, 0.8)];
    gapView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:gapView];
    [self.view addSubview:view];
    
    [self addMyTableView];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [SLSlideMenu dismiss];
}

-(void)addMyTableView{
    CGFloat segementedH = 44;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segementedH+64, BOUND_WIDTH, BOUND_HIGHT-segementedH-64)];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"PinPaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"PinPaiTableViewCell"];
    self.tableView.backgroundColor = BGColor;
    [self.view addSubview:self.tableView];
    __weak UITableView *tableView = self.tableView;
    WS(weakSelf);
    //下拉刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉self.currBtn.tag:%zd",self.currBtn.tag);
        if (self.currBtn.tag==400) {
            
            [weakSelf requestDataNew:YES];
        }else if (self.currBtn.tag==401) {
           
            [weakSelf requestDataComment:YES];
        }else if (self.currBtn.tag==402) {
            
           // [weakSelf requestDataExhibi:YES];
        }
       
        // 结束刷新
        [tableView.header endRefreshing];
    }];
    [tableView.header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
         NSLog(@"上拉刷新self.currBtn.tag:%zd",self.currBtn.tag);
        if (self.currBtn.tag==400) {
            
           
            [weakSelf requestDataNew:NO];
        }else if (self.currBtn.tag==401) {
            
            [weakSelf requestDataComment:NO];
        }else if (self.currBtn.tag==402) {
            
            
            //[weakSelf requestDataExhibi:NO];
        }

        // 结束刷新
        [tableView.footer endRefreshing];
    }];
}

//申请数据
-(void)requestDataNew:(BOOL)isDown{
    //行业新闻
    NSMutableDictionary *parameters = [self.parameters1 mutableCopy];
    if (isDown) {
        [parameters setObject:@1 forKey:@"pageNum"];
    }

    [networking AFNPOST:GETPRODUCTBYBRAND withparameters:parameters success:^(NSMutableDictionary *dic) {
        
        NSLog(@"dic:%@",dic);
        
        if (isDown) {
           [self.TenderVo removeAllObjects];
        }

        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            for (NSDictionary *temp in response) {
                XiaoLiangModel *model = [XiaoLiangModel ModelWith:temp];
                [self.TenderVo addObject:model];
            }
            if (isDown) {
                [self.parameters1 setObject:@2 forKey:@"pageNum"];
            }else{
                NSInteger pageNum = [self.parameters1[@"pageNum"] integerValue];
                pageNum ++;
                [self.parameters1 setObject:[NSNumber numberWithInteger:pageNum] forKey:@"pageNum"];
            }
           
            
        }
        
        [_tableView reloadData];
    } error:nil HUDAddView:self.view];

    
    
}
-(void)requestDataComment:(BOOL)isDown{
    
    NSMutableDictionary *parameters = [self.parameters2 mutableCopy];
    if (isDown) {
        [parameters setObject:@1 forKey:@"pageNum"];
    }

    //分析评论
    [networking AFNPOST:GETPRODUCTBYBRAND withparameters:parameters success:^(NSMutableDictionary *dic) {
        if (isDown) {
            [self.SupplyVo removeAllObjects];
        }

        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            for (NSDictionary *temp in response) {
                XiaoLiangModel *model = [XiaoLiangModel ModelWith:temp];
                [self.SupplyVo addObject:model];
            }
           
            if (isDown) {
                [self.parameters2 setObject:@2 forKey:@"pageNum"];
            }else{
                NSInteger pageNum = [self.parameters2[@"pageNum"] integerValue];
                pageNum ++;
                [self.parameters2 setObject:[NSNumber numberWithInteger:pageNum] forKey:@"pageNum"];
            }
        }
        [_tableView reloadData];
    } error:nil HUDAddView:self.view];
}
-(void)requestDataExhibi:(BOOL)isDown{
    NSMutableDictionary *parameters = [self.parameters3 mutableCopy];
    if (isDown) {
        [parameters setObject:@1 forKey:@"pageNum"];
    }

    NSLog(@"parametersparameters:%@",parameters);
    //会展中心
    [networking AFNPOST:LJFILTERS withparameters:parameters success:^(NSMutableDictionary *dic) {
        if (isDown) {
            [self.PurchaseVo removeAllObjects];
        }

        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            for (NSDictionary *temp in response) {
                XiaoLiangModel *model = [XiaoLiangModel ModelWith:temp];
                [self.PurchaseVo addObject:model];
            }
         
            if (isDown) {
                [self.parameters3 setObject:@2 forKey:@"pageNum"];
            }else{
                NSInteger pageNum = [self.parameters3[@"pageNum"] integerValue];
                pageNum ++;
                [self.parameters3 setObject:[NSNumber numberWithInteger:pageNum] forKey:@"pageNum"];
            }
        }
        [_tableView reloadData];
    } error:nil HUDAddView:self.view];
}

- (void)chooseClass:(UIButton *)btn
{
//    if (self.currBtn==btn) {
//        return;
//    }
    
    self.currBtn = btn;
    for (UIView *view in btn.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.selected = NO;
        }
    }
    
   
    
    btn.selected = YES;
    if (btn.tag==400) {
        
        // [self addMyTableView];
        
        
        [self requestDataNew:YES];
        _dataSouc = self.TenderVo;
        
         [self.tableView reloadData];
    }else if(btn.tag==401){
        
        // [self addMyTableView];
       
         [self requestDataComment:YES];
       // [self addMyTableView];
        _dataSouc = self.SupplyVo;
        
         [self.tableView reloadData];
        
    }else{
#pragma mark---侧滑侧滑侧滑
        NSLog(@"rightClick");
        
//        [SLSlideMenu slideMenuWithFrame:CGRectMake(0, 64, screenW, screenH) delegate:self direction:SLSlideMenuDirectionRight slideOffset:250 allowSwipeCloseMenu:YES aboveNav:NO identifier:@"right" object:_dic];
        
        
      //  CGRectMake(0, 64, screenW, screenH)  YES  right
        menu = [[SLSlideMenu alloc] initWithFrame:CGRectMake(0, 64, screenW, screenH) delegate:self direction:SLSlideMenuDirectionRight slideOffset:250 allowSwipeCloseMenu:YES aboveNav:NO identifier:@"right" object:_dic];
        [self.view addSubview:menu];

        
        
        
        
    }
  
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouc.count*2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
            cell.contentView.backgroundColor = BGColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else {
        PinPaiTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"PinPaiTableViewCell"];
        [cell fillCellWithModel:_dataSouc[indexPath.row/2]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        return 0;
    }else {
        return 111;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiaoLiangModel *model = _dataSouc[indexPath.row/2];
    UsedGoodsDetailVC *uv = [[UsedGoodsDetailVC alloc] init];
    uv.productId = model.excellentId;
    uv.title = model.excellentName;
    [self.navigationController pushViewController:uv animated:YES];

    
    if (self.currBtn.tag==400) {
//        NewsViewController *bidContenVC = [[NewsViewController alloc] init];
//        bidContenVC.navigationItem.title = CustomLocalizedString(@"行业新闻", nil);
//        bidContenVC.hidesBottomBarWhenPushed = YES;
//        bidContenVC.model = _dataSouc[indexPath.row/2];
//        [self.navigationController pushViewController:bidContenVC animated:YES];
        
    }else if(self.currBtn.tag==401){
//        CommentViewController *bidContenVC = [[CommentViewController alloc] init];
//        bidContenVC.model = _dataSouc[indexPath.row/2];
//        bidContenVC.hidesBottomBarWhenPushed = YES;
//        bidContenVC.navigationItem.title = CustomLocalizedString(@"分析评论", nil);
//
//        [self.navigationController pushViewController:bidContenVC animated:YES];
    }else{
//        ExhibitionViewController *bidContenVC = [[ExhibitionViewController alloc] init];
//        bidContenVC.navigationItem.title = CustomLocalizedString(@"会展中心", nil);
//        bidContenVC.hidesBottomBarWhenPushed = YES;
//        bidContenVC.model = _dataSouc[indexPath.row/2];
//        [self.navigationController pushViewController:bidContenVC animated:YES];
    }
}

#pragma mark-侧滑的协议方法
- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView {
    NSLog(@"identifier:%@",slideMenu.identifier);
    //    // 可以通过 slideMenu.object 获取传进来的参数
    //    NSLog(@"object: %@",slideMenu.object);
    // ** 如果一个方向只有一个弹窗可根据direction区分
    if (slideMenu.direction == SLSlideMenuDirectionRight) {
        
        [networking AFNRequest:CATEGORYFILTER withparameters:nil success:^(NSMutableDictionary *dic) {
            
            [_sxDataArr removeAllObjects];
            NSArray *lianjiuData = dic[@"lianjiuData"];
            for (NSDictionary *temp in lianjiuData) {
                
                [_sxDataArr addObject:temp];
            }
            
            float width = 10;//空格宽
            float faceWith = 65;//宽
            float faceH = 30;//高
            
            UILabel *chanpinL = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
            chanpinL.text = @"产品";chanpinL.textColor = [UIColor lightGrayColor];
            chanpinL.font = [UIFont systemFontOfSize:13];
            [menu.menuView addSubview:chanpinL];
            
            for (int i = 0;	i<_sxDataArr.count; i++){
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(width+i%3*(width+faceWith),   30.00+i/3*(width+faceH) ,faceWith,faceH);
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = 10+i;
              //  button.layer.cornerRadius = 3;
               // button.layer.borderWidth = 1;
                button.titleLabel.font = [UIFont systemFontOfSize:12];
                //button.layer.borderColor = MAINColor.CGColor;
//                if (i==0) {
//                    button.selected =YES;
//                    NSString *cId; NSString *categoryName;
//                    if (_sxDataArr.count>0) {
//                        cId = [_sxDataArr[0] objectForKey:@"categoryId"];
//                        categoryName = [_sxDataArr[0] objectForKey:@"categoryName"];
//                        [self.danSelectIdArr addObject:cId];
//                        [self.danSelectNameArr addObject:categoryName];
//                        [self requestNextViewWithID:cId AndName:categoryName];
//                    }
//                    //categoryName;
//                    NSLog(@"BRANDFILTER:%@  cid %@",BRANDFILTER,cId);
//                }
                
                [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [button setTitleColor:MAINColor forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"Yuanrect1"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"Yuanrect"] forState:UIControlStateSelected];
                [button setTitle:[_sxDataArr[i] objectForKey:@"categoryName"] forState:UIControlStateNormal];
                [menu.menuView addSubview:button];
            }
            
            CGFloat sLeftImageLeftGap = 10 ;
            UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, BOUND_HIGHT-40-64- 40, 210, 30)];//30
            UIImage *image = [UIImage imageNamed:@"select_kuang"];//select_kuang
            [searchBtn setImage:image forState:UIControlStateNormal];
            searchBtn.layer.borderWidth = 1;
            searchBtn.layer.cornerRadius = 5;
            searchBtn.layer.borderColor = BGColor.CGColor;
            UIImageView *sLeftImage = [[UIImageView alloc] initWithFrame:CGRectMake(sLeftImageLeftGap, 6, 18, 18)];
            sLeftImage.contentMode = UIViewContentModeScaleAspectFit;
            sLeftImage.image = [UIImage imageNamed:@"frone_fangdajing"];
            [searchBtn addSubview:sLeftImage];
            
            UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(sLeftImageLeftGap+25, 6, 130, 18)];//130
            searchLabel.font = PFR15Font;
            searchLabel.textColor = [UIColor grayColor];
            searchLabel.text = @"搜索你需要的内容";
            [searchBtn addSubview:searchLabel];
             [menu.menuView addSubview:searchBtn];
            [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            sureBtn.frame = CGRectMake(0, BOUND_HIGHT-40-64, 250, 40);
            [sureBtn setTitle:@"确定选择" forState:UIControlStateNormal];
            [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sureBtn setBackgroundColor:MAINColor];
            [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [menu.menuView addSubview:sureBtn];

        } error:nil HUDAddView:self.view];
    }
}
-(void)searchAction
{
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    seachVC.queryExcellent = @"qExcellent";
    seachVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seachVC animated:YES];
}



-(void)requestNextViewWithID:(NSString *)cId AndName:(NSString *)cName{
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    [manager POST:BRANDFILTER parameters:@{@"categoryIds":cId} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dic[@"status"];
        int c = [code intValue];
        if (c==200) {
            NSLog(@"BRANDFILTER:%@  _sxDataArr.count:%ld",dic,(long)_sxDataArr.count);
            
            [_sxDataArr2 removeAllObjects];
            if (_secondView) {
                 [_secondView removeFromSuperview];
            }
            
            
            NSArray *lianjiuData = dic[@"lianjiuData"];
            for (NSDictionary *temp in lianjiuData) {
                
                [_sxDataArr2 addObject:temp];
            }
            
            
            _secondView = [[UIView alloc] init];
            [menu.menuView addSubview:_secondView];
            

            float width = 10;//空格宽
            float faceWith = 65;//宽
            float faceH = 30;//高
            
            UILabel *chanpinL = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
            chanpinL.text = @"品牌";chanpinL.textColor = [UIColor lightGrayColor];
            chanpinL.font = [UIFont systemFontOfSize:13];
            [_secondView addSubview:chanpinL];
            
            for (int i = 0;	i<_sxDataArr2.count; i++){
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(width+i%3*(width+faceWith),    30.00+i/3*(width+faceH) ,faceWith,faceH);
                button.tag = 10000+i;
                button.titleLabel.font = [UIFont systemFontOfSize:12];
               // button.layer.borderColor = MAINColor.CGColor;
                [button addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
                
                button.layer.cornerRadius=5;
                button.layer.borderColor =[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1].CGColor;
                button.layer.borderWidth=0.6;
                
                [button setBackgroundImage:[UIImage imageNamed:@"Yuanrect1"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"Yuanrect"] forState:UIControlStateSelected];

                
            
                
                [button setTitle:[_sxDataArr2[i] objectForKey:@"categoryName"] forState:UIControlStateNormal];
                [_secondView addSubview:button];
                button = nil;
            }
            //ceil(_sxDataArr2.count/3.0);
            _secondView.frame = CGRectMake(0, 30.00+(_sxDataArr.count/3+1)*(width+faceH)    , 250, (ceil(_sxDataArr2.count/3.0)+1)*40.0 );
           
           // _secondView.backgroundColor = [UIColor redColor];
            
        }else if (c==502){//产品类目下没有品牌信息-502
            [_secondView removeFromSuperview];
        }else{
            [MBProgressHUD showSuccess:dic[@"msg"] toView:superView];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD showError:@"网络不给力" toView:superView];
    }];

}

- (void)buttonAction:(UIButton *)btn{
    
    NSInteger index = btn.tag -10;
    
    btn.selected = !btn.selected;
   
    if (btn.selected) {
        NSString *cId; NSString *categoryName;
        if (_sxDataArr.count>index) {
            cId = [_sxDataArr[index] objectForKey:@"categoryId"];
            categoryName = [_sxDataArr[index] objectForKey:@"categoryName"];
            [self requestNextViewWithID:cId AndName:categoryName];
        }
        // NSLog(@"BRANDFILTER:%@  cid %@ categoryName%@",BRANDFILTER,cId,categoryName);

        
        
        
        [self.danSelectIdArr addObject:self.sxDataArr[btn.tag - 10][@"categoryId"]];
        [self.danSelectNameArr addObject:self.sxDataArr[btn.tag - 10][@"categoryName"]];
        
        btn.layer.borderColor=MAINColor.CGColor;
        [btn setTitleColor:MAINColor forState:UIControlStateNormal];
    }else {
        btn.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [self.danSelectIdArr removeObject:self.sxDataArr[btn.tag - 10][@"categoryId"]];
        [self.danSelectNameArr removeObject:self.sxDataArr[btn.tag - 10][@"categoryName"]];
        
        
        
        for (int i =0; i<_sxDataArr2.count; i++) {
            UIButton *b2 = [self.view viewWithTag:10000+i];
            [b2 removeFromSuperview];
            [self.view layoutSubviews];
        }
        
       // button.tag = 10000+i;
        
        
    }
    
    
 }


- (void)bottomAction:(UIButton*)starBtn {
    
    
    starBtn.selected = !starBtn.selected;
    
    if (starBtn.selected) {
        
        [self.duoSelectIdArr addObject:self.sxDataArr2[starBtn.tag - 10000][@"categoryId"]];
        [self.duoSelectNameArr addObject:self.sxDataArr2[starBtn.tag - 10000][@"categoryName"]];
        
        starBtn.layer.borderColor=MAINColor.CGColor;
        [starBtn setTitleColor:MAINColor forState:UIControlStateNormal];
    }else {
        starBtn.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
        [starBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [self.duoSelectIdArr removeObject:self.sxDataArr2[starBtn.tag - 10000][@"categoryId"]];
        [self.duoSelectNameArr removeObject:self.sxDataArr2[starBtn.tag - 10000][@"categoryName"]];
    }

    
}

-(void)sureBtnAction{
    
    
    NSString *cids;NSString *names;
    
    cids = [NSString stringWithFormat:@"%@,%@",[_danSelectIdArr componentsJoinedByString:@","],[_duoSelectIdArr componentsJoinedByString:@","]];
    
    
    names = [NSString stringWithFormat:@"%@,%@",[_danSelectNameArr componentsJoinedByString:@","],[_duoSelectNameArr componentsJoinedByString:@","]];

    
    
    NSLog(@"dancidscids:%@   dannamesnames:%@  duoid:%@  duonanme:%@  cids:%@ names:%@",_danSelectIdArr,_danSelectNameArr,_duoSelectIdArr,_duoSelectNameArr,cids,names);
    
    
   
    [self.parameters3 setObject:cids forKey:@"categoryIds"];
    [self.parameters3 setObject:names forKey:@"brands"];
    [self requestDataExhibi:YES];
    _dataSouc = self.PurchaseVo;
    [self.tableView reloadData];

    UIButton *b1 = [self.view viewWithTag:400];
    UIButton *b3 = [self.view viewWithTag:402];
    b1.selected = YES;b3.selected = NO;
    
    
    [_danSelectIdArr removeAllObjects];
    [_danSelectNameArr removeAllObjects];
    [_duoSelectIdArr removeAllObjects];
    [_duoSelectNameArr removeAllObjects];
    [SLSlideMenu dismiss];
   
}


@end
