//
//  ZJRateController.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ChooseConditionVC.h"
#import "Masonry.h"
#import "ZJNetworkRequest.h"
#import "ZJPublicConfig.h"
#import "ZJRateModal.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "SKSelectionItemCell.h"
#import "YLProgressBar.h"
#import "SVProgressHUD.h"


// 测试ßß

@interface ChooseConditionVC ()<SKSTableViewDelegate,SKSelectionCellDelegate>
@property(nonatomic,strong)ZJRateModal     *data;
@property(nonatomic,strong)UIButton        *confirmButton;
@property(nonatomic,strong)SKSTableView    *tableView;
@property(nonatomic,strong)YLProgressBar   *progressBar;
@property(nonatomic,assign)NSInteger       tapCount;
@property(nonatomic,assign)NSInteger       totalCount;
@property(nonatomic,strong)NSMutableDictionary    *chooseValues;
@property(nonatomic,strong)NSMutableDictionary    *chooseOptionValues;
@property(nonatomic,strong)NSMutableArray         *dataHandle;

@property (nonatomic, strong) UIView *tipsView;

// 判断是否多选
@property (nonatomic, strong) NSString *isParent;


@property (nonatomic, strong) NSMutableArray *moreArr;

// 控制按钮颜色
@property (nonatomic, assign) BOOL isLast;


@end

@implementation ChooseConditionVC


- (NSMutableArray *)moreArr{
    if (!_moreArr) {
        _moreArr = [[NSMutableArray alloc] init];
    }
    return _moreArr;
}


-(YLProgressBar *)progressBar{
    if (!_progressBar) {
        _progressBar = [[YLProgressBar alloc] initWithFrame:CGRectZero];
        _progressBar.type = YLProgressBarTypeFlat;
        _progressBar.stripesDirection = YLProgressBarStripesDirectionLeft;
        _progressBar.progressTintColor = ZJColor_main;
        _progressBar.stripesColor     = ZJColor_main;
        _progressBar.trackTintColor   = [UIColor groupTableViewBackgroundColor];
        _progressBar.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeFixedRight;
        _progressBar.indicatorTextLabel.textColor = [UIColor blackColor];
        
    }
    
    return _progressBar;
}

-(SKSTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[SKSTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.SKSTableViewDelegate = self;
        _tableView.shouldExpandOnlyOneCell = true;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        [_tableView registerClass:[SKSelectionItemCell class] forCellReuseIdentifier:@"SKSelectionItemCell"];
    }
    return _tableView;
}

-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.titleLabel.font = FONT(15);
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitle:@"马上估价" forState:UIControlStateNormal];
        _confirmButton.backgroundColor = [UIColor colorWithRed:233.0000/255.0000 green:233.0000/255.0000 blue:233.0000/255.0000 alpha:1];
        if (self.isLast) {
            _confirmButton.backgroundColor = ZJColor_main;
        } else {
            _confirmButton.backgroundColor = [UIColor lightGrayColor];
        }
        
        [_confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmButton;
}


- (UIView *)tipsView{
    if (!_tipsView) {
        _tipsView = [[UIView alloc] initWithFrame:CGRectZero];
        
       
        if (self.isPhoneNotJD) {
            UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.bounds.size.width - 20, 30)];
            [_tipsView addSubview:tipsLabel];
            tipsLabel.textColor = [UIColor lightGrayColor];
            tipsLabel.font = [UIFont systemFontOfSize:13];
            tipsLabel.textAlignment = NSTextAlignmentLeft;
            tipsLabel.text = @"提示：如何快速又安全的清除手机数据";
            UIImageView *tipsImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 20, 10, 7, 10)];
            tipsImg.image = [UIImage imageNamed:@"jiantou"];
            [_tipsView addSubview:tipsImg];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipsAction:)];
            [_tipsView addGestureRecognizer:tap];

        }
    }
    return _tipsView;
}

