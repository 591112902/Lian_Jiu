//
//  SegmentViewController.m
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "PLSegmentViewController.h"
#import "MJRefresh.h"
#import "EValuateRightCell.h"

@interface PLSegmentViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PLSegmentViewController
{

    NSString *reuseIdentifier;
     NSString *reuseIdentifier2;
    NSInteger pageNo;
   
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH,BOUND_HIGHT-50-64-41)];
   // [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSourPL = [[NSMutableArray alloc] init];
    
    _tableView.backgroundColor = BGColor;
    
    
    reuseIdentifier2 = @"EValuateRightCell";
     [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier2 bundle:nil] forCellReuseIdentifier:reuseIdentifier2];
    
    
    
    
    
  //  [self requestDataPingLun:_productId];
    
    
    
    //isDown = YES;
//    [self requestData];
//
    
    
    
        __weak UITableView *tableView = self.tableView;
        WS(weakSelf);
//        //下拉刷新
//        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//    
//            isDown = YES;
//            [self requestData];
//            // 结束刷新
//            [tableView.header endRefreshing];
//        }];
//        [tableView.header beginRefreshing];
//        // 设置自动切换透明度(在导航栏下面自动隐藏)
//        tableView.header.automaticallyChangeAlpha = YES;
    
        // 上拉刷新
        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isDown = NO;
            [weakSelf requestDataPingLun:_productId];
            [tableView.footer endRefreshing];
        }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     //Do any additional setup after loading the view.
}




- (void)requestDataPingLun:(NSString *)pid{
    
        if (_isDown) {
            pageNo = 1;
        }

    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/%zd/10",GETCOMMENTBYRELATIVEID,self.type,pageNo] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        NSLog(@"GETCOMMENTBYRELATIVEID:%@",dic);
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            
            if (_isDown) {
                [self.dataSourPL removeAllObjects];
            }

            
            NSArray *item = dic[@"lianjiuData"];
            for (NSDictionary *temp in item) {
                 commentModel *model = [commentModel ModelWith:temp ];
                [self.dataSourPL addObject:model];
            }
        }
        NSLog(@"_dataSourPL:%@  para:%@",self.dataSourPL,[NSString stringWithFormat:@"%@/%@",GETCOMMENTBYRELATIVEID,_productId]);
        
        
        
        if (_isDown) {
            pageNo = 2;
        }else{
            pageNo++;
        }

        
          [_tableView reloadData];
        
    } error:nil HUDAddView:self.view];
    
   
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
          return _dataSourPL.count*2;//
    
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
        
            EValuateRightCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        
                 [cell fillCellWithModel:_dataSourPL[indexPath.row/2]];
             //   cell.lableLL.text =  [[_dataSourPL objectAtIndex:indexPath.row/2] objectForKey:@"commentDetails"];
                
        
            //    MyNewsModel *moel = _dataSour[indexPath.section];
            //    [cell fillCellWithModel:moel];
            return cell;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        
        return 1;
        
    }
    return 125;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
