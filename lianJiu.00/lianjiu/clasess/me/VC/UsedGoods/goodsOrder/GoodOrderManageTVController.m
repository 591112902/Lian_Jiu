
#import "GoodsOrderTableViewCell.h"
#import "GoodOrderManageTVController.h"

#import "MJRefresh.h"

#import "GoodsOrderModel.h"
#import "GoodsCommentVC.h"
#import "GoodsRefundVC.h"
@interface GoodOrderManageTVController ()

@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation GoodOrderManageTVController
{
    NSInteger pageNo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestDataIsDown:) name:@"GOODORDER__NOTIFICATION" object:nil];//监听一个通知
   
    self.view.backgroundColor = BGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isRequestData = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    __weak UITableView *tableView = self.tableView;
    WS(weakSelf);
    // 下拉刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataIsDown:YES];
        // 结束刷新
        [tableView.header endRefreshing];
    }];
    //[tableView.header beginRefreshing];//自动刷新
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataIsDown:NO];
        // 结束刷新
        [tableView.footer endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.footer.automaticallyChangeAlpha = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self requestDataIsDown:YES];
    
    
    
//    if (_isRequestData) {
//        [self requestDataIsDown:YES];
//        return;
//    }else{
//        [self.tableView reloadData];
//    }

    
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
-(void)requestDataIsDown:(BOOL)isDown
{
    self.isRequestData = NO;
    if (isDown) {
        pageNo = 1;
    }
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userId = [def objectForKey:@"userId"];
    
    NSLog(@"userIduserId:%@",userId);
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/%@/%@/10/ByUserStatus",ORDERSEXCELLENT,[NSNumber numberWithInteger:self.type],userId,[NSNumber numberWithInteger:pageNo]] withparameters:nil success:^(NSMutableDictionary *dic) {
         NSLog(@"ORDERSEXCELLENT---:%@",dic);
        
        if (isDown) {
            [_dataSource removeAllObjects];
        }
        
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            
            NSArray *response = dic[@"lianjiuData"];
            for (NSDictionary *temp in response) {
                GoodsOrderModel *model = [GoodsOrderModel ModelWith:temp ];
                model.type =self.type;
                [_dataSource addObject:model];
            }

        }
       
        
        
        if (isDown) {
            pageNo = 2;
        }else{
            pageNo++;
        }
        
        [self.tableView reloadData];
    } error:nil HUDAddView:nil];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;//self.dataSource.count

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsOrderTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsOrderTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillCellWithModel:_dataSource[indexPath.section]];
    

    cell.firstBtn.tag = indexPath.section+46000;
    cell.firstBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.secondBtn.tag = indexPath.section+446000;
    cell.secondBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    cell.threeBtn.tag = indexPath.section+4446000;
    cell.threeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.threeBtn addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 203.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsOrderModel *model = _dataSource[indexPath.section];
    NSLog(@"ordersId:%@",model.ordersId);
    
    
    
    UsedGoodsDetailVC *uv = [[UsedGoodsDetailVC alloc] init];
    uv.productId = model.orItemsProductId;
    uv.title = model.orItemsNamePreview;
    [self.navigationController pushViewController:uv animated:YES];

    
//    
//    
//    if (self.isToubiao&&[model.t_bidstate_id isEqualToString:@"0"]) {
//        B_C_TViewController *bidContenVC = [[B_C_TViewController alloc] init];
//        bidContenVC.model = model;
//        [self.navigationController pushViewController:bidContenVC animated:YES];
//    }else{
//        B_C_TReadOnlyViewController *bidContenVC = [[B_C_TReadOnlyViewController alloc] init];
//        bidContenVC.model = model;
//        [self.navigationController pushViewController:bidContenVC animated:YES];
//    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



