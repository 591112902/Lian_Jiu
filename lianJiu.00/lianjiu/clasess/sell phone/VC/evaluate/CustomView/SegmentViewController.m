//
//  SegmentViewController.m
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "SegmentViewController.h"
#import "EvaluateLeftCell.h"
#import "MJRefresh.h"

#import "EValuateRightCell.h"

@interface SegmentViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SegmentViewController
{
//    NSMutableArray *_dataSourPL;
//    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
     NSString *reuseIdentifier2;
    NSInteger pageNo;
    BOOL isDown;
    
    
}
-(void)reloadJQTableView{
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    reuseIdentifier = @"EvaluateLeftCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH,BOUND_HIGHT-50-64-41)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
   // _dataSour = [[NSMutableArray alloc] init];
    _dataSourPL = [[NSMutableArray alloc] init];
    
    _tableView.backgroundColor = BGColor;
    
//    isDown = YES;
   // [self requestData];
//
    
    
    
//        __weak UITableView *tableView = self.tableView;
//        WS(weakSelf);
////        //下拉刷新
////        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////    
////            isDown = YES;
////            [self requestData];
////            // 结束刷新
////            [tableView.header endRefreshing];
////        }];
////        [tableView.header beginRefreshing];
////        // 设置自动切换透明度(在导航栏下面自动隐藏)
////        tableView.header.automaticallyChangeAlpha = YES;
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



//- (void)requestData{//
//    NSString *url;
//    if (_isPhone) {//shoji
//        url = CALCULATIONPRICE;
//    }else{//jia dian
//        url = CALCULATIONJDPRICE;
//    }
//    [networking AFNPOST:url withparameters:@{@"TAKEN":_tokenS} success:^(NSMutableDictionary *dic) {
//        
//        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
//            
//            NSDictionary *lianjiuData = dic[@"lianjiuData"];
//            
//            NSLog(@"dicdicdic:%@",dic);
//            
//            if ([lianjiuData[@"item"] isKindOfClass:[NSArray class]]) {
//                NSArray *item = lianjiuData[@"item"];
//                for (NSDictionary *temp in item) {
//                    
//                    JinQiJiaModel *model = [JinQiJiaModel ModelWith:temp ];
//                    
//                    if (_isPhone) {
//                        model.hsfs = @"快递回收";//快递回收
//                        
//                    }else {
//                        model.hsfs = @"上门回收";
//                    }
//                    
//                    [_dataSour addObject:model];
//                }
//            }
//            
//        }
//    } error:nil HUDAddView:self.view];
//    
//    
//}



- (void)zjbgBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag-46000;// 判断点击了哪个按钮
    JinQiJiaModel *model = _dataSour[index];
    OderViewController *ovc = [[OderViewController alloc] init];
    ovc.isPhone = _isPhone;
    ovc.title = model.orItemsName;
    //ovc.model = model;
    ovc.orItemsId = model.orItemsId;
    [self.navigationController pushViewController:ovc animated:YES];

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
        
            EvaluateLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            if (_dataSour.count>0) {
                
                [cell fillCellWithModel:_dataSour[indexPath.row/2]];
                
                cell.zjbgBtn.tag = indexPath.row/2+46000;
                cell.zjbgBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
                [cell.zjbgBtn addTarget:self action:@selector(zjbgBtnClick:) forControlEvents:UIControlEventTouchUpInside];

            }
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
