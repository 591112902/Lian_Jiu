//
//  SegmentViewController.m
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "AllProdctPingJia.h"
#import "PingJiaTableViewCell.h"
#import "MJRefresh.h"
#import "PingJiaModel.h"

@interface AllProdctPingJia ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AllProdctPingJia
{
    
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    reuseIdentifier = @"PingJiaTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH,BOUND_HIGHT)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = BGColor;
    
//
//       pageNo = 1;
//       [self requestData];
        __weak UITableView *tableView = self.tableView;
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
    // Do any additional setup after loading the view.
}



- (void)requestData{
    
    if (isDown) {
        pageNo = 1;
    }
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/%@/10/current",GETCOMMENT,_pid,[NSNumber numberWithInteger:pageNo]] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"pingjia---:%@",dic);
        
        if (isDown) {
            [_dataSour removeAllObjects];
        }

        
     
         NSArray *response = dic[@"lianjiuData"];
         for (NSDictionary *temp in response) {
             PingJiaModel *model = [PingJiaModel ModelWith:temp ];
             [_dataSour addObject:model];
        }

        
        
        
        if (isDown) {
            pageNo = 2;
        }else{
            pageNo++;
        }
        
        [_tableView reloadData];
    } error:nil HUDAddView:nil];
    
    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSour.count*2;//
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
        PingJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PingJiaModel *moel = _dataSour[indexPath.row/2];
            [cell fillCellWithModel:moel];
        return cell;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        
        return 1;
        
    }
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
