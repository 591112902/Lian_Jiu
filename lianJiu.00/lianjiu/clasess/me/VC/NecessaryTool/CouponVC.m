//
//  CouponVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/6.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "CouponVC.h"
#import "MJRefresh.h"
#import "CouponModel.h"
#import "CouponTableViewCell.h"

@interface CouponVC ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation CouponVC
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    reuseIdentifier = @"CouponTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
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
        [self requestData];
        // 结束刷新
        [tableView.header endRefreshing];
    }];
    [tableView.header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
    
//    // 上拉刷新
//    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        isDown = NO;
//        [weakSelf requestData];
//        [tableView.footer endRefreshing];
//    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
- (void)requestData{
    
//    if (isDown) {
//        pageNo = 1;
//    }
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userID =  [def objectForKey:@"userId"];
    
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@/byUser",GETCOUPONLIST,userID] withparameters:nil success:^(NSMutableDictionary *dic) {
        
         [_dataSour removeAllObjects];
//        if (isDown) {
//            [_dataSour removeAllObjects];
//        }
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            
            NSArray *response = dic[@"lianjiuData"];
            for (NSDictionary *temp in response) {
                CouponModel *model = [CouponModel ModelWith:temp ];
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
        CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CouponModel *moel = _dataSour[indexPath.row/2];
        [cell fillCellWithModel:moel];
        return cell;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        
        return 5;
    }
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ChanPinListModel *moel = _dataSour[indexPath.row/2];
    //    ChooseAssessVC *cvc = [[ChooseAssessVC alloc] init];
    //    cvc.productID = moel.productId;
    //    [self.navigationController pushViewController:cvc animated:YES];
    
    // NSLog(@"moel.productId:%@",moel.productId);
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
