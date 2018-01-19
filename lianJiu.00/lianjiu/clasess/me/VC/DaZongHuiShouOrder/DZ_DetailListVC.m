


#import "DZ_DetailListVC.h"
#import "SetUpListTableViewCell.h"
#import "SetUpListHeadView.h"
#import "MJRefresh.h"
@interface DZ_DetailListVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation DZ_DetailListVC
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    UITextField *serchTF;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat hY =5;
   
    
    
    
    reuseIdentifier = @"SetUpListTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, hY, BOUND_WIDTH, BOUND_HIGHT-hY)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    //_tableView.backgroundColor = BGColor;
        __weak UITableView *tableView = _tableView;
        WS(weakSelf);
        //下拉刷新
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            isDown = YES;
            [self requestData];
            // 结束刷新
            [tableView.header endRefreshing];
        }];
        [tableView.header beginRefreshing];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.header.automaticallyChangeAlpha = YES;
    
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
//    if (isDown) {
//        pageNo = 1;
//    }
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@",B_ORDERSDETAILS,_categoryId?_categoryId:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"%@",_categoryId);
        if (isDown) {
            [_dataSour removeAllObjects];
        }

        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            for (NSDictionary *temp in response) {
                CommitListModel *model = [CommitListModel ModelWith:temp ];
                [_dataSour addObject:model];
            }
//            if (isDown) {
//                pageNo = 2;
//            }else{
//                pageNo++;
//            }
        }
        
        [_tableView reloadData];
    } error:nil];
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

    CommitListModel *model = _dataSour[indexPath.row];
    NSString *danwei ;
    NSString *wPriceUnit =[NSString stringWithFormat:@"%@",model.bulkItemUnit];
    if ([wPriceUnit isEqualToString:@"0"]) {
        danwei = @"米";
    }else if ([wPriceUnit isEqualToString:@"1"]) {
        danwei = @"个";
    }else if ([wPriceUnit isEqualToString:@"2"]) {
        danwei = @"克";
    }else if ([wPriceUnit isEqualToString:@"3"]) {
        danwei = @"千克";
    }else if ([wPriceUnit isEqualToString:@"4"]) {
        danwei = @"台";
    }else if ([wPriceUnit isEqualToString:@"5"]) {
        danwei = @"斤";
    }else if ([wPriceUnit isEqualToString:@"6"]) {
        danwei = @"公斤";
    }else if ([wPriceUnit isEqualToString:@"7"]) {
        danwei = @"部";
    }
    
    
   
    if ([self.title isEqualToString:@"货物清单"]) {
        
        cell.nameL.text = model.bulkItemName?model.bulkItemName:@"";
        cell.priceSingleL.text = [NSString stringWithFormat:@"%@元/%@",model.bulkItemPrice,danwei];
        cell.bulkNumL.text = [NSString stringWithFormat:@"%@%@",model.bulkItemNum,danwei];

    }else{
        cell.nameL.text = model.bulkItemName?model.bulkItemName:@"";
        cell.priceSingleL.text = [NSString stringWithFormat:@"%@元/%@",model.bulkItemPriceCurrent,danwei];
        cell.bulkNumL.text = [NSString stringWithFormat:@"%@%@",model.bulkItemNumModify,danwei];

    }
    
    
   // [cell fillCellWithCModel:model];
    
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
