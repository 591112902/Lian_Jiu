//
//  ScrapListViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/8.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//
#import "MJRefresh.h"
#import "ScrapListViewController.h"
#import "ScrapListViewCell.h"
#import "ScrapDetailViewController.h"
@interface ScrapListViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation ScrapListViewController

{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.view.backgroundColor = BGColor;
    
    reuseIdentifier = @"ScrapListViewCell";
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
    
        // 上拉刷新
        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            isDown = NO;
            [weakSelf requestData];
            [tableView.footer endRefreshing];
        }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)requestData{
    
    if (isDown) {
        pageNo = 1;
    }
    
    
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@/%zd/10/ByCid",GETWASTE,_categoryId,pageNo] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        
        NSLog(@"%@%@",dic,_categoryId);
        
        if (isDown) {
            [_dataSour removeAllObjects];
        }
       
        
        
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        if ([lianjiuData[@"wasteList"] isKindOfClass:[NSArray class]]) {
            
            
            NSArray *response = lianjiuData[@"wasteList"];
            for (NSDictionary *temp in response) {
                ScrapListViewModel *model = [ScrapListViewModel ModelWith:temp ];
                [_dataSour addObject:model];
            }
        }
        
        
        
        
        if (isDown) {
            pageNo = 2;
        }else{
            pageNo++;
        }
        
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
        ScrapListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ScrapListViewModel *moel = _dataSour[indexPath.row/2];
        [cell fillCellWithModel:moel];
        return cell;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        
        return 1;
        
    }
    return 136;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_jiadanS.length>0) {
       
        
        JianDianBtnNextViewController *svc = [[JianDianBtnNextViewController alloc] init];
        ScrapListViewModel *moel = _dataSour[indexPath.row/2];
        svc.wPriceId = moel.wPriceId;
        svc.name = moel.name;
        
        
        
        [self.navigationController pushViewController:svc animated:YES];

    }else{
        ScrapDetailViewController *svc = [[ScrapDetailViewController alloc] init];
        ScrapListViewModel *moel = _dataSour[indexPath.row/2];
        svc.wPriceId = moel.wPriceId;
        svc.name = moel.name;
        svc.wasteImage = moel.wasteImage;
        
        svc.title = self.title;
        
        [self.navigationController pushViewController:svc animated:YES];

    }
    
    
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
