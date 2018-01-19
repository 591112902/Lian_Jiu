
#import "DaZongOrderTableViewCell.h"
#import "DaZongOrderManageTVController.h"

#import "MJRefresh.h"


#import "DaZongOrderModel.h"

#import "GoodsCommentVC.h"
#import "GoodsRefundVC.h"
@interface DaZongOrderManageTVController ()

@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation DaZongOrderManageTVController
{
    NSInteger pageNo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestDataIsDown:) name:@"DAZONG_NOTIFICATION" object:nil];//监听一个通知
   
    self.view.backgroundColor = BGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isRequestData = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    __weak UITableView *tableView = self.tableView;
    WS(weakSelf);
    // 下拉刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataIsDown:YES];
        // 结束刷新
        [tableView.header endRefreshing];
    }];
    [tableView.header beginRefreshing];//自动刷新
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
    if (_isRequestData) {
       // [self requestDataIsDown:YES];
        return;
    }else{
        [self.tableView reloadData];
    }

    
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
    
    NSString *typeStr ;//NSString *urlStr;
    if(self.type == 1){
        typeStr = @"0";
        //urlStr = [NSString stringWithFormat:@"%@/%@/%@/10",GETHOMEVISTSTUTSLIST,userId,[NSNumber numberWithInteger:pageNo]];
    }else if(self.type == 2){
        typeStr = @"1";
    }else if(self.type == 3){
        typeStr = @"2";
    }else if(self.type == 4){
        typeStr = @"3";
    }
  
    
    
    NSLog(@"prarllr:%@",@{@"status":typeStr,@"userId":userId,@"pageNum":[NSNumber numberWithInteger:pageNo],@"pageSize":@"10",});//LJ1507707459235  测试id
    
    
    [networking AFNPOST:B_GETORDERSBYUSERSTATUS withparameters:@{@"status":typeStr,@"userId":userId,@"pageNum":[NSNumber numberWithInteger:pageNo],@"pageSize":@"10",} success:^(NSMutableDictionary *dic) {
        
        
        
        NSLog(@"dazonghuishou---:%@",dic);
        
        if (isDown) {
            [_dataSource removeAllObjects];
        }
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]){
            
            NSArray *response = dic[@"lianjiuData"];
            
            for (NSDictionary *temp in response) {
                
                DaZongOrderModel *model = [DaZongOrderModel ModelWith:temp ];
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

        
    } error:nil HUDAddView:self.view];
    
    
//    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/%@/%@/10",B_GETORDERSBYUSERSTATUS,userId,typeStr,[NSNumber numberWithInteger:pageNo]] withparameters:@{@"status":typeStr,@"userId":userId,@"pageNum":[NSNumber numberWithInteger:pageNo],@"pageSize":@"10",} success:^(NSMutableDictionary *dic) {
//            } error:nil HUDAddView:nil];
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
    DaZongOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DaZongOrderTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DaZongOrderTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillCellWithModel:_dataSource[indexPath.section]];
    

    cell.firstBtn.tag = indexPath.section+46000;
    cell.firstBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.secondBtn.tag = indexPath.section+446000;
    cell.secondBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell.left_cancelBtn.tag = indexPath.section+546000;
    cell.left_cancelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.left_cancelBtn addTarget:self action:@selector(left_cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    

//    cell.threeBtn.tag = indexPath.section+4446000;
//    cell.threeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//    [cell.threeBtn addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    return 194;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   DaZongOrderModel *model = _dataSource[indexPath.section];
    
    DZ_DetailListVC *deContenVC = [[DZ_DetailListVC alloc] init];
//    if([model.orBulkStatus isEqualToNumber:@2]||[model.orBulkStatus isEqualToNumber:@3]){
//        //交货清单
//        deContenVC.title = @"交货清单";
    //}else{
        deContenVC.title = @"货物清单";
   // }
    deContenVC.hidesBottomBarWhenPushed = YES;
    deContenVC.categoryId = model.orBulkId;
    NSLog(@"orFacefaceId:%@",model.orBulkId);
    [self.navigationController pushViewController:deContenVC animated:YES];

    
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


- (void)left_cancelBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-546000;// 判断点击了哪个按钮
    DaZongOrderModel *model = self.dataSource[index];
    
    if ([model.orBulkStatus isEqualToNumber:@2]) {//待确认===取消按钮
        
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要取消该订单？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [networking AFNPOST:B_ORDERSCANCEL withparameters:@{@"ordersId":model.orBulkId} success:^(NSMutableDictionary *dic) {
                
                [MBProgressHUD showNotPhotoError:@"取消成功" toView:self.view];
                
                [self requestDataIsDown:YES];
            } error:nil HUDAddView:self.view];
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];
        
    }

}