- (void)tipsAction:(UITapGestureRecognizer *)tap{
    //提示框
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"安卓手机数据清除\n(1）删除手机相关账号及密码，如开机密码，账户信息，支付密码...\n(2）恢复出厂设置，确定清除系统缓存与数据。打开手机功能表-设置-安全隐私-恢复出厂设置。个别手机不同的情况下，也不排除恢复出厂设置被放置其他的目录下。\n(3）检查是否还留有信息的同时，并检查和取出手机中的内存卡及SIM卡\n(4）存入无关紧要的文件将硬盘空间占满，反复覆盖硬盘上的数据，数据恢复只能恢复最上层的数据，所以，即便信息被恢复，也不会影响到个人隐私。（链旧在回收手机后会高频重复以上操作，确保您的的信息安全。）\n苹果手机数据清除\n（1）加密和数据保护\n iPhone上所存储的每个文件都有单独随机生成的密钥进行加密。经过多层加密之后，文件才得以安全地存储在iPhone的磁盘上。\n（2）抹掉所有内容和设置\n用户抹掉数据以及所有设置之后，就等于抹掉了所有文件的密钥。如果要想恢复数据，就需要破解逐层加密。删除手机iCloud账号及密码，并恢复出厂设置，确保去除手机SIM" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [clear addAction:queRen];
    [self presentViewController:clear animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
    [self setupData];
    
    self.isLast = NO;
}

-(void)setupData{
    _data = [[ZJRateModal alloc] init];
    _tapCount = 0;
    _totalCount = 0;
    _chooseValues = [[NSMutableDictionary alloc] init];
    //1513754926595-b7afe450-69a0-4956-8460-3e247a3a3e99
    [ZJNetworkRequest getProductInfo:self.productID success:^(ModalProduct *modal) {
        
        Product *product = modal.lianjiuData.product;
        _data = [[ZJRateModal alloc] initWithString:product.productParamData?product.productParamData:@""];
        
        _productPrice = product.productPrice;
        NSLog(@"product.productParamData:%@",product.productParamData);
        
        
        NSData *data = [product.productParamData?product.productParamData:@"" dataUsingEncoding:NSUTF8StringEncoding];
        _dataHandle = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (_dataHandle.count==0) {
            return ;
        }
        
        
        
        NSDictionary *dic = _dataHandle[_dataHandle.count - 1];
        self.isParent = [dic objectForKey:@"retrieveType"];
        NSLog(@"+++++++++++++++++%@", self.isParent);
        
        if ([self.isParent integerValue] == 0) {
            
            NSDictionary *dic = [_dataHandle lastObject];
            NSArray *arr = dic[@"children"];
            NSDictionary *subDic = [arr lastObject];
            NSArray *subArr = subDic[@"children"];
            
            NSLog(@"subArr = %@", subArr);
            
            self.moreArr = [subArr copy];
            
            //计算总选项
            for (int i = 0 ; i<_data.headers.count-1;i++) {
                ZJRateHeader *header = _data.headers[i];
                _totalCount = _totalCount + header.rows.count;
            }
            
        } else {
            
            //计算总选项
            for (int i = 0 ; i<_data.headers.count;i++) {
                ZJRateHeader *header = _data.headers[i];
                _totalCount = _totalCount + header.rows.count;
                
            }
            
        }
        
        
        
        //初始化多选数组
        ZJRateHeader *lastHeader = _data.headers.lastObject;
        ZJRateRow *rows = lastHeader.rows[0];
        _chooseOptionValues = [[NSMutableDictionary alloc] initWithCapacity:rows.values.count];
        for (ZJRateValue *value in rows.values) {
            _chooseOptionValues[value.value] = @false;
        }
        
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)setupViews{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    [self.view addSubview:self.progressBar];
    [self.view addSubview:self.tipsView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmButton];
    self.confirmButton.enabled = NO;
    [self.progressBar setProgress:0.0f animated:false];
    
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setBackgroundColor:[UIColor lightTextColor]];
    
}

-(void)setupConstraints{
    
    [_progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing);
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.view.mas_top).offset(64+8);
        make.height.equalTo(@(15*ZJ_SCREEN_HEIGHT_SCALE));
    }];
    
    [_tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing);
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.progressBar.mas_bottom);
        make.height.equalTo(@(30*ZJ_SCREEN_HEIGHT_SCALE));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.tipsView.mas_bottom).with.offset(8);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.confirmButton.mas_top);
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing);
        make.leading.equalTo(self.view.mas_leading);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@(47*ZJ_SCREEN_HEIGHT_SCALE));
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.headers.count;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    ZJRateHeader *header = (ZJRateHeader *)_data.headers[section];
    if ([header.headerName containsString:@"多选"]) {
        ZJRateRow *rows = header.rows[0];
        return rows.values.count;
    } else {
        return header.rows.count;
    }
    //    if (header.rows.count > 1) {
    //        return header.rows.count;
    //    } else {
    //        if ([_isParent boolValue]) {
    //            return header.rows.count;
    //        }
    //        ZJRateRow *rows = header.rows[0];
    //        return rows.values.count;
    //    }
    
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 1;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44*ZJ_SCREEN_HEIGHT_SCALE;
}

