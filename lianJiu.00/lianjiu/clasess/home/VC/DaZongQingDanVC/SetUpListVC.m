


#import "SetUpListVC.h"
#import "SetUpListTableViewCell.h"

#import "MJRefresh.h"
@interface SetUpListVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>

 @property (strong, nonatomic) NSMutableDictionary *parameters;
 @property (assign, nonatomic) BOOL isSearch;



@end

@implementation SetUpListVC
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;

    UITextField *serchTF;
    
    
    
    
    //以下为键盘所用
    UIView *selctTF;
    BOOL iskeyboatdshow;
    CGFloat kbHeight;
    double duration;

    
}
- (void)Tosearch
{
    [_parameters setObject:@1 forKey:@"pageNum"];
    [_parameters setObject:serchTF.text?serchTF.text:@"" forKey:@"keyword"];
    
    _isSearch = YES;
    [self addDatasourceIsDown:YES];
    
    
}
- (void)zdqdBtnClick//制定清单
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *bulkToken  = [def objectForKey:@"BulkToken"];
    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@",GETBULKITEMCART,bulkToken?bulkToken:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            NSMutableArray *mArr = [[NSMutableArray alloc] init];
            for (NSDictionary *temp in response) {
                CommitListModel *model = [CommitListModel ModelWith:temp ];
                [mArr addObject:model];
            }
            
            CommitListVC *clistVC = [[CommitListVC alloc] init];
            clistVC.dataSour = mArr;
            [self.navigationController pushViewController:clistVC animated:YES];
            
        }
      
    } error:nil];

    
    
}

#pragma mark - action
-(void)keyboard_Hide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}








- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboard_Hide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"制定货物清单";
    
    CGFloat hY =64+10;
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(10, hY, 70, 30)];
    nameL.font = [UIFont systemFontOfSize:15];
    nameL.text = @"货物名称:";
    [self.view addSubview:nameL];
    
    serchTF = [[UITextField alloc] initWithFrame:CGRectMake(80, hY, BOUND_WIDTH-80-80, 30)];
    //serchTF.delegate = self;
    serchTF.borderStyle = UITextBorderStyleRoundedRect;
    serchTF.textColor = [UIColor grayColor];
    serchTF.font = [UIFont systemFontOfSize:15];
    serchTF.tag = 8888;
    [self.view addSubview:serchTF];
    
    
    
    
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(BOUND_WIDTH-76 , hY+1, 70, 28)];
    searchBtn.backgroundColor = MAINColor;
    [searchBtn setTitle:@"搜索" forState:0];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    searchBtn.layer.cornerRadius = 5;
    [searchBtn addTarget:self action:@selector(Tosearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    hY+=40;
    
    
    
    UIButton *zdqdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zdqdBtn.frame = CGRectMake(10, BOUND_HIGHT-27-35, BOUND_WIDTH-20, 35);
    zdqdBtn.backgroundColor = MAINColor;
    [zdqdBtn setTitle:@"制定清单" forState:0];
    [zdqdBtn addTarget:self action:@selector(zdqdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    zdqdBtn.layer.cornerRadius = 5;
    [zdqdBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:zdqdBtn];
    
    
    reuseIdentifier = @"SetUpListTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, hY, BOUND_WIDTH, BOUND_HIGHT-hY-27-35  -10)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    //_tableView.backgroundColor = BGColor;
        __weak UITableView *tableView = _tableView;
        WS(weakSelf);
        //下拉刷新
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
            _isSearch = NO;
         [weakSelf addDatasourceIsDown:YES];            // 结束刷新
            [tableView.header endRefreshing];
        }];
        [tableView.header beginRefreshing];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.header.automaticallyChangeAlpha = YES;
    
        // 上拉刷新
        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isSearch = NO;
           [weakSelf addDatasourceIsDown:NO];
            [tableView.footer endRefreshing];
        }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    
    
    SetUpListHeadView *_headerView = [[[NSBundle mainBundle]loadNibNamed:@"SetUpListHeadView" owner:nil options:nil]lastObject];
    _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    _tableView.tableHeaderView =_headerView;
    
   // UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, 90)];
//    UIButton *zdqdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    zdqdBtn.frame = CGRectMake(10, 27, BOUND_WIDTH-20, 35);
//    zdqdBtn.backgroundColor = MAINColor;
//    [zdqdBtn setTitle:@"制定清单" forState:0];
//    zdqdBtn.layer.cornerRadius = 5;
//    [zdqdBtn setTitleColor:[UIColor whiteColor] forState:0];
//    [bView addSubview:zdqdBtn];
//    _tableView.tableFooterView =bView;

}