- (void)firstBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-46000;// 判断点击了哪个按钮
    DaZongOrderModel *model = self.dataSource[index];
    if([model.orBulkStatus isEqualToNumber:@2]||[model.orBulkStatus isEqualToNumber:@3] ||[model.orBulkStatus isEqualToNumber:@4]){
        //提示框===交货清单
        DZ_DetailListVC *deContenVC = [[DZ_DetailListVC alloc] init];
        //交货清单
        deContenVC.title = @"交货清单";
        deContenVC.hidesBottomBarWhenPushed = YES;
        deContenVC.categoryId = model.orBulkId;
        NSLog(@"orFacefaceId:%@",model.orBulkId);
        [self.navigationController pushViewController:deContenVC animated:YES];
    }
}
- (void)secondBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-446000;// 判断点击了哪个按钮
    DaZongOrderModel *model = self.dataSource[index];
    if ([model.orBulkStatus isEqualToNumber:@1]) {//取消按钮
        
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要取消该订单？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [networking AFNPOST:B_ORDERSCANCEL withparameters:@{@"ordersId":model.orBulkId} success:^(NSMutableDictionary *dic) {
                
                [MBProgressHUD showNotPhotoError:@"取消成功" toView:self.view];
                
                [self requestDataIsDown:YES];
            } error:nil HUDAddView:self.view];
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];
        
    }else if([model.orBulkStatus isEqualToNumber:@3]){
        // [MBProgressHUD showNotPhotoError:@"去评论" toView:self.view];
        QuPingLunViewController *dvc = [[QuPingLunViewController alloc] init];
        dvc.relativeId = model.orBulkId;
        dvc.recycleStyle = @"DZ";
        [self.navigationController pushViewController:dvc animated:YES];

    }else if([model.orBulkStatus isEqualToNumber:@4]){
        // [MBProgressHUD showNotPhotoError:@"已经评论" toView:self.view];
        YiPingLunViewController *dvc = [[YiPingLunViewController alloc] init];
        dvc.relativeId = model.orBulkId;
      
        [self.navigationController pushViewController:dvc animated:YES];
        
    }else if([model.orBulkStatus isEqualToNumber:@2]){
       
        //确认价格
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认价格？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [networking AFNPOST:B_ORDERSAGREE withparameters:@{@"ordersId":model.orBulkId} success:^(NSMutableDictionary *dic) {
                
                [MBProgressHUD showNotPhotoError:@"确认价格成功" toView:self.view];
                
                [self requestDataIsDown:YES];
                
            } error:nil HUDAddView:self.view];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
    }

}
//- (void)threeBtnClick:(UIButton *)btn
//{
//    NSInteger index = btn.tag-4446000;// 判断点击了哪个按钮
//    KuaiDiOrderModel *model = self.dataSource[index];
//    if (self.type==1) {
//        GoodsCommentVC *gvc = [[GoodsCommentVC alloc] init];
//        [self.navigationController pushViewController:gvc animated:YES];
//    }else if(self.type==2){
//        GoodsRefundVC *gvc = [[GoodsRefundVC alloc] init];
//        gvc.preVc = self;
//        [self.navigationController pushViewController:gvc animated:YES];
//
//    }else if(self.type==3){
//        
//    }else if(self.type==4){
//        
//    }else if(self.type==5){
//        
//    }
//}

@end
