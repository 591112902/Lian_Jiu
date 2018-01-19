//
//  SegmentViewController.m
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "SHFW.h"
#import "SHFUTableViewCell.h"

@interface SHFW ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SHFW
{
    
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    reuseIdentifier = @"SHFUTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH,BOUND_HIGHT-50-64-41)];
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
    // Do any additional setup after loading the view.
}




#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1*2;//
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
        SHFUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    MyNewsModel *moel = _dataSour[indexPath.section];
        //    [cell fillCellWithModel:moel];
        return cell;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        
        return 5;
        
    }
    return BOUND_WIDTH/750.0*900;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