-(NSMutableDictionary *)parameters
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *bulkToken  = [def objectForKey:@"BulkToken"];
    
    
    if (!_parameters) {
        _parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"pageNum":@1,@"pageSize":@15,@"TAKEN":bulkToken}];
    }
    return _parameters;
}

//内容接口
- (void)addDatasourceIsDown:(BOOL)isDown
{
   
    
    NSMutableDictionary *parameters = [self.parameters mutableCopy];
    if (isDown) {
        [parameters setObject:@1 forKey:@"pageNum"];
    }
    
    [networking AFNPOST:BULKSEARCH withparameters:parameters success:^(NSMutableDictionary *dic) {
        if (isDown) {
            [_dataSour removeAllObjects];
        }

        
        if (_isSearch) {
            NSNumber *total=dic[@"total"];
            NSString *msg = dic[@"msg"]?dic[@"msg"]:@"";
            int totalInt = [total intValue];
            if (totalInt==0) {
                
                //暂无该货物进行回收，可联系链旧客服400-1818-209
                //提示框
                UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
               
                [clear addAction:queRen];
                [self presentViewController:clear animated:YES completion:nil];
               // [MBProgressHUD showNotPhotoError:@"暂无该货物进行回收，可联系链旧客服400-1818-209" toView:self.view];
            }
        }
        
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
           
            
            for (NSDictionary *temp in response) {
                SetUpListModel *model = [SetUpListModel ModelWith:temp ];
                [_dataSour addObject:model];
            }
            if (isDown) {
                [self.parameters setObject:@2 forKey:@"pageNum"];
            }else{
                NSInteger pageNo = [self.parameters[@"pageNum"] integerValue];
                pageNo ++;
                [self.parameters setObject:[NSNumber numberWithInteger:pageNo] forKey:@"pageNum"];
            }
        }
        [_tableView reloadData];
        
        
    } error:nil HUDAddView:self.view];
    
//    [networking AFNRequest:QUERYTENDER withparameters:parameters success:^(NSMutableDictionary *dic) {
//           } error:nil HUDAddView:self.view];
}




#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSour.count;//_dataSour.count
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetUpListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SetUpListModel *moel = _dataSour[indexPath.row];
    cell.bulkNumL.hidden = YES;
    cell.bulkNumTF.hidden = NO;
    cell.bulkNum_UnitLL.hidden = NO;
    [cell fillCellWithModel:moel];
    
    cell.bulkNumTF.delegate = self;
    cell.bulkNumTF.keyboardType =UIKeyboardTypeDecimalPad;
    cell.bulkNumTF.tag = indexPath.row+101010;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // SetUpListModel *moel = _dataSour[indexPath.row];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - uitextFileDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]&&textField.text.length<1) {
        return NO;
    }
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toString.length > 0) {//(\\+|\\-)?
        //正则表达式，可输入正负，小数点前10位，小数点后2位，位数可控
        NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,9}(([.]\\d{0,2})?)))?";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        BOOL flag = [phoneTest evaluateWithObject:toString];
        if (!flag) {
            return NO;
        }
    }
    
    
    NSLog(@"***fasdfdsf***");
    
    
    
    return YES;
}




- (void)textFieldDidEndEditing:(UITextField *)textField
{
  
    NSLog(@"textFieldDidEndEditing");
    
    NSInteger index = textField.tag-101010;
    SetUpListModel *model = _dataSour[index];
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *bulkToken  = [def objectForKey:@"BulkToken"];

    
 //  bulkItemVolume==1
    NSLog(@"bulkItemProductId:%@ bulkItemName:%@ bulkItemPrice:%@ bulkItemUnit:%@ bulkItemNum:%@ bulkItemVolume:%@ TAKEN:%@",model.bulkId,model.bulkName,model.priceSingle,model.priceUnit,model.bulkNum,@"1",bulkToken);
    
    
    //bulkVolume
    [networking AFNPOST:SETBULKITEMCART withparameters:@{@"TAKEN":bulkToken,@"bulkItemProductId":model.bulkId?model.bulkId:@"",@"bulkItemName":model.bulkName?model.bulkName:@"",@"bulkItemPrice":model.priceSingle?model.priceSingle:@"",@"bulkItemUnit":model.priceUnit?model.priceUnit:@"",@"bulkItemNum":textField.text.floatValue>0?textField.text:@"0",@"bulkItemVolume":model.bulkVolume?model.bulkVolume:@""} success:^(NSMutableDictionary *dic) {
        
        
    } error:nil HUDAddView:[UIApplication sharedApplication].keyWindow];
    
    
    
    
}

@end
