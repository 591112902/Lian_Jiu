//
//  ScrapListViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/8.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//
#import "MJRefresh.h"
#import "HDdetailViewController.h"
#import "ScrapListViewCell.h"
#import "ScrapDetailViewController.h"
@interface HDdetailViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation HDdetailViewController

{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HelpCenterList" ofType:@"plist"];
    //newsModel.plist文件
    _dataSour = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    self.view.backgroundColor = BGColor;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
 
    _tableView.backgroundColor = BGColor;

}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr =  _dataSour[_index];
    return arr.count*2;
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
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *arr =  _dataSour[_index];
        cell.textLabel.text = [arr[indexPath.row/2]objectForKey:@"t"];
        cell.textLabel.numberOfLines = 0;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        return 1;
    }
    NSArray *arr =  _dataSour[_index];
    NSString *tTitle = [arr[indexPath.row/2]objectForKey:@"t"];
    CGSize titleSize = [DCSpeedy dc_calculateTextSizeWithText:tTitle WithTextFont:17 WithMaxW:[UIScreen mainScreen].bounds.size.width - 2 *8];
    return titleSize.height +20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr =  _dataSour[_index];
    NSString *dTitle = [arr[indexPath.row/2]objectForKey:@"d"];
    NSString *tTitle = [arr[indexPath.row/2]objectForKey:@"t"];
    
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:tTitle message:dTitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
