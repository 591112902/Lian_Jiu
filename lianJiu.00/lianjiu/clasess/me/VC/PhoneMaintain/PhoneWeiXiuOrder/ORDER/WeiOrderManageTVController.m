
#import "WaitDoorTableViewCell.h"
#import "WeiOrderManageTVController.h"

#import "MJRefresh.h"


#import "WeiXiuOrderModel.h"
#import "GoodsCommentVC.h"
#import "GoodsRefundVC.h"
@interface WeiOrderManageTVController ()

@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation WeiOrderManageTVController
{
    NSInteger pageNo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.view.backgroundColor = BGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isRequestData = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
     [self requestDataIsDown:YES];
    
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
    
//    // 上拉刷新
//    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf requestDataIsDown:NO];
//        // 结束刷新
//        [tableView.footer endRefreshing];
//    }];
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    tableView.footer.automaticallyChangeAlpha = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    if (_isRequestData) {
//        [self requestDataIsDown:YES];
//        return;
//    }else{
//        [self.tableView reloadData];
//    }
//
    
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
//    self.isRequestData = NO;
//    if (isDown) {
//        pageNo = 1;
//    }
    
    
    
    NSString *statusList;
    if (self.type == 1) {
        statusList = @"0";
    }else if (self.type == 2) {
        statusList = @"1";
    }else if (self.type == 3) {
        statusList = @"2,3";
    }
    NSLog(@"GETREPAIRBYSTATUSARR---:%zd   %@" ,_type,statusList);
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    
    [networking AFNPOST:GETREPAIRBYSTATUSARR withparameters:@{@"uid":uid,@"statusList":statusList} success:^(NSMutableDictionary *dic) {
         NSLog(@"GETREPAIRBYSTATUSARR---:%@",dic);
        
        if (isDown) {
            [_dataSource removeAllObjects];
        }
        
        
        
        NSArray *response = dic[@"lianjiuData"];
        for (NSDictionary *temp in response) {
            WeiXiuOrderModel *model = [WeiXiuOrderModel ModelWith:temp ];
          //  model.type =self.type;
            [_dataSource addObject:model];
        }
        
        
//        if (isDown) {
//            pageNo = 2;
//        }else{
//            pageNo++;
//        }
        
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
    WaitDoorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitDoorTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WaitDoorTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillCellWithModel:_dataSource[indexPath.section]];
    

    cell.paymentBtn.tag = indexPath.section+46000;
    cell.paymentBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.paymentBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    
//    cell.secondBtn.tag = indexPath.section+446000;
//    cell.secondBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//    [cell.secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
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
    return 187;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    bidManageModel *model = _dataSource[indexPath.section];
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
    WeiXiuOrderModel *model = self.dataSource[index];
    if ([model.orRepairStatus isEqualToNumber:@0]) {
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定取消吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [networking AFNPOST:REPAIRMODIFYSTATUS withparameters:@{@"ordersId":model.orRepairId,@"status":@"3"} success:^(NSMutableDictionary *dic) {
                
                 [MBProgressHUD showNotPhotoError:@"取消成功" toView:self.view];
                
                [self requestDataIsDown:YES];
            } error:nil HUDAddView:self.view];

            
            
            
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

        
        
        
        
    }else if(self.type==2){
        
    }else if(self.type==3){
        
    }else if(self.type==4){
        
    }else if(self.type==5){
        
    }
}
//- (void)secondBtnClick:(UIButton *)btn
//{
//    NSInteger index = btn.tag-446000;// 判断点击了哪个按钮
//    WeiXiuOrderModel *model = self.dataSource[index];
//    if (self.type==1) {
//        
//    }else if(self.type==2){
//        
//    }else if(self.type==3){
//        
//    }else if(self.type==4){
//        
//    }else if(self.type==5){
//        
//    }
//}
//- (void)threeBtnClick:(UIButton *)btn
//{
//    NSInteger index = btn.tag-4446000;// 判断点击了哪个按钮
//    WeiXiuOrderModel *model = self.dataSource[index];
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
