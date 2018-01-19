//
//  SegmentViewController.m
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "ProdctPingJia.h"
#import "PingJiaTableViewCell.h"
#import "MJRefresh.h"
#import "PingJiaModel.h"

#import "AllProdctPingJia.h"


@interface ProdctPingJia ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ProdctPingJia
{
    
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    UIButton *allPingjiaBtn;
    
}
-(void)lookAllPJBtnClick{
    
    AllProdctPingJia *all = [[AllProdctPingJia alloc] init];
    all.pid = _pid;
    all.title = @"全部评价";
    [self.navigationController pushViewController:all animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    reuseIdentifier = @"PingJiaTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH,BOUND_HIGHT-44-64-BOUND_WIDTH/320.0*38)];//BOUND_HIGHT-44-64-BOUND_WIDTH/320.0*38
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    
   // self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIView *allPJBackV = [[UIView alloc] init];
    allPJBackV.backgroundColor =  [UIColor whiteColor];
    allPJBackV.frame = CGRectMake(0, 0, BOUND_WIDTH, 120);
    
    
    allPingjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allPingjiaBtn.backgroundColor = [UIColor whiteColor];
    allPingjiaBtn.frame = CGRectMake(20, 40, BOUND_WIDTH-40, 40);
    allPingjiaBtn.layer.cornerRadius = 3;
    allPingjiaBtn.layer.borderWidth = 1;
    allPingjiaBtn.backgroundColor = MAINColor;
    allPingjiaBtn.layer.borderColor = MAINColor.CGColor;
    [allPingjiaBtn setTitle:@"查看全部评价" forState:UIControlStateNormal];
    allPingjiaBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [allPingjiaBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [allPingjiaBtn addTarget:self action:@selector(lookAllPJBtnClick) forControlEvents:UIControlEventTouchUpInside];
    allPingjiaBtn.hidden = YES;
    [allPJBackV addSubview:allPingjiaBtn];
    
    _tableView.tableFooterView = allPJBackV;
    

//       pageNo = 1;
      // [self requestData];
//        __weak UITableView *tableView = self.tableView;
//        WS(weakSelf);
//        //下拉刷新
////        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////    
////            isDown = YES;
////            [self requestData];
////            // 结束刷新
////            [tableView.header endRefreshing];
////        }];
////        [tableView.header beginRefreshing];
//        // 设置自动切换透明度(在导航栏下面自动隐藏)
//        tableView.header.automaticallyChangeAlpha = YES;
//    
//        // 上拉刷新
//        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            isDown = NO;
//            [weakSelf requestData];
//            [tableView.footer endRefreshing];
//        }];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}







- (void)requestData:(NSString *)pid{
    
       [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/1/3/current",GETCOMMENT,pid] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"pingjiapingjiapingjiapingjia---:%@",dic);
        
           
           if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
               
               NSArray *response = dic[@"lianjiuData"];
               for (NSDictionary *temp in response) {
                   PingJiaModel *model = [PingJiaModel ModelWith:temp ];
                   [_dataSour addObject:model];
               }
               
               
               NSString *total = [NSString stringWithFormat:@"%@",dic[@"total"]];
               
               if (total.integerValue>3) {
                   allPingjiaBtn.hidden = NO;
                   [allPingjiaBtn setTitle:[NSString stringWithFormat:@"查看全部评价(%@)",total] forState:UIControlStateNormal];
               }else if (total.integerValue==0){
                   
                   allPingjiaBtn.hidden = NO;
                   [allPingjiaBtn setTitle:@"该产品暂时还没有评论" forState:UIControlStateNormal];
                   [allPingjiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                   allPingjiaBtn.backgroundColor = [UIColor clearColor];
                   allPingjiaBtn.layer.borderColor = [UIColor clearColor].CGColor;

               }else{
                   allPingjiaBtn.hidden = YES;

               }
               
             
               [_tableView reloadData];

           }
          
           
          } error:nil HUDAddView:self.view];
    
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
