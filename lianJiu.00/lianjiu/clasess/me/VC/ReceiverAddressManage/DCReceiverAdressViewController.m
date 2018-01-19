//
//  DCReceiverAdressViewController.m
//  CDDMall
//
//  Created by apple on 2017/9/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCReceiverAdressViewController.h"

// Controllers

// Models
#import "DCAddressItem.h"
// Views
#import "DCReceiverAddressCell.h"
// Vendors
#import "MJExtension.h"

#import "AddNewAddressVC.h"




// Categories
//#import "UIBarButtonItem+DCBarButtonItem.h"
// Others


#define defaultTag 19990

@interface DCReceiverAdressViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 地址数组 */
@property (strong , nonatomic)NSMutableArray *addItem;


@property (nonatomic, assign) NSInteger btnTag;//默认选中的Tag


@end

static NSString *const DCReceiverAddressCellID = @"DCReceiverAddressCell";

@implementation DCReceiverAdressViewController

#pragma mark - LazyLoad
//- (UITableView *)tableView
//{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        
//        _tableView.frame = CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT - 64-44);
//        [self.view addSubview:_tableView];
//        
//        [_tableView registerClass:[DCReceiverAddressCell class] forCellReuseIdentifier:DCReceiverAddressCellID];
//    }
//    return _tableView;
//}

#pragma mark - LifeCyle

-(void)viewWillAppear:(BOOL)animated{
    
    
    [self setUpAdrressData];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isRequestData = YES;
    
    self.title = @"地址管理";
    [self setUpTab];
    
    UIButton *newAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newAddBtn.frame = CGRectMake(0, BOUND_HIGHT-44, BOUND_WIDTH, 44);
    newAddBtn.backgroundColor = MAINColor;
    [newAddBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [newAddBtn addTarget:self action:@selector(ToAddNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newAddBtn];
    
    
    
    
    
    __weak UITableView *tableView = _tableView;
    //下拉刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self setUpAdrressData];
        // 结束刷新
        [tableView.header endRefreshing];
    }];
    //[tableView.header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
    
    
    
    
   // self.btnTag = defaultTag;
}
-(void)ToAddNewAddress{
    AddNewAddressVC *avc = [[AddNewAddressVC alloc] init];
    avc.preVc = self;
    
    self.isRequestData = YES;
    
    [self.navigationController pushViewController:avc animated:YES];
    
}

- (void)setUpTab
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.frame = CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT - 64-44);
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[DCReceiverAddressCell class] forCellReuseIdentifier:DCReceiverAddressCellID];

    
    
    self.view.backgroundColor = BGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - 地址数据
- (void)setUpAdrressData
{//SELECTCARAROUSE
   // [NSString stringWithFormat:@"%@/%@/byUser",CHOOSEADRESS,@"LJ1505729539863"]
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    if (uid.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }

    _addItem = [[NSMutableArray alloc] init];
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    [manager GET:[NSString stringWithFormat:@"%@/%@/byUser",CHOOSEADRESS,uid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        
        
        NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        NSLog(@"dic:%@   _addItem%@     %@",dic,_addItem  ,[NSString stringWithFormat:@"%@/%@/byUser",CHOOSEADRESS,@"LJ1505729539863"]);

        [_addItem removeAllObjects];
        
        NSNumber *code=dic[@"status"];
        int c = [code intValue];
        if (c == 200) {
            
            if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
                NSArray *response = dic[@"lianjiuData"];
                
                for (NSDictionary *temp in response) {
                    DCAddressItem *model = [DCAddressItem ModelWith:temp ];
                    [_addItem addObject:model];
                }
                self.isRequestData = NO;
            }
            
        }else if (c == 501){
        
        }else{
             [MBProgressHUD showNotPhotoError:dic[@"msg"] toView:superView];
        }
        
         [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD showError:@"网络不给力" toView:superView];
        
    }];

    
    
    
    
    
    
    
    
