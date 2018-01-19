//
//  ZJRateController.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ChooseAssessVC.h"
#import "Masonry.h"
#import "ZJNetworkRequest.h"
#import "ZJPublicConfig.h"
#import "ZJRateModal.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "SKSelectionItemCell.h"
#import "YLProgressBar.h"
#import "SVProgressHUD.h"


@interface ChooseAssessVC ()<SKSTableViewDelegate,SKSelectionCellDelegate>
@property(nonatomic,strong)ZJRateModal     *data;
@property(nonatomic,strong)UIButton        *confirmButton;
@property(nonatomic,strong)SKSTableView    *tableView;
@property(nonatomic,strong)YLProgressBar   *progressBar;
@property(nonatomic,assign)NSInteger       tapCount;
@property(nonatomic,assign)NSInteger       totalCount;
@property(nonatomic,strong)NSMutableDictionary    *chooseValues;
@property(nonatomic,strong)NSMutableDictionary    *chooseOptionValues;
@property(nonatomic,strong)NSMutableArray         *dataHandle;


@property (nonatomic, strong) NSString *selectPrice;

@end

@implementation ChooseAssessVC

-(YLProgressBar *)progressBar{
    if (!_progressBar) {
        _progressBar = [[YLProgressBar alloc] initWithFrame:CGRectZero];
        _progressBar.type = YLProgressBarTypeFlat;
        _progressBar.stripesDirection = YLProgressBarStripesDirectionLeft;
        _progressBar.progressTintColor = ZJColor_main;
        _progressBar.stripesColor     = ZJColor_main;
        _progressBar.trackTintColor   = [UIColor whiteColor];
        _progressBar.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
       
    }
    
    return _progressBar;
}

-(SKSTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[SKSTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.SKSTableViewDelegate = self;
        _tableView.shouldExpandOnlyOneCell = true;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
        _confirmButton.backgroundColor = ZJColor_main;
        [_confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];

    }
    return _confirmButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
    [self setupData];
}

-(void)setupData{
    _data = [[ZJRateModal alloc] init];
    _tapCount = 0;
    _totalCount = 0;
    _chooseValues = [[NSMutableDictionary alloc] init];
    
    [ZJNetworkRequest getProductInfo:self.productID success:^(ModalProduct *modal) {
        Product *product = modal.lianjiuData.product;
        _data = [[ZJRateModal alloc] initWithString:product.productParamData];
        
        
        NSLog(@"product.productParamData:%@",product.productParamData);
        
        
        NSData *data = [product.productParamData dataUsingEncoding:NSUTF8StringEncoding];
        _dataHandle = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //计算总选项
        for (int i = 0 ; i<_data.headers.count-1;i++) {
            ZJRateHeader *header = _data.headers[i];
            _totalCount = _totalCount + header.rows.count;
        }
        
        
        //初始化多选数组
        ZJRateHeader *lastHeader = _data.headers.lastObject;
        _chooseOptionValues = [[NSMutableDictionary alloc] initWithCapacity:lastHeader.rows.count];
        for (ZJRateRow *row in lastHeader.rows) {
            _chooseOptionValues[row.rowName] = @false;
        }
    
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)setupViews{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = self.titleStr;
     [self.view addSubview:self.progressBar];
     [self.view addSubview:self.tableView];
     [self.view addSubview:self.confirmButton];
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
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.progressBar.mas_bottom).with.offset(8);
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
    
    return header.rows.count;
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
    ZJRateRow    *row    = header.rows[indexPath.row];
    
    SKSTableViewCell *cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    cell.detailTextLabel.font = FONT(12);
    
    //最后多选题
    if (indexPath.section == _data.headers.count-1) {
        cell.expandable = false;
        NSNumber *numberObj = _chooseOptionValues[row.rowName];
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
    
    cell.textLabel.font = FONT(14);
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text  = [NSString stringWithFormat:@" %ld.%@",(long)(indexPath.row+1),row.rowName];
    cell.detailTextLabel.text =_chooseValues[row.rowName];
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
    if (indexPath.section == _data.headers.count-1) {
        ZJRateHeader *header = (ZJRateHeader *)_data.headers[indexPath.section];
        ZJRateRow    *row    = header.rows[indexPath.row];
        NSNumber *numberObj =  _chooseOptionValues[row.rowName];
        SKSTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([numberObj boolValue]) {
            _chooseOptionValues[row.rowName] = @false;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.layer.borderWidth = 0;
        }else{
            _chooseOptionValues[row.rowName] = @true;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.layer.borderWidth = 1;
            cell.layer.borderColor = [ZJColor_main CGColor];
            cell.tintColor = ZJColor_main;
            

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
    if ([cell.detailTextLabel.text isEqualToString:@""] || cell.detailTextLabel.text == nil) {
        _tapCount = _tapCount + 1;
    }
    cell.detailTextLabel.text = value;
    //将所选的值保存在字典
    _chooseValues[row.rowName] = value;
    
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

    
    
    
    
    
    
    
    [_chooseOptionValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ => %@", key, obj);
        
        for (NSDictionary *dic in _dataHandle) {
            NSMutableArray *rows = [dic objectForKey:@"children"];
            
            for (int i = 0 ; i < rows.count ; i ++) {
                NSDictionary *rowDic = rows[i];
                NSString * rowName = [rowDic objectForKey:@"major"];
                NSNumber * numberObj = _chooseOptionValues[rowName];
                if ([[_chooseOptionValues allKeys] containsObject:rowName]) {
                    //未选择时 剔除
                    if (![numberObj boolValue]) {
                        
                        [rows removeObjectAtIndex:i];
                    }
                }
            }
            
        }
        
    }];
    
    [_chooseValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ => %@", key, obj);
        
        
        for (NSDictionary *dic in _dataHandle) {
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
    }];
    
    NSData *data =  [NSJSONSerialization dataWithJSONObject:_dataHandle options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *userID = [def objectForKey:@"userId"];
    
    NSLog(@"%@   _productID:%@  _productPrice%@",string,_productID,_productPrice);
    
    
    
    
    [networking AFNPOST:IMMEDIATELY withparameters:@{@"productParamData":string,@"productPrice":_productPrice,@"productId":_productID} success:^(NSMutableDictionary *dic) {
        
        NSLog(@"手机评估dic:%@",dic);
        
        
        
        EvaluateViewController *evc = [[EvaluateViewController alloc] init];
        //evc.isJiaDianOrPhone = @"phone";
      //  evc.orItemsParam = string;
        evc.tokenStr = dic[@"lianjiuData"]?dic[@"lianjiuData"]:@"";
      //  evc.productId = _productID;
        evc.titleStr = _titleStr;
        
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
