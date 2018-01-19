


#import "CommitListVC.h"
#import "SetUpListTableViewCell.h"
#import "SetUpListHeadView.h"
#import "MJRefresh.h"
@interface CommitListVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation CommitListVC
{
    UITableView *_tableView;
   // NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    UITextField *serchTF;
    
}
- (void)sureQDAction {
   
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString *TAKEN  = [def objectForKey:@"BulkToken"];
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
        
        return;
    }
    
    
    if (_dataSour.count==0) {
        [MBProgressHUD showNotPhotoError:@"清单为空,请选择一些物品" toView:self.view];
        return;
    }
    
    NSLog(@"TAKEN:%@==",TAKEN);
    
    
    
    

    
    
    [networking AFNPOST:B_ORDERSPREVIEW withparameters:@{@"TAKEN":TAKEN?TAKEN:@""} success:^(NSMutableDictionary *dic) {
        
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSString class]]) {
            
            NSString *all_price = dic[@"lianjiuData"];
            CommitListNextVC *cnVC = [[CommitListNextVC alloc] init];
            cnVC.allPrice = all_price?all_price:@"";
            [self.navigationController pushViewController:cnVC animated:YES];
        }
    } error:nil HUDAddView:self.view];
   
  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat hY =64+5;
    self.title = @"确认清单";
    UIButton *zdqdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zdqdBtn.frame = CGRectMake(0, BOUND_HIGHT-44, BOUND_WIDTH, 44);
    zdqdBtn.backgroundColor = MAINColor;
    [zdqdBtn setTitle:@"确认清单" forState:0];
    [zdqdBtn addTarget:self action:@selector(sureQDAction) forControlEvents:UIControlEventTouchUpInside];
    //zdqdBtn.layer.cornerRadius = 5;
    [zdqdBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:zdqdBtn];
    
    
    reuseIdentifier = @"SetUpListTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, hY, BOUND_WIDTH, BOUND_HIGHT-hY-44)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
//    _dataSour = [[NSMutableArray alloc] init];
//    //_tableView.backgroundColor = BGColor;
//        __weak UITableView *tableView = _tableView;
//        WS(weakSelf);
//        //下拉刷新
//        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            isDown = YES;
//            [self requestData];
//            // 结束刷新
//            [tableView.header endRefreshing];
//        }];
//        [tableView.header beginRefreshing];
//        // 设置自动切换透明度(在导航栏下面自动隐藏)
//        tableView.header.automaticallyChangeAlpha = YES;
//    
//        // 上拉刷新
//        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            isDown = NO;
//            [weakSelf requestData];
//            [tableView.footer endRefreshing];
//        }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    SetUpListHeadView *_headerView = [[[NSBundle mainBundle]loadNibNamed:@"SetUpListHeadView" owner:nil options:nil]lastObject];
    _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    _tableView.tableHeaderView =_headerView;

 
}
- (void)requestData{
    
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *bulkToken  = [def objectForKey:@"BulkToken"];
//
//    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@",GETBULKITEMCART,bulkToken?bulkToken:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
//       
//        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
//            NSArray *response = dic[@"lianjiuData"];
//            
//            for (NSDictionary *temp in response) {
//                CommitListModel *model = [CommitListModel ModelWith:temp ];
//                [_dataSour addObject:model];
//            }
//        }
//        [_tableView reloadData];
//    } error:nil];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSour.count;//_dataSour.count
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SetUpListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.bulkNumL.hidden = NO;
    cell.bulkNumTF.hidden = YES;
    cell.bulkNum_UnitLL.hidden = YES;

    CommitListModel *moel = _dataSour[indexPath.row];
    [cell fillCellWithCModel:moel];
    
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // SetUpListModel *moel = _dataSour[indexPath.row];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