//    [networking AFNRequest: [NSString stringWithFormat:@"%@/%@/byUser",CHOOSEADRESS,uid] withparameters:nil success:^(NSMutableDictionary *dic) {
//        
//        
//    } error:nil HUDAddView:self.view];
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCReceiverAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:DCReceiverAddressCellID forIndexPath:indexPath];
    
    
    DCAddressItem *model = _addItem[indexPath.row];
    
   // cell.adItem.isDefault;
    
    
    [cell fillCellWithModel:model];
    
    
    
    if (model.userDefault&&! self.btnTag) {
        
        self.btnTag = defaultTag+indexPath.row;
    }
    
    cell.defaultAddressButton.tag = defaultTag+indexPath.row;
    if (cell.defaultAddressButton.tag == self.btnTag) {
        cell.isSelect = YES;
        [cell.defaultAddressButton setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
        [cell.defaultAddressButton setTitle:@"默认地址" forState:UIControlStateNormal];
        [cell.defaultAddressButton setTitleColor:MAINColor forState:UIControlStateNormal];

    }else{
        cell.isSelect = NO;
        [cell.defaultAddressButton setImage:[UIImage imageNamed:@"unSelect_btn"] forState:UIControlStateNormal];
        [cell.defaultAddressButton setTitle:@"设为默认" forState:UIControlStateNormal];
        [cell.defaultAddressButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }

    
    
    
#pragma mark-在这里跳转下一页.点击了默认地址
    __weak DCReceiverAddressCell *weakCell = cell;
    [cell setDSelectBlock:^(BOOL choice,NSInteger btnTag){
        
        
        [networking AFNPOST:[NSString stringWithFormat:@"%@/%@/%@",SETDEFAULT,model.userAddressId,model.userId] withparameters:nil success:^(NSMutableDictionary *dic) {
            NSLog(@"%@  %@",dic,[NSString stringWithFormat:@"%@/%@/%@",SETDEFAULT,model.userAddressId,model.userId]);
            
            
            [weakCell.defaultAddressButton setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
            [weakCell.defaultAddressButton setTitle:@"默认地址" forState:UIControlStateNormal];
            [weakCell.defaultAddressButton setTitleColor:MAINColor forState:UIControlStateNormal];

            
            self.btnTag = btnTag;
            [self.tableView reloadData];

        
            
        } error:^(NSError *error) {
        } HUDAddView: [UIApplication sharedApplication].keyWindow];

        
        
        
        
//        if (choice) {
//            [weakCell.defaultAddressButton setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
//            self.btnTag = btnTag;
//            NSLog(@"$$$$$$%ld",(long)btnTag);
//            
//            [self.tableView reloadData];
//        
//        }else{
//            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
//            [weakCell.defaultAddressButton setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
//            self.btnTag = btnTag;
//            [self.tableView reloadData];
//            NSLog(@"#####%ld",(long)btnTag);
//        }
        
        
        
    }];

    

    
    
    
    
    
    
    //弃用了::::
    cell.delectClickBlock = ^{
        NSLog(@"点击了删除");
    };
    
    
    cell.editClickBlock = ^{
        NSLog(@"点击了编辑");
        AddNewAddressVC *editN = [[AddNewAddressVC alloc] init];
        editN.isEdit = @"isEdit";
        editN.addressEditModel = model;
         editN.preVc = self;
         self.isRequestData = YES;
        [self.navigationController pushViewController:editN animated:YES];
        
        
    };
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row:%zd",indexPath.row);
    
    DCAddressItem *model = _addItem[indexPath.row];
    
    __weak DCReceiverAdressViewController *weakSelf = self;
    if (weakSelf.returnAddBlcok) {
        weakSelf.returnAddBlcok(model);
    }

//    if (self.isNotJieSuan) {
//        if (weakSelf.returnAddBlcok) {
//            weakSelf.returnAddBlcok(model);
//        }
//        
//    }
    
    
 
    
    
    
    if ([_delegate respondsToSelector:@selector(requestSelectAddress:)]) { // 如果协议响应了sendValue:方法
        [_delegate requestSelectAddress:model]; // 通知执行协议方法
    }
    
    //MeVC* oneVC =nil;
    for(UIViewController* VC in self.navigationController.viewControllers){
        if([VC isKindOfClass:[MeVC class]]){
            return;
            //            oneVC =(DCReceiverAdressViewController*) VC;
            //            [self.navigationController popToViewController:oneVC animated:YES];
        }
    }

    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCAddressItem *model = _addItem[indexPath.row];
    
    return model.cellHeight;
}

//#pragma mark - 点击事件
//#pragma mark - 添加地址
//- (void)addItemClick
//{
//    
//}

@end