-(CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZJRateHeader *header = (ZJRateHeader *)_data.headers[indexPath.section];
    ZJRateRow    *row    = header.rows[indexPath.row];
    NSInteger dela = ceil((float)(row.values.count)/2)-1;
    
    return (dela+1)*ZJ_RATEBUTTON_HEIGHT+8*2+dela*8;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    
    return false;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    ZJRateHeader *header = (ZJRateHeader *)_data.headers[indexPath.section];
    ZJRateRow    *row;
    
    if ([header.headerName containsString:@"多选"]) {
        row = header.rows[0];
    } else {
        row = header.rows[indexPath.row];
    }
    //    if (header.rows.count>1) {
    //        row = header.rows[indexPath.row];
    //    } else {
    //        if ([_isParent boolValue]) {
    //            row = header.rows[indexPath.row];
    //        }
    //        row = header.rows[0];
    //    }
    
    
    SKSTableViewCell *cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    cell.detailTextLabel.font = FONT(12);
    
    
    if ([self.isParent integerValue] == 0) {
        
        
        cell.expandable = true;
        //最后多选题
        if (indexPath.section == _data.headers.count-1) {
            cell.expandable = false;
            ZJRateValue *value = row.values[indexPath.row];
            NSNumber *numberObj = _chooseOptionValues[value.value];
            if ([numberObj boolValue]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.layer.borderWidth = 1;
                cell.layer.borderColor = [ZJColor_main CGColor];
                cell.tintColor = ZJColor_main;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.layer.borderWidth = 0;
            }
            
        } else{
            cell.expandable = true;
        }
        
    } else {
        cell.expandable = true;
        
    }
    
    
    
    
    cell.textLabel.font = FONT(14);
    cell.textLabel.textColor = [UIColor grayColor];
    if (![header.headerName containsString:@"多选"]) {
        cell.textLabel.text  = [NSString stringWithFormat:@" %ld.%@",(long)(indexPath.row+1),row.rowName];
        cell.detailTextLabel.text =_chooseValues[row.rowName];
    } else {
        ZJRateValue *value = row.values[indexPath.row];
        cell.textLabel.text  = [NSString stringWithFormat:@" %ld.%@",(long)(indexPath.row+1),value.value];
        cell.detailTextLabel.text =_chooseValues[value.value];
    }
    
    
    return cell;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath realIndexPath:(NSIndexPath *)realIndexPath
{
    static NSString *CellIdentifier = @"SKSelectionItemCell";
    
    SKSelectionItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate        = self;
    cell.indexPath       = [NSIndexPath indexPathForRow:realIndexPath.row-1 inSection:realIndexPath.section];
    
    ZJRateHeader *header = (ZJRateHeader *)_data.headers[indexPath.section];
    ZJRateRow    *row    = (ZJRateRow *)header.rows[indexPath.row];
    cell.row = row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZJRateHeader *header = (ZJRateHeader *)_data.headers[section];
    UIView      *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel     *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    label.font = FONT(14);
    label.textColor = [UIColor blackColor];
    label.text  = header.headerName;
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    return view;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == [[_data.headers lastObject] integerValue]) {
    //        if (indexPath.row == [[[_data.headers lastObject]  lastObject] integerValue]) {
    //            self.isLast = YES;
    //        }
    //    }
    
    
    if ([self.isParent integerValue] == 0) {
        if (indexPath.section == _data.headers.count-1) {
            ZJRateHeader *header = (ZJRateHeader *)_data.headers[indexPath.section];
            ZJRateRow    *row    = header.rows[0];
            ZJRateValue *value = row.values[indexPath.row];
            NSNumber *numberObj =  _chooseOptionValues[value.value];
            SKSTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if ([numberObj boolValue]) {
                _chooseOptionValues[value.value] = @false;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.layer.borderWidth = 0;
            }else{
                _chooseOptionValues[value.value] = @true;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.layer.borderWidth = 1;
                cell.layer.borderColor = [ZJColor_main CGColor];
                cell.tintColor = ZJColor_main;
                
            }
        }
    }
}


- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
}