- (void)firstBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-46000;// 判断点击了哪个按钮
    GoodsOrderModel *model = self.dataSource[index];
    if ([model.ordersStatus isEqualToNumber:@3]) {
        GoodsRefundVC *gvc = [[GoodsRefundVC alloc] init];
        gvc.model = model;
        gvc.preVc = self;
        [self.navigationController pushViewController:gvc animated:YES];

     
        
    }else if(self.type==2){
        
    }else if(self.type==3){
      
    }else if(self.type==4){
        
    }else if(self.type==5){
        
    }
}
- (void)secondBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-446000;// 判断点击了哪个按钮
    GoodsOrderModel *model = self.dataSource[index];
    if ([model.ordersStatus isEqualToNumber:@3]) {
        
        //提示框
        if (model.orExceDetailsExpressNum.length==0) {
            return;
        }
       
        
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"快递单号:%@",model.orExceDetailsExpressNum] message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"不拷贝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"拷贝快递单号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:model.orExceDetailsExpressNum?model.orExceDetailsExpressNum:@""];
            if (pasteboard == nil) {
                [MBProgressHUD showNotPhotoError:@"拷贝失败" toView:self.view];
            }else{
                [MBProgressHUD showNotPhotoError:@"拷贝成功!" toView:self.view];
            }
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        
        
      //  [MBProgressHUD showNotPhotoError:@"查看物流" toView:self.view];
        
    }else if(self.type==2){
        
    }else if(self.type==3){//退款-查看物流-确认收货
        
        
        
    }else if(self.type==4){
        GoodsCommentVC *gvc = [[GoodsCommentVC alloc] init];

        [self.navigationController pushViewController:gvc animated:YES];
        
    }else if(self.type==5){
        
    }
}
- (void)threeBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-4446000;// 判断点击了哪个按钮
    GoodsOrderModel *model = self.dataSource[index];
    if ([model.ordersStatus isEqualToNumber:@1]) {
        
        PaymentViewController *pvc = [[PaymentViewController alloc] init];
        pvc.goodImageViewStr = model.orItemsPictruePreview;
        pvc.name = model.orItemsNamePreview;
        pvc.price = model.ordersPrice;
        pvc.nameDetail = model.orItemsParam;
        pvc.orderID = model.ordersId;;
        [self.navigationController pushViewController:pvc animated:YES];

        
    }else if([model.ordersStatus isEqualToNumber:@2]){//待发货-提醒发货
        
        
        [networking AFNPOST:MODIFYEXELLENTSTATE withparameters:@{@"excellentId":model.ordersId,@"orExcellentStatus":@"4"} success:^(NSMutableDictionary *dic) {
            // model.ordersId
           
            //提示框
            UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"已经为您提醒发货，请耐心等待。" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self requestDataIsDown:YES];
                [self.tableView reloadData];
                
            }];
            [clear addAction:queRen];
            [self presentViewController:clear animated:YES completion:nil];
            
            
        } error:nil HUDAddView:self.view];
        
        

    }else if([model.ordersStatus isEqualToNumber:@7]){
     
        
        //去评论
        GoodsCommentVC *gvc = [[GoodsCommentVC alloc] init];
        gvc.ordersId =  model.ordersId;
         gvc.orItemsProductId =  model.orItemsProductId;
        gvc.nameS =  model.orItemsNamePreview;
        [self.navigationController pushViewController:gvc animated:YES];

        
    }else if([model.ordersStatus isEqualToNumber:@8]){
        //  [MBProgressHUD showNotPhotoError:@"确认收货" toView:self.view];
#pragma mark---获取评论数据-显示出来--隐藏下面按钮
        //去评论======
        YiGoodsCommentVC *gvc = [[YiGoodsCommentVC alloc] init];
        gvc.ordersId =  model.ordersId;
        gvc.orItemsProductId =  model.orItemsProductId;
        gvc.nameS =  model.orItemsNamePreview;
        [self.navigationController pushViewController:gvc animated:YES];
        
        
        
    }else if([model.ordersStatus isEqualToNumber:@3]){
        //确认收货
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认收货?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [networking AFNPOST:JJPFINISH withparameters:@{@"orExcellentId":model.ordersId} success:^(NSMutableDictionary *dic) {
                // model.ordersId
                [MBProgressHUD showNotPhotoError:@"收货成功" toView:self.view];
                [self requestDataIsDown:YES];
                [self.tableView reloadData];
                
            } error:nil HUDAddView:self.view];

            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        
        
        
        
        
    }else if([model.ordersStatus isEqualToNumber:@6]){
        //跳转退货快递页面
        ReturnOrderVC *gvc = [[ReturnOrderVC alloc] init];
        gvc.model = model;
        [self.navigationController pushViewController:gvc animated:YES];

        
    }else if([model.ordersStatus isEqualToNumber:@9]){
        //退货单号lable出来
        
        
    }
}

@end
