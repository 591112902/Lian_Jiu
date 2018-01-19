//
//  DeatailsViewController.m
//  jiaMengShang
//
//  Created by LIHONG on 2017/9/4.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "MXNextDeatailsViewController.h"
#import "MXNextDetailsTableViewCell.h"
@interface MXNextDeatailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MXNextDeatailsViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"回收明细单";
    
    UIView *headContenV = [[UIView alloc] init];
    headContenV.frame = CGRectMake(0, 64, BOUND_WIDTH, 44);
    headContenV.backgroundColor = [UIColor whiteColor];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 8, BOUND_WIDTH-20, 30)];
    headLabel.text = [NSString stringWithFormat:@"订单编号:%@",_orFacefaceId];//orFacefaceId
    headLabel.textColor = [UIColor darkGrayColor];
    headLabel.font = [UIFont systemFontOfSize:15];
    headLabel.numberOfLines = 0;
    [headContenV addSubview:headLabel];

    UIImageView *cutIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43, BOUND_WIDTH-20, 1)];
    cutIV.backgroundColor = BGColor;
    [headContenV addSubview:cutIV];
    
    
    
    
    
    reuseIdentifier = @"MXNextDetailsTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = BGColor;
    
    
    _tableView.tableHeaderView = headContenV;
        __weak UITableView *tableView = _tableView;
        WS(weakSelf);
        //下拉刷新
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
            isDown = YES;
            [weakSelf requestData];
            // 结束刷新
            [tableView.header endRefreshing];
        }];
        [tableView.header beginRefreshing];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.header.automaticallyChangeAlpha = YES;
 
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
- (void)requestData{
    
//    if (isDown) {
//        pageNo = 1;
//    }
    
   // [NSString stringWithFormat:@"%@/%@",GETORDERS,_orFacefaceId];
      NSLog(@"SELECTORDERDETAILSKD:%@",[NSString stringWithFormat:@"%@/%@",SELECTORDERDETAILSKD,_orFacefaceId]);
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@",SELECTORDERDETAILSKD,_orFacefaceId] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        NSLog(@"SELECTORDERDETAILSKD:%@%@",dic,[NSString stringWithFormat:@"%@/%@",@"",_orFacefaceId]);
        
        if (isDown) {
            [_dataSour removeAllObjects];
        }
      
        
       
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            for (NSDictionary *temp in response) {
                JinQiJiaModel *model = [JinQiJiaModel ModelWith:temp ];
                [_dataSour addObject:model];
            }

        }
        [_tableView reloadData];
        
    } error:nil];
    
    
}
-(void)zjmxBtnClick:(UIButton*)btn{
    NSInteger index = btn.tag-460000;// 判断点击了哪个按钮
    JinQiJiaModel *model = _dataSour[index];
    
    //kuaiddi快递的
    if ([model.orItemsStatus isEqualToNumber:@0]||[model.orItemsStatus isEqualToNumber:@1]||[model.orItemsStatus isEqualToNumber:@3]||[model.orItemsStatus isEqualToNumber:@4]) {
        
        
        //质检明细-简单-少少
        //质检明细-简单-少少
        ZJMXShaoOderViewController *vc = [[ZJMXShaoOderViewController alloc] init];
        vc.orItemsId = model.orItemsId;//@"1505979355659-a480b8c1-76a7-40ca-9795-caed08552502";
        vc.isPhone = YES;
        vc.title = model.orItemsName;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

        
    }else{
        
        OderViewController *vc = [[OderViewController alloc] init];
        vc.orItemsId = model.orItemsId;//@"1505979355659-a480b8c1-76a7-40ca-9795-caed08552502"
        vc.isPhone = YES;
        vc.title = model.orItemsName;
        //vc.model = model;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
    
  
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
        MXNextDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            JinQiJiaModel *moel = _dataSour[indexPath.row/2];
            [cell fillCellWithModel:moel];
        
        cell.zjbgBtn.tag = indexPath.row/2+460000;
        [cell.zjbgBtn addTarget:self action:@selector(zjmxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        return 2;
    }
    return 103;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
