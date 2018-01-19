//
//  WeiXiuFourVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WeiXiuFourVC.h"
#import "WeiXiuFourCell.h"
@interface WeiXiuFourVC ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation WeiXiuFourVC

{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
    NSMutableArray *dataHandle;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    dataHandle = [[NSMutableArray alloc] init];
    
    reuseIdentifier = @"WeiXiuFourCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    //    __weak UITableView *tableView = self.tableView;
    //    WS(weakSelf);
    //    //下拉刷新
    //    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //
    //        isDown = YES;
    //        [self requestData];
    //        // 结束刷新
    //        [tableView.header endRefreshing];
    //    }];
    //    [tableView.header beginRefreshing];
    //    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //    tableView.header.automaticallyChangeAlpha = YES;
    //
    //    // 上拉刷新
    //    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        isDown = NO;
    //        [weakSelf requestData];
    //        [tableView.footer endRefreshing];
    //    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIView *headBackView = [[UIView alloc] init];
    headBackView.backgroundColor = [UIColor whiteColor];
    headBackView.frame = CGRectMake(0, 0, BOUND_WIDTH, 75);
    _tableView.tableHeaderView = headBackView;
    
    UILabel *l = [[UILabel alloc] init];
    l.text = @"维修方案";
    l.font = PFR14Font;
    l.textAlignment = NSTextAlignmentLeft;
    l.frame = CGRectMake(10, 5, BOUND_WIDTH-18, 30);
    [headBackView addSubview:l];
    
    
    UIView *kView = [[UIView alloc] init];
    kView.backgroundColor = [UIColor whiteColor];
    kView.frame = CGRectMake(10, 35, BOUND_WIDTH-20, 40);
    kView.layer.borderColor = BGColor.CGColor;
    kView.layer.borderWidth = 1;
    kView.layer.masksToBounds = YES;
    [headBackView addSubview:kView];
    
    
    UILabel *l2 = [[UILabel alloc] init];
    l2.text = @"请选择手机问题";
    l2.font = PFR13Font;
    l2.textAlignment = NSTextAlignmentLeft;
    l2.frame = CGRectMake(0, 5, BOUND_WIDTH-18, 30);
    [kView addSubview:l2];

    UILabel *l3 = [[UILabel alloc] init];
    l3.text = @"维修人员可能会根据实际情况更改";
    l3.font = PFR13Font;
    l3.textAlignment = NSTextAlignmentLeft;
    l3.textColor = [UIColor lightGrayColor];
    l3.frame = CGRectMake(100, 5, BOUND_WIDTH-18, 30);
    [kView addSubview:l3];

    
    
    
    NSLog(@"self.clickAlljsonDataArrself.clickAlljsonDataArrself.clickAlljsonDataArr44:%@",self.clickAlljsonDataArr);
    
    
    for (NSDictionary *temp in self.clickAlljsonDataArr) {
        
        [_dataSour addObject:temp];
        
    }

    
    
    
    

}

