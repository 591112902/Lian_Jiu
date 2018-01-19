//
//  PhoneMaintainVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/21.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "PhoneMaintainVC.h"

#import "WeiXiuFirstVC.h"
#import "MJRefresh.h"



@interface PhoneMaintainVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation PhoneMaintainVC
{
    UICollectionView *_collectionView;
}


-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

//内容接口
- (void)addDatasourceIsDown:(BOOL)isDown
{
//    NSMutableDictionary *parameters = [self.parameters mutableCopy];
//    if (isDown) {
//        [parameters setObject:@1 forKey:@"pageNo"];
//    }
    [networking AFNRequest:PRODUCTREPAIR withparameters:nil success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            NSArray *response = dic[@"lianjiuData"];
            
            for (NSDictionary *temp in response) {
                PhoneMaintainModel *pModel = [PhoneMaintainModel ModelWith:temp];
                [self.dataSource addObject:pModel];
                
            }
//            if (isDown) {
//                [self.parameters setObject:@2 forKey:@"pageNo"];
//            }else{
//                NSInteger pageNo = [self.parameters[@"pageNo"] integerValue];
//                pageNo ++;
//                [self.parameters setObject:[NSNumber numberWithInteger:pageNo] forKey:@"pageNo"];
//            }
        }
         [_collectionView reloadData];
    } error:nil HUDAddView:self.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    flowLayout.itemSize = CGSizeMake((BOUND_WIDTH)/2-0.001, 180);
    flowLayout.sectionInset =UIEdgeInsetsMake(10, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3, 10, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3);

//    if (BOUND_WIDTH<=540) {
//        flowLayout.itemSize = CGSizeMake((BOUND_WIDTH)/2-0.001, 180);
//        flowLayout.sectionInset =UIEdgeInsetsMake(10, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3, 10, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3);
//    }else{
//        flowLayout.itemSize = CGSizeMake((BOUND_WIDTH)/2-0.001, 200);
//        NSInteger nub =floor(BOUND_WIDTH/200);
//        flowLayout.sectionInset =UIEdgeInsetsMake(10, (BOUND_WIDTH-200*nub)/(nub+1), 10, (BOUND_WIDTH-200*nub)/(nub+1));
//    }
    
    
    flowLayout.footerReferenceSize = CGSizeMake(BOUND_WIDTH, 250);
    
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT) collectionViewLayout:flowLayout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"PhoneMaintainCell" bundle:nil] forCellWithReuseIdentifier:@"PhoneMaintainCell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"PhoneMaintainFooterCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PhoneMaintainFooterCollectionReusableView"];
    
    //#warning  却少调用方法 cell
    //        -(void)fillCellWithModel:(bidModel*)model
    [self.view addSubview:_collectionView];
    
    
    [self addDatasourceIsDown:YES];
    
    
    
    
    
    
//    __weak UICollectionView *collectionView = _collectionView;
//    WS(weakSelf);
//    // 下拉刷新
//    collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf addDatasourceIsDown:YES];
//        // 结束刷新
//        [collectionView.header endRefreshing];
//    }];
//    //            [collectionView.header beginRefreshing];
//    
//    // 上拉刷新
//    collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf addDatasourceIsDown:NO];
//        // 结束刷新
//        [collectionView.footer endRefreshing];
//    }];
    // 默认先隐藏footer
    //            collectionView.footer.hidden = YES;

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhoneMaintainCell*  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhoneMaintainCell" forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor purpleColor];
    
    [cell fillCellWithModel:_dataSource[indexPath.row]];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionFooter) {
        PhoneMaintainFooterCollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PhoneMaintainFooterCollectionReusableView" forIndexPath:indexPath];
        
//        ItemGroup *group = self.itemGroups[indexPath.section];
//        headerView.title = group.type;
        
        return footView;
    }else {
        return nil;
    }
}






- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
      PhoneMaintainModel *model = _dataSource[indexPath.row];
    
    
    WeiXiuFirstVC *fvc = [[WeiXiuFirstVC alloc] init];
    
    fvc.title = model.categoryName;
    fvc.cid = [NSString stringWithFormat:@"%@",model.categoryId];
    [self.navigationController pushViewController:fvc animated:YES];
    
    
    
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *vip = [def objectForKey:@"vip"];
//    if ([model.usr_id isEqualToString:vip?vip:@""]||[model.t_bidstate_id isEqualToString:@"4"]) {
//        B_C_TReadOnlyViewController *bidContenVC = [[B_C_TReadOnlyViewController alloc] init];
//        bidContenVC.model = model;
//        bidContenVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:bidContenVC animated:YES];
//    }else{
//        B_C_TViewController *bidContenVC = [[B_C_TViewController alloc] init];
//        bidContenVC.model = model;
//        bidContenVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:bidContenVC animated:YES];
//    }
//    PRJTabBarViewController *tabar=(PRJTabBarViewController *)self.tabBarController;
//    UINavigationController *nav = tabar.viewControllers.lastObject;
//    MeVC *meVc = nav.viewControllers.firstObject;
//    meVc.isRequestData = YES;
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