#pragma mark - SKSelectionCellDelegate
-(void)didSelected:(ZJRateRow *)row value:(NSString *)value indexPath:(NSIndexPath *)indexPath{
    
    SKSTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    //    if ([cell.detailTextLabel.text isEqualToString:@""] || cell.detailTextLabel.text == nil) {
    //        _tapCount = _tapCount + 1;
    //    }
    
    if (![[_chooseValues allKeys] containsObject:row.rowName]) {
        _tapCount = _tapCount + 1;
    }
    
    cell.detailTextLabel.text = value;
    //将所选的值保存在字典
    _chooseValues[row.rowName] = value;
    
    if(_chooseValues.count == _totalCount) {
        self.isLast = YES;
        self.confirmButton.enabled = YES;
        self.confirmButton.backgroundColor = ZJColor_main;
    }
    
    [_tableView collapseCellForIndexPath:indexPath];
    
    [_progressBar setProgress:(float)_tapCount/(float)(_totalCount) animated:true];
    
}

#pragma mark - 开始估价
-(void)confirmButtonPressed{
    
    NSLog(@"_dataHandle_dataHandle:%@",_dataHandle);
    
    if (_tapCount != _totalCount) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"请填写完整再进行估价。"]];
        return;
    }
    
    
    
    //NSMutableArray *tempData = [_dataHandle mutableCopy];
    
    //NSArray *tempData = [_dataHandle copy];
    for (NSDictionary *dic in _dataHandle) {
        NSArray *rows = [dic objectForKey:@"children"];
        
        for (NSDictionary *rowDic in rows) {
            NSString * rowName = [rowDic objectForKey:@"major"];
            
            //排除多选
            if (![[_chooseOptionValues allKeys] containsObject:rowName] && [[_chooseValues allKeys] containsObject:rowName]) {
                NSString *valueString = _chooseValues[rowName];
                NSMutableArray *values = [rowDic objectForKey:@"children"];
                
                for (int i = 0 ; i < values.count ; i ++) {
                    NSDictionary *valueDic = values[i];
                    
                    NSString *value  = [valueDic objectForKey:@"major"];
                    //如果不等于所选值
                    if (![value isEqualToString:valueString]) {
                        [values removeObjectAtIndex:i];
                        
                        //                        NSDictionary *avalueDic = values[i];
                        //                        NSString *avalue  = [avalueDic objectForKey:@"major"];
                        //                        NSLog(@"remove->%@----%ld",avalue,values.count);
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
    //增加判断：判断是否有多选项，没有的话不做删除操作
    if ([self.isParent integerValue] == 0) {
        [_chooseOptionValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ => %@", key, obj);
            
            for (NSDictionary *dic in _dataHandle) {
                if ([[dic objectForKey:@"major"] containsString:@"可多选"]) {
                    NSMutableArray *rows = [dic objectForKey:@"children"];
                    NSMutableArray *values = [rows[0] objectForKey:@"children"];
                    for (int i = 0 ; i < values.count ; i ++) {
                        NSDictionary *value = values[i];
                        NSString * rowName = [value objectForKey:@"major"];
                        NSNumber * numberObj = _chooseOptionValues[rowName];
                        if ([[_chooseOptionValues allKeys] containsObject:rowName]) {
                            //未选择时 剔除
                            if (![numberObj boolValue]) {
                                [values removeObjectAtIndex:i];
                            }
                        }
                        
                    }
                }
                
            }
            
        }];
    }
    
    
    //增加删除操作：判断数据（除多选外的数据）是否被选中，剔除未选中项
    [_chooseValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ => %@", key, obj);
        
        
        for (NSDictionary *dic in _dataHandle) {
            if (![[dic objectForKey:@"major"] containsString:@"可多选"]) {
                NSMutableArray *rows = [dic objectForKey:@"children"];
                
                for (int i = 0 ; i < rows.count ; i ++) {
                    NSDictionary *rowDic = rows[i];
                    NSMutableArray *secondRows = rowDic[@"children"];
                    NSMutableArray *removeArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in secondRows) {
                        NSString * rowName = [dict objectForKey:@"major"];
                        if (![[_chooseValues allValues] containsObject:rowName]) {
                            //未选择时 剔除
                            [removeArray addObject:dict];
                        }
                    }
                    [secondRows removeObjectsInArray:removeArray];
                }
            }
        }
    }];
    
    NSData *data =  [NSJSONSerialization dataWithJSONObject:_dataHandle options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    
    
    
    
    
    
    
    //    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    NSString *userID = [def objectForKey:@"userId"];
    //
    NSLog(@"%@   _productID:%@  _productPrice%@",string,_productID,_productPrice);
    
    
    NSString *url;
    if (_isPhoneNotJD) {//手机
        url = IMMEDIATELY;
        
    }else{//家电
        url = JDIMMEDIATELY;
    }
    
    
    
    
    [networking AFNPOST:url withparameters:@{@"productParamData":string,@"productPrice":_productPrice,@"productId":_productID} success:^(NSMutableDictionary *dic) {
        NSLog(@"家电评估dic:%@",dic);
        
        EvaluateViewController *evc = [[EvaluateViewController alloc] init];
        // evc.orItemsParam = string;
        evc.tokenStr = dic[@"lianjiuData"]?dic[@"lianjiuData"]:@"";
        // evc.picture = _productMasterPicture;
        // evc.priceS = _productPrice;
        // evc.productId = _productID;
        evc.titleStr = _titleStr;
        
        if (self.isPhoneNotJD) {
            evc.isPhoneNotJD = YES;
        } else {
            evc.isPhoneNotJD = NO;
        }
        
        [self.navigationController pushViewController:evc animated:YES];
        
        
    } error:nil HUDAddView:self.view];
    
    
    
}

#pragma mark - Helpers

-(void)removeNotSelectedItems:(NSString *)rowName value:(NSString *)value formArray:(NSMutableArray *)fromArray{
    
    NSMutableArray *tempArray = [fromArray mutableCopy];
    
    
    //  NSLog(@"tempArray:%@",tempArray);
    
    for (NSDictionary *dic in tempArray) {
        NSArray *rows = [dic objectForKey:@"children"];
        
        for (NSDictionary *rowDic in rows) {
            NSString * rowNameStr = [rowDic objectForKey:@"major"];
            
            //排除多选
            if ([rowNameStr isEqualToString:rowName]) {
                NSString *valueString = _chooseValues[rowNameStr];
                NSMutableArray *values = [rowDic objectForKey:@"children"];
                for (int i = 0 ; i < values.count ; i ++) {
                    NSDictionary *valueDic = values[i];
                    
                    NSString *value  = [valueDic objectForKey:@"major"];
                    //如果不等于所选值
                    if (![value isEqualToString:valueString]) {
                        [values removeObjectAtIndex:i];
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

@end
