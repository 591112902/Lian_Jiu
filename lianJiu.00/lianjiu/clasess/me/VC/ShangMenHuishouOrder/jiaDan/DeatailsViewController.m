//
//  DeatailsViewController.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "DeatailsViewController.h"
#import "DetailsTableViewCell.h"
@interface DeatailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DeatailsViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}
-(void)jdBtnClick{//加单
    JiaDanBtnSellScrapVC *svc = [[JiaDanBtnSellScrapVC alloc] init];
  
    
    [self.navigationController pushViewController:svc animated:YES];
    
    
}
-(void)jdjsBtnClick{//加单结算
    
    if (_dataSour.count == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请先进行加单选择废品（加单列表为空）！" toView:self.view];
        return;
    }
    
    
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否进行加单？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *uid = [def objectForKey:@"userId"];
        
        [networking AFNPOST:SUBMITFACe withparameters:@{@"userId":uid?uid:@"",@"orFacefaceId":_orFacefaceId?_orFacefaceId:@""} success:^(NSMutableDictionary *dic) {
            
            
            NSNotification *notification = [NSNotification notificationWithName:@"JIADAN__NOTIFICATION" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            
            
            ShangMenOrderViewController* oneVC =nil;
            for(UIViewController* VC in self.navigationController.viewControllers){
                if([VC isKindOfClass:[ShangMenOrderViewController class]]){
                    oneVC =(ShangMenOrderViewController*) VC;
                    //
                    [self.navigationController popToViewController:oneVC animated:YES];
                    [MBProgressHUD showNotPhotoError:@"加单成功" toView:oneVC.view];
                }
            }
            
            
            
            
            
            
           // [self.navigationController popViewControllerAnimated:YES];
        } error:nil HUDAddView:self.view];
        
        
    }];
    [clear addAction:quXiao];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];

    
    
    
    
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    isDown = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"加单列表";
    
    UIButton *jdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jdBtn.frame = CGRectMake(0, BOUND_HIGHT-44, BOUND_WIDTH/2.0, 44);
    
    [jdBtn setTitle:@"加单" forState:UIControlStateNormal];
    [jdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jdBtn.alpha = 0.8;
    [jdBtn addTarget:self action:@selector(jdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [jdBtn setBackgroundColor:MAINColor];
    [self.view addSubview:jdBtn];
    
    
    
    
    UIButton *jdjsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jdjsBtn.frame = CGRectMake(BOUND_WIDTH/2.0, BOUND_HIGHT-44, BOUND_WIDTH/2.0, 44);
    
    [jdjsBtn setTitle:@"加单结算" forState:UIControlStateNormal];
    [jdjsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jdjsBtn addTarget:self action:@selector(jdjsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [jdjsBtn setBackgroundColor:MAINColor];
    [self.view addSubview:jdjsBtn];

    
    
    reuseIdentifier = @"DetailsTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT-44-64)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = BGColor;
    
    
  
    
        __weak UITableView *tableView = _tableView;
        WS(weakSelf);
        //下拉刷新
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
            isDown = YES;
            [weakSelf requestData];
            // 结束刷新
            [tableView.header endRefreshing];
        }];
      //  [tableView.header beginRefreshing];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.header.automaticallyChangeAlpha = YES;
    
//        // 上拉刷新
//        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            isDown = NO;
//            [weakSelf requestData];
//            [tableView.footer endRefreshing];
//        }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
- (void)requestData{
    
//    if (isDown) {
//        pageNo = 1;
//    }
    
   // [NSString stringWithFormat:@"%@/%@",GETORDERS,_orFacefaceId];
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userId = [def objectForKey:@"userId"];
    
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@",GETWASTECARC,userId] withparameters:nil success:^(NSMutableDictionary *dic) {
        
       // NSLog(@"GETORDERS:%@",dic,[NSString stringWithFormat:@"%@/%@",GETWASTECARC]);
        
        if (isDown) {
            [_dataSour removeAllObjects];
        }
        
         NSArray *response = dic[@"lianjiuData"];
        if ([response isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *temp in response) {
                MingXiDanModel *model = [MingXiDanModel ModelWith:temp ];
                [_dataSour addObject:model];
            }

        }
        
        
        
        
//        if (isDown) {
//            pageNo = 2;
//        }else{
//            pageNo++;
//        }
        
        [_tableView reloadData];
        
    } error:nil];
    
    
}
-(void)zjmxBtnClick:(UIButton*)btn{
    NSInteger index = btn.tag-460000;// 判断点击了哪个按钮
    MingXiDanModel *model = _dataSour[index];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *urid = [def objectForKey:@"userId"];
    [networking AFNPOST:DELETEWASTECAR withparameters:@{@"userId":urid,@"orItemsProductId":model.orItemsProductId} success:^(NSMutableDictionary *dic) {
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
        [_tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//         [_tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
        
    } error:nil HUDAddView:self.view];
    [_dataSour removeObjectAtIndex:index];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSour.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    DetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MingXiDanModel *moel = _dataSour[indexPath.section];
    [cell fillCellWithModel:moel];
    
    
    cell.zjmxBtn.tag = indexPath.section+460000;
    [cell.zjmxBtn addTarget:self action:@selector(zjmxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row%2==0) {
//        return 0;
//    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
