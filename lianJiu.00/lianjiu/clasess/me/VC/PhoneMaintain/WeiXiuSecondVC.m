//
//  WeiXiuSecondVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WeiXiuSecondVC.h"
#import "WeiXiuSecondCell.h"

#import "WeiXiuThreeVC.h"
@interface WeiXiuSecondVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WeiXiuSecondVC

{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSMutableArray * childrenArr;//总的内容
    
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *l = [[UILabel alloc] init];
    l.text = @"     选择故障";
    l.font = PFR15Font;
    l.textAlignment = NSTextAlignmentLeft;
    l.frame = CGRectMake(0, 0, BOUND_WIDTH-18, 30);
    
    reuseIdentifier = @"WeiXiuSecondCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    childrenArr = [[NSMutableArray alloc] init];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
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
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@",GETPARAMTEMPLATE,_repairId] withparameters:nil success:^(NSMutableDictionary *dic) {
        
//        if (isDown) {
//            [_dataSour removeAllObjects];
//        }
        
        
        NSDictionary *response = dic[@"lianjiuData"];
        
        
        NSString *spxqStr = response[@"jsonStr"];
        NSData *nsData=[spxqStr dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *spsxArr =[NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
        
        
        
        
        childrenArr = [spsxArr[0] objectForKey:@"children"];
        
        
        
        
//        // [_mutStrID appendString:becomeArr[6]];
//        NSMutableString *mutString = [[NSMutableString alloc] init];
//        NSMutableString *mutString2 = [[NSMutableString alloc] init];
//        for (NSDictionary *temp in childrenArr) {
//            ;
//            [mutString appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"retrieveType"]]];
//            [mutString2 appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"major"]]];
//            // _spsxDataArr addObject:[temp objectForKey:@"retrieveType"];
//            
//        }
        [_dataSour addObjectsFromArray:childrenArr];
        
        
        
        
        
        
        
        
        
        
        
        
        for (NSDictionary *temp in childrenArr) {
           
            if ([temp[@"major"] isEqualToString:@"显示屏/触摸"]) {
                
                [_dataSour removeLastObject];
            }
            
//            [mutString appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"retrieveType"]]];
//            [mutString2 appendString:[NSString stringWithFormat:@"%@ ",[temp objectForKey:@"major"]]];
            // _spsxDataArr addObject:[temp objectForKey:@"retrieveType"];
            
        }

        
        
        
        
        
        
      //  [_dataSour addObjectsFromArray:childrenArr];
      
        
        
        
        NSLog(@"dicdicdic:%@_repairId %@   spsxArrspsxArr%@   spxqStrspxqStrspxqStr%@   _dataSour_dataSour_dataSour%@",dic,_repairId  ,spsxArr,spxqStr,_dataSour);
        
        
        // NSArray *response = dic[@"response"];
        // for (NSDictionary *temp in response) {
        //            MyNewsModel *model = [MyNewsModel ModleWith:temp andScreeW:self.view.window.bounds.size.width];
        //            [_dataSour addObject:model];
        //}
        
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
        WeiXiuSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
        
        
        
        if (_dataSour.count>0) {
            
            cell.titleL.text = [_dataSour[indexPath.row/2] objectForKey:@"major"];
            
            
            if ([cell.titleL.text isEqualToString:@"显示屏/触摸"]) {
                cell.leftImageView.image = [UIImage imageNamed:@"Display-screen_xs"];
                
            }else if ([cell.titleL.text isEqualToString:@"电池/充电"]) {
                cell.leftImageView.image = [UIImage imageNamed:@"battery_dc"];
                
            }else if ([cell.titleL.text isEqualToString:@"按键"]) {
                cell.leftImageView.image = [UIImage imageNamed:@"button_aj"];
                
            }else if ([cell.titleL.text isEqualToString:@"声音/震动"]) {
                cell.leftImageView.image = [UIImage imageNamed:@"sound_sy"];
                
            }else if ([cell.titleL.text isEqualToString:@"照相"]) {
                
                cell.leftImageView.image = [UIImage imageNamed:@"Camera_zx"];
                
            }else if ([cell.titleL.text isEqualToString:@"WiFi"]) {
                
                cell.leftImageView.image = [UIImage imageNamed:@"WIFI_w"];
                
            }else if ([cell.titleL.text isEqualToString:@"进水/主板"]) {
                
                cell.leftImageView.image = [UIImage imageNamed:@"Water_s"];
                
            }else if ([cell.titleL.text isEqualToString:@"其他"]) {
                
                cell.leftImageView.image = [UIImage imageNamed:@"other_qt"];
                
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
    if ([[_dataSour[indexPath.row/2] objectForKey:@"major"] isEqualToString:@"显示屏/触摸"]) {
        
        
        
        WeiXiuThreeVC *wvc = [[WeiXiuThreeVC alloc] init];
        
        wvc.colorDataArr = [childrenArr.lastObject objectForKey:@"children"];
        
        
        wvc.title = self.title;
        wvc.repairId = _repairId;
        
        wvc.clickAlljsonDataArr = [_dataSour[indexPath.row/2] objectForKey:@"children"];
        
        [self.navigationController pushViewController:wvc animated:YES];
        
        
      NSLog(@"wvc.colorDataArrwvc.colorDataArr:%@======wvc.clickAlljsonDataArr%@",wvc.colorDataArr,wvc.clickAlljsonDataArr);
        
        
        
    }else{
        
        WeiXiuFourVC *wvc = [[WeiXiuFourVC alloc] init];
        wvc.clickAlljsonDataArr = [_dataSour[indexPath.row/2] objectForKey:@"children"];
        
         wvc.title = self.title;
        wvc.repairId = _repairId;
        
        [self.navigationController pushViewController:wvc animated:YES];
        
         NSLog(@"wvc.colorDataArrwvc.colorDataArr:======wvc.clickAlljsonDataArr%@",wvc.clickAlljsonDataArr);
        
    }
    
    
   
    //  [_dataSour[indexPath.row/2] objectForKey:@"major"];
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