- (void)requestData{
    
//    if (isDown) {
//        pageNo = 1;
//    }
//    [networking AFNPOSTNotHUD:@"" withparameters:@{@"vip":@"",@"pageNo":[NSNumber numberWithInteger:pageNo]} success:^(NSMutableDictionary *dic) {
//        
//        if (isDown) {
//            [_dataSour removeAllObjects];
//        }
//        
//        // NSArray *response = dic[@"response"];
//        // for (NSDictionary *temp in response) {
//        //            MyNewsModel *model = [MyNewsModel ModleWith:temp andScreeW:self.view.window.bounds.size.width];
//        //            [_dataSour addObject:model];
//        //}
//        
//        if (isDown) {
//            pageNo = 2;
//        }else{
//            pageNo++;
//        }
//        
//        [_tableView reloadData];
//        
//    } error:nil];
    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSour.count*2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row%2==0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor = BGColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
    }else{
        WeiXiuFourCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if (_dataSour.count>0) {
            
            cell.titleL.text = [_dataSour[indexPath.row/2] objectForKey:@"major"];
            cell.detailTitleL.text = [_dataSour[indexPath.row/2] objectForKey:@"majorData"];
            
            
            cell.priceL.text =  [NSString stringWithFormat:@"¥%@元",[_dataSour[indexPath.row/2] objectForKey:@"priceAlliance"]];
        }

        
        
        //    MyNewsModel *moel = _dataSour[indexPath.section];
        //    [cell fillCellWithModel:moel];
        return cell;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        
        
        return 0;
        
        
    }
    return 119;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // NSLog(@"_clickAlljsonDataArr[indexPath.row/2]:%@",[_clickAlljsonDataArr[indexPath.row/2] objectForKey:@"children"]);
    
   
    NSDictionary *tempdic =_clickAlljsonDataArr[indexPath.row/2];
    [dataHandle addObject:tempdic];
    
    
    NSData *data =  [NSJSONSerialization dataWithJSONObject:dataHandle options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"string:##%@##  颜色:%@",string,_selectColor);
    
    
    
  
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    if (uid.length == 0) {
       // [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        
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
            
            
            WeiXiuOrderViewController *dcFillVc = [[WeiXiuOrderViewController alloc] init];
            dcFillVc.userDefault = b;
            dcFillVc.address = address;
            dcFillVc.selectColor = _selectColor;
            dcFillVc.repairId = _repairId;
            dcFillVc.title = self.title;
            dcFillVc.jsonWFPriceDic = _dataSour[indexPath.row/2];
            [self.navigationController pushViewController:dcFillVc animated:YES];

            
        }else if (c==500) {//没有设置默认地址",
            
            WeiXiuOrderViewController *dcFillVc = [[WeiXiuOrderViewController alloc] init];
            dcFillVc.userDefault = NO;
           
            
            dcFillVc.selectColor = _selectColor;
            dcFillVc.repairId = _repairId;
            dcFillVc.title = self.title;
            dcFillVc.jsonWFPriceDic = _dataSour[indexPath.row/2];
            [self.navigationController pushViewController:dcFillVc animated:YES];
            
            
        }else{
            
            WeiXiuOrderViewController *dcFillVc = [[WeiXiuOrderViewController alloc] init];
            dcFillVc.userDefault = NO;
            
            
            dcFillVc.selectColor = _selectColor;
            dcFillVc.repairId = _repairId;
            dcFillVc.title = self.title;
            dcFillVc.jsonWFPriceDic = _dataSour[indexPath.row/2];
            [self.navigationController pushViewController:dcFillVc animated:YES];

            //[MBProgressHUD showNotPhotoError:dic[@"msg"] toView:superView];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD showError:@"网络不给力" toView:superView];
    }];

    
    
    
    
    
    
    
    
    
    
    
    
    
//    [networking AFNPOST: [NSString stringWithFormat:@"%@/%@",SELECTADDRESSDEFAULT,@"LJ1505729539863"] withparameters:nil success:^(NSMutableDictionary *dic) {
//        
//        NSDictionary *lianjiuData = [dic objectForKey:@"lianjiuData"];
//        NSDictionary *address = [lianjiuData objectForKey:@"address"];
//        BOOL b = (BOOL)[address objectForKey:@"userDefault"];
//        
//        
//        WeiXiuOrderViewController *dcFillVc = [[WeiXiuOrderViewController alloc] init];
//        dcFillVc.userDefault = b;
//        dcFillVc.address = address;
//        dcFillVc.selectColor = _selectColor;
//        dcFillVc.jsonString = string;
//        dcFillVc.jsonWFPriceDic = _dataSour[indexPath.row/2];
//        [self.navigationController pushViewController:dcFillVc animated:YES];
//        
//
//        
//    } error:^(NSError *error) {
//        [MBProgressHUD showNotPhotoError:@"稍后重试" toView:self.view];
//    } HUDAddView:self.view];

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
