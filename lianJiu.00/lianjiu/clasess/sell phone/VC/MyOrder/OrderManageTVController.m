//
//  BidManageContenTableViewController.m
//  zaiShang
//
//  Created by wanglinlei on 17/01/05.
//  Copyright © 2017年 CNMOBI. All rights reserved.
/**标管理的内容 TableViewController */
#import "MyOrderTableViewCell.h"
#import "OrderManageTVController.h"

#import "MJRefresh.h"



#import "MJRefresh.h"


@interface OrderManageTVController ()

@property(nonatomic,strong)NSMutableDictionary *parameters;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation OrderManageTVController
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.view.backgroundColor = BGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isRequestData = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
//    __weak UITableView *tableView = self.tableView;
//    WS(weakSelf);
//    // 下拉刷新
//    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf requestDataIsDown:YES];
//        // 结束刷新
//        [tableView.header endRefreshing];
//    }];
//    //[tableView.header beginRefreshing];//自动刷新
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    tableView.header.automaticallyChangeAlpha = YES;
//    
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
    //[self requestDataIsDown:YES];
    
}
//-(NSMutableDictionary *)parameters
//{
//    if (!_parameters) {
//        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//        self.vip = [def objectForKey:@"vip"];
//        _parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"vip":@"",@"pageNo":@1,@"type":[NSNumber numberWithInteger:self.type]}];
//    }
//    return _parameters;
//}
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
    NSMutableDictionary *para = [self.parameters mutableCopy];
    
    if (isDown) {
        [para setObject:@1 forKey:@"pageNo"];
    }
     [networking AFNPOST:self.url withparameters:para success:^(NSMutableDictionary *dic) {
        if (isDown) {
            [self.dataSource removeAllObjects];
        }
        if ([dic[@"response"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"response"];
            for (NSDictionary *temp in response) {
                if ([temp isKindOfClass:[NSDictionary class]]) {
//                    bidManageModel *model = [bidManageModel ModelWith:temp];
//                    model.type =self.type;
//                    model.state = self.state;
//                    [self.dataSource addObject:model];
                    
                }
            }
        }
        if (isDown) {
            [self.parameters setObject:@2 forKey:@"pageNo"];
        }else{
            
            NSInteger pageInt = [_parameters[@"pageNo"] integerValue];
            pageInt ++;
            [self.parameters setObject:[NSNumber numberWithInteger:pageInt] forKey:@"pageNo"];
        }
         
        [self.tableView reloadData];
        
    } error:nil HUDAddView:self.view];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 30;//self.dataSource.count

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
//    // 传递模型
//    cell.buyModel = self.dataSource[indexPath.section];
//    cell.sOrbStr = @"buy";
//    [cell fillCellWithModel4:_dataSource[indexPath.section]];//买
//    cell.bidManageBtn.tag = indexPath.section+46000;
//    cell.bidManageBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//    [cell.bidManageBtn addTarget:self action:@selector(TBrightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    cell.cancelZhaoBiaoBtn.tag = indexPath.section+99000;
//    [cell.cancelZhaoBiaoBtn addTarget:self action:@selector(buyCancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0;
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


//
//#pragma mark-卖卖卖卖卖卖
//- (void)ZBrightBtnClick:(UIButton *)btn
//{//卖卖卖卖卖卖.我卖的货
//    NSInteger tag = btn.tag+2000;
//    UIButton *cancelBtn = [self.view viewWithTag:tag];
//    NSInteger index = btn.tag-45000;
//    bidManageModel *model = self.dataSource[index];
//    if (self.type==1) {
//        //t_bidstate_id;投标状态ID(0投标中  1中标 2 招标流标 3待对方确认 4招标完成 5招标结束  )
//        
//        if (model.t_price.length>0) {
//            //还价
//            //查看还价
//            BiddingViewController *biddingCV = [[BiddingViewController alloc] initWithNibName:@"BiddingViewController" bundle:nil];
//            biddingCV.bidMangeModel = model;
//            
//            
//            
//            biddingCV.title = CustomLocalizedString(@"查看还价", nil);
//            biddingCV.isHaijia = @"ishaijia";
//            
//            // biddingCV.zbBtnTag = btn.tag;
//            [self.navigationController pushViewController:biddingCV animated:YES];
//            
//        }else{//出价管理
//            BiddingViewController *biddingCV = [[BiddingViewController alloc] initWithNibName:@"BiddingViewController" bundle:nil];
//            biddingCV.bidMangeModel = model;
//            
//            biddingCV.title = CustomLocalizedString(@"出价管理", nil);
//            // biddingCV.zbBtnTag = btn.tag;
//            [self.navigationController pushViewController:biddingCV animated:YES];
//
//        }
//    }else if(self.type==6)
//    {
//        //确认成交
//        if([model.t_surestate_id isEqualToString:@"1"]||[model.t_surestate_id isEqualToString:@""]||[model.t_surestate_id isEqualToString:@"-1"]){
//            //CustomLocalizedString(@"招标确认成交", nil)
//            UIAlertController *clear = [UIAlertController alertControllerWithTitle:CustomLocalizedString(@"提示:", nil) message:CustomLocalizedString(@"确认成交", nil) preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *quXiao = [UIAlertAction actionWithTitle:CustomLocalizedString(@"取消", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            UIAlertAction *queRen = [UIAlertAction actionWithTitle:CustomLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                WS(weakSelf);
//                [networking AFNPOST:DETERMINETHEDEAL withparameters:@{@"vip":self.vip,@"bid":model.t_id} success:^(NSMutableDictionary *dic) {
//                    [MBProgressHUD showSuccess:CustomLocalizedString(@"成交成功", nil) toView:weakSelf.view];
//                    cancelBtn.hidden = YES;
//                    [weakSelf requestDataIsDown:YES];
//                } error:nil HUDAddView:self.view];
//            }];
//            [clear addAction:quXiao];
//            [clear addAction:queRen];
//            [self presentViewController:clear animated:YES completion:nil];
//        }
//        //[self modifyBidWithModel:model index:index];
//    }else if(self.type==3)
//    {
//        [self modifyBidWithModel:model index:index];
//    }else if(self.type==4){
////        EvaluateViewController *bidContenVC = [[EvaluateViewController alloc] init];
////        bidContenVC.hidesBottomBarWhenPushed = YES;
////        [self.navigationController pushViewController:bidContenVC animated:YES];
//    }
//}

@end
