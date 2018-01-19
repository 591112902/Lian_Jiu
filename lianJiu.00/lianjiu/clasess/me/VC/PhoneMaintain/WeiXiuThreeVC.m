//
//  WeiXiuThreeVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "WeiXiuThreeVC.h"
#import "singleSelectTableViewCell.h"
#import "WeiXiuFourVC.h"

#define defaultTag 1990

@interface WeiXiuThreeVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *totleArray;

@property (nonatomic, assign) NSInteger btnTag;//默认选中的Tag

@end

@implementation WeiXiuThreeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // self.title = @"";
    
    self.totleArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *temp in self.colorDataArr) {
        
        [self.totleArray addObject:temp[@"major"]];
        
    }
    
   // self.btnTag = defaultTag+1; //self.btnTag = defaultTag+1  表示默认选择第二个，依次类推
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UILabel *l = [[UILabel alloc] init];
    l.text = @"  选择颜色";
    l.font = PFR16Font;
    l.backgroundColor = [UIColor whiteColor];
    l.textAlignment = NSTextAlignmentLeft;
    l.frame = CGRectMake(0, 0, BOUND_WIDTH, 39);
    
     _tableView.tableHeaderView = l;
    
    
    
    
    
    
//_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
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
    
}

- (void)requestData{
    
//    if (isDown) {
//        pageNo = 1;
//    }
//    [networking AFNPOSTNotHUD:QUERYPUSH withparameters:@{@"vip":@"",@"pageNo":[NSNumber numberWithInteger:pageNo]} success:^(NSMutableDictionary *dic) {
//        
//        if (isDown) {
//            [_dataSour removeAllObjects];
//        }
//        
//        // NSArray *response = dic[@"response"];
//        // for (NSDictionary *temp in response) {
//        //            MyNewsModel *model = [MyNewsModel ModleWith:temp andScreeW:self.view.window.bounds.size.width];
//        //            [_dataSour addObject:model];
//        //}
//        
//        if (isDown) {
//            pageNo = 2;
//        }else{
//            pageNo++;
//        }
//        
//        [_tableView reloadData];
//        
//    } error:nil];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.totleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    singleSelectTableViewCell *customCell = [[singleSelectTableViewCell alloc] init];
    customCell.titleLabel.text = self.totleArray[indexPath.row];
    customCell.selectBtn.tag = defaultTag+indexPath.row;
  
    

    if (customCell.selectBtn.tag == self.btnTag) {
        customCell.isSelect = YES;
        [customCell.selectBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
    }else{
        customCell.isSelect = NO;
        [customCell.selectBtn setImage:[UIImage imageNamed:@"unSelect_btn"] forState:UIControlStateNormal];
    }
    __weak singleSelectTableViewCell *weakCell = customCell;
    [customCell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
        if (choice) {
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
            self.btnTag = btnTag;
            NSLog(@"$$$$$$%ld",(long)btnTag);
            [self.tableView reloadData];
            
        }
        else{
            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
            [weakCell.selectBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
            self.btnTag = btnTag;
            [self.tableView reloadData];
            NSLog(@"#####%ld",(long)btnTag);
        }
#pragma mark-在这里跳转下一页.
        NSLog(@"self.btnTag:%ld  选择了:%@",(long)self.btnTag-1990,self.totleArray[(long)self.btnTag-1990]);
        
        
        WeiXiuFourVC *fvc = [[WeiXiuFourVC alloc] init];
        
        fvc.title = self.title;
        fvc.repairId = _repairId;
        fvc.clickAlljsonDataArr =  _clickAlljsonDataArr;
        fvc.selectColor = self.totleArray[(long)self.btnTag-1990];
        
        
        [self.navigationController pushViewController:fvc animated:YES];
        
        
        
        
    }];
    
    
    
    
    
    cell = customCell;
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了%ld行",(long)indexPath.row);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
