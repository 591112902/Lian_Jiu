//
//  WeiXiuFirstVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WeiXiuFirstVC.h"
#import "WeiXiuFirstCell.h"

#import "WeiXiuSecondVC.h"

@interface WeiXiuFirstVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WeiXiuFirstVC
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *l = [[UILabel alloc] init];
    l.text = @"     选择机型";
    l.font = PFR15Font;
    l.textAlignment = NSTextAlignmentLeft;
    l.frame = CGRectMake(0, 0, BOUND_WIDTH-18, 30);
    
    
    reuseIdentifier = @"WeiXiuFirstCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
     [self requestData];
    
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
    
    _tableView.tableHeaderView = l;
}

- (void)requestData{
    
//    if (isDown) {
//        pageNo = 1;
//    }
    
   
    
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@",GETREPAIR,_cid] withparameters:nil success:^(NSMutableDictionary *dic) {
        
//        if (isDown) {
//            [_dataSour removeAllObjects];
//        }
        NSLog(@"GETREPAIR:%@",dic);
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        
       
        
        if ([lianjiuData[@"repairs"] isKindOfClass:[NSArray class]]) {
            
            NSArray *response = lianjiuData[@"repairs"];
            
            for (NSDictionary *temp in response) {
                
                [_dataSour addObject:temp];
            }
            
            
            [_tableView reloadData];

        }
        
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
        WeiXiuFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    
        if (_dataSour.count>0) {
            
             cell.titleL.text = [_dataSour[indexPath.row/2] objectForKey:@"repairName"];
            
            
            [cell.leftBtn setTitle:[NSString stringWithFormat:@"%ld",(long)indexPath.row/2+1] forState:UIControlStateNormal];
            cell.leftBtn.layer.cornerRadius = cell.leftBtn.frame.size.width/2.0;
            NSInteger indx = indexPath.row/2;
            if (indx%2 == 0) {//1
                cell.leftBtn.backgroundColor = [UIColor colorWithRed:0.54 green:0.87 blue:1 alpha:1];
                
            }else if (indx%2 == 1) {//2
                cell.leftBtn.backgroundColor = [UIColor colorWithRed:1 green:0.8 blue:0.47 alpha:1];
                
            }else if (indx%2 == 2) {//3
                
                cell.leftBtn.backgroundColor = [UIColor colorWithRed:0.7 green:0.85 blue:0.51 alpha:1];
            }
            
            
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
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiXiuSecondVC *wvc = [[WeiXiuSecondVC alloc] init];
    
    wvc.repairId = [_dataSour[indexPath.row/2] objectForKey:@"repairId"];
    wvc.title = [_dataSour[indexPath.row/2] objectForKey:@"repairName"];
    [self.navigationController pushViewController:wvc animated:YES];
    
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
