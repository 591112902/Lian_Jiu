
#import "KuaiDiOrderTableViewCell.h"
#import "KuaiDiOrderManageTVController.h"
#import "MJRefresh.h"
#import "KuaiDiOrderModel.h"
#import "GoodsCommentVC.h"
#import "GoodsRefundVC.h"

#import "MXNextDeatailsViewController.h"

@interface KuaiDiOrderManageTVController ()

@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation KuaiDiOrderManageTVController
{
    NSInteger pageNo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestDataIsDown:) name:@"FANHUI_SHUAXIN_NOTIFICATION" object:nil];//监听一个通知

    
    self.title = @"我的订单";
   
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
    if (_isRequestData) {
        [self requestDataIsDown:YES];
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
    
    
    NSString *typeStr ;
    if(self.type == 1){
        typeStr = @"4";
    }else if(self.type == 2){
        typeStr = @"0";
    }else if(self.type == 3){
        typeStr = @"1";
    }else if(self.type == 4){
        typeStr = @"2";
    }else if(self.type == 5){
        typeStr = @"3";
    }

    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userId = [def objectForKey:@"userId"];
    
    NSLog(@"userIduserId:%@",userId);//LJ1506335592559  测试id
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/%@/%@/10",GETEXPRESSSTUTSLIST,userId,typeStr,[NSNumber numberWithInteger:pageNo]] withparameters:nil success:^(NSMutableDictionary *dic) {
         NSLog(@"GETEXPRESSSTUTSLIST---:%@",dic);
        
        if (isDown) {
            [_dataSource removeAllObjects];
        }
        
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        
        if ([lianjiuData[@"orderList"] isKindOfClass:[NSArray class]]){
            
            NSArray *response = lianjiuData[@"orderList"] ;
            
            for (NSDictionary *temp in response) {
                
                KuaiDiOrderModel *model = [KuaiDiOrderModel ModelWith:temp ];
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
    KuaiDiOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KuaiDiOrderTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KuaiDiOrderTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillCellWithModel:_dataSource[indexPath.section]];
    

    cell.firstBtn.tag = indexPath.section+46000;
    cell.firstBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.secondBtn.tag = indexPath.section+446000;
    cell.secondBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];

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
    return 177.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KuaiDiOrderModel *model = _dataSource[indexPath.section];
    MXNextDeatailsViewController *bidContenVC = [[MXNextDeatailsViewController alloc] init];
    bidContenVC.orFacefaceId = model.orExpressId;
    [self.navigationController pushViewController:bidContenVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



- (void)firstBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-46000;// 判断点击了哪个按钮
    KuaiDiOrderModel *model = self.dataSource[index];
    if ([model.orExpressStatus isEqualToNumber:@0]) {
        
        
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定取消吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [networking AFNPOST:MODIFYEXPRESSORDERSTATUS withparameters:@{@"ordersId":model.orExpressId} success:^(NSMutableDictionary *dic) {
                
                [MBProgressHUD showNotPhotoError:@"取消成功" toView:self.view];
                
                [self requestDataIsDown:YES];
                
            } error:nil HUDAddView:self.view];

        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        
    }else if([model.orExpressStatus isEqualToNumber:@6]){//不卖了
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"退回设备须承担运费，是否要退回？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [networking AFNPOST:BMLPRICEREFUSE withparameters:@{@"ordersId":model.orExpressId} success:^(NSMutableDictionary *dic) {
                
                [MBProgressHUD showNotPhotoError:@"确认成功" toView:self.view.window];
                
                [self requestDataIsDown:YES];
                //[self.navigationController popViewControllerAnimated:YES];
                
                
            } error:nil HUDAddView:self.view];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];
        
        
        
    }else if([model.orExpressStatus isEqualToNumber:@0]){
        
    }else if([model.orExpressStatus isEqualToNumber:@0]){
        
    }else if([model.orExpressStatus isEqualToNumber:@0]){
        
    }
}
- (void)secondBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-446000;// 判断点击了哪个按钮
    KuaiDiOrderModel *model = self.dataSource[index];
    if ([model.orExpressStatus isEqualToNumber:@0]) {
        
        FaHuoViewController *fvc = [[FaHuoViewController alloc] init];
        
        
        fvc.isME = @"isme";
        
        fvc.ordersId = model.orExpressId;
        [self.navigationController pushViewController:fvc animated:YES];
        
    }else if([model.orExpressStatus isEqualToNumber:@2]){
       // [MBProgressHUD showNotPhotoError:@"等待付款" toView:self.view];
    }else if([model.orExpressStatus isEqualToNumber:@3]){
        
        // [MBProgressHUD showNotPhotoError:@"退货中" toView:self.view];
        
    }else if([model.orExpressStatus isEqualToNumber:@5]){
       
        //去评论
        // [MBProgressHUD showNotPhotoError:@"去评论" toView:self.view];
        QuPingLunViewController *dvc = [[QuPingLunViewController alloc] init];
        dvc.relativeId = model.orExpressId;
        dvc.recycleStyle = @"KD";
        [self.navigationController pushViewController:dvc animated:YES];

        
        
    }else if([model.orExpressStatus isEqualToNumber:@7]){
        // [MBProgressHUD showNotPhotoError:@"已经评论" toView:self.view];
        YiPingLunViewController *dvc = [[YiPingLunViewController alloc] init];
        dvc.relativeId = model.orExpressId;
        
        [self.navigationController pushViewController:dvc animated:YES];
        
    }else if([model.orExpressStatus isEqualToNumber:@6]){
        
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认该价格？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [networking AFNPOST:PRICECONFIRM withparameters:@{@"ordersId":model.orExpressId} success:^(NSMutableDictionary *dic) {
                
                
                [self requestDataIsDown:YES];
                 [MBProgressHUD showNotPhotoError:@"确认成功" toView:[UIApplication sharedApplication].keyWindow];
                
                
               // [self.navigationController popViewControllerAnimated:YES];
                
                
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
