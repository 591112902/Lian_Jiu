//
//  LLSearchSuggestionVC.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchSuggestionVC.h"
#import "LLSearchSuggestionModel.h"
@interface LLSearchSuggestionVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_dataSour;
}
@property (nonatomic, strong) UITableView *contentView;
@property (nonatomic, copy)   NSString *searchTest;

@end

@implementation LLSearchSuggestionVC

- (UITableView *)contentView
{
    if (!_contentView) {
        self.contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.tableFooterView = [UIView new];
    }
    return _contentView;
}

- (void)requestData:(NSString *)keyword{
    
    NSString *url ;
    if ([_qExcellent isEqualToString:@"qExcellent"]) {
        
        url = SEARCHQUERYEXCELLENT;
    }else{
        url = SEARCHQUERY;
    }
    
    
    [networking AFNPOST:url withparameters:@{@"keyword":keyword} success:^(NSMutableDictionary *dic) {
        NSLog(@"dic:%@",dic);
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            
             [_dataSour removeAllObjects];
            
            NSArray *response = dic[@"lianjiuData"];
            for (NSDictionary *temp in response) {
                LLSearchSuggestionModel *model = [LLSearchSuggestionModel ModelWith:temp ];
                [_dataSour addObject:model];
            }
            
            [_contentView reloadData];
        }
    } error:nil HUDAddView:self.view];
 
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    _dataSour = [[NSMutableArray alloc] init];
   
    
}

- (void)searchTestChangeWithTest:(NSString *)test
{
    _searchTest = test;
     NSLog(@"viewDidLoad:%@",test);
    
    [self requestData:test];
    [_contentView reloadData];
    
}


#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSour.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
     LLSearchSuggestionModel *model = _dataSour[indexPath.row];
    
    
    cell.textLabel.text = model.productName?model.productName:@"";
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"最高价回收:%@元",model.productMaxPrice];
    
    
    
    
    NSString *banceStr = [NSString stringWithFormat:@"¥%@",model.productMaxPrice];//要变色的字
    NSString *str1 =  [NSString stringWithFormat:@"最高回收价%@",banceStr];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str1];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:banceStr].location, [[noteStr string] rangeOfString:banceStr].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.98 green:0.57 blue:0.2 alpha:1] range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:redRange];
    [cell.detailTextLabel setAttributedText:noteStr];
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;

    
    
    
    
    
    
    
    
    
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    

    
    return cell;
}


#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLSearchSuggestionModel *model = _dataSour[indexPath.row];
    
    
    NSString *nameAndID = [NSString stringWithFormat:@"%@/%@/%@",model.productName?model.productName:@"",model.productId?model.productId:@"",model.category];;
//    if (nameAndID.length>1) {
//        
//        nameAndID = [NSString stringWithFormat:@"%@/%@",model.productName?model.productName:@"",model.productId?model.productId:@""];
//    }else{
//        nameAndID = @"";
//    }
    
   // NSString *titleStr = model.productName?model.productName:@"";
    if (self.searchBlock) {
        self.searchBlock(nameAndID);
    }
    
    
    // category： 1 废品 2家电 3手机
    if ([model.category isEqualToNumber:@1]) {
        
        ScrapDetailViewController *svc = [[ScrapDetailViewController alloc] init];
        svc.wPriceId = model.productId;
        svc.name = model.productName;
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if ([model.category isEqualToNumber:@2]){//家电
        
        
       
        ChooseConditionVC *cvc = [[ChooseConditionVC alloc] init];
        cvc.titleStr = model.productName;
        cvc.productID = model.productId;
       // cvc.productPrice = model.productPrice;
        cvc.isPhoneNotJD = NO;
        
        [self.navigationController pushViewController:cvc animated:YES];
    }else if ([model.category isEqualToNumber:@3]){
        ChooseConditionVC *cvc = [[ChooseConditionVC alloc] init];
        cvc.titleStr = model.productName;
        cvc.productID = model.productId;
        // cvc.productPrice = model.productPrice;
        cvc.isPhoneNotJD = YES;
        
        [self.navigationController pushViewController:cvc animated:YES];

    
    }else if ([model.category isEqualToNumber:@4]){
        UsedGoodsDetailVC *uv = [[UsedGoodsDetailVC alloc] init];
        uv.productId = model.productId;
        uv.title = model.productName;
        [self.navigationController pushViewController:uv animated:YES];
     }

    
    
}


- (void)didReceiveMemoryWarning
{
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
