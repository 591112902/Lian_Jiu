//
//  SellScrapVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/8/24.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "JiaDanBtnSellScrapVC.h"
#import "MJRefresh.h"
#import "MainCollectionViewCell.h"
#import "ScrapListViewController.h"
#import "ScrapModel.h"

@interface JiaDanBtnSellScrapVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    
}
//@property (strong, nonatomic) NSMutableArray *dataSource;


@end

@implementation JiaDanBtnSellScrapVC
{
   // NSInteger pageNo;
   // BOOL isDown;
    NSMutableArray *_dataSour;
}



- (void)requestData{
    
//    if (isDown) {
//        pageNo = 1;
//    }
    
    
    [networking AFNRequest:PRODUCTWASTE withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"%@",dic);
        
        //        if (isDown) {
        //            [_dataSour removeAllObjects];
        //        }
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        NSArray *response = lianjiuData[@"wastes"];
        for (NSDictionary *temp in response) {
            ScrapModel *model = [ScrapModel ModelWith:temp ];
            [_dataSour addObject:model];
        }
        
        //        if (isDown) {
        //            pageNo = 2;
        //        }else{
        //            pageNo++;
        //        }
        
        [_collectionView reloadData];

        
    } error:nil HUDAddView:self.view];
    
    
    
    
   
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加单";
    
    self.view.backgroundColor = BGColor;
    UILabel *headL = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, BOUND_WIDTH, 40)];
    headL.font = PFR15Font;
    headL.text = @"上门回收暂时仅限深圳市和北京市。";
    headL.backgroundColor = BGColor;
    [self.view addSubview:headL];
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    if (BOUND_WIDTH<=540) {
        flowLayout.itemSize = CGSizeMake((BOUND_WIDTH-15)/2-0.001, 132);
        flowLayout.sectionInset =UIEdgeInsetsMake(0, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3, 5, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3);//上左下右
        flowLayout.minimumLineSpacing = 5;
        flowLayout. minimumInteritemSpacing = 5;
        
        
    }else{
        flowLayout.itemSize = CGSizeMake(200, 200);
        NSInteger nub =floor(BOUND_WIDTH/200);
        flowLayout.sectionInset =UIEdgeInsetsMake(10, (BOUND_WIDTH-200*nub)/(nub+1), 10, (BOUND_WIDTH-200*nub)/(nub+1));
    }
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40+64, BOUND_WIDTH, BOUND_HIGHT-TARBARHEIGHT-40-20) collectionViewLayout:flowLayout];
    
    
    
    
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    _collectionView.backgroundColor = BGColor;
    
    //#warning  却少调用方法 cell
    //        -(void)fillCellWithModel:(bidModel*)model
    [self.view addSubview:_collectionView];
    
    _dataSour = [[NSMutableArray alloc] init];
    
    [self requestData];
    
//    __weak UICollectionView *collectionView = _collectionView;
//    WS(weakSelf);
//    // 下拉刷新
//    collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // [weakSelf addDatasourceIsDown:YES];
//        // 结束刷新
//        [collectionView.header endRefreshing];
//    }];
//    // [collectionView.header beginRefreshing];
//    
//    // 上拉刷新
//    collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        // [weakSelf addDatasourceIsDown:NO];
//        // 结束刷新
//        [collectionView.footer endRefreshing];
//    }];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSour.count;//
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCollectionViewCell*  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    
    
    //cell.backgroundColor = [UIColor purpleColor];
    
    [cell fillCellWithModel:_dataSour[indexPath.row]];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScrapModel *model = _dataSour[indexPath.row];
    
    ScrapListViewController *scrapVC = [[ScrapListViewController alloc] init];
    
    scrapVC.categoryId = model.categoryId;
    
    scrapVC.jiadanS = @"jiadannext";
    
    scrapVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scrapVC animated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
