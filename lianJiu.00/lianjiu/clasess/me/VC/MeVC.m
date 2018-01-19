//
//  ViewController.m
//  demo
//
//  Created by zhong on 17/1/16.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import "MeVC.h"
#import "ItemCell.h"
#import "ItemCellHeaderView.h"
#import "ItemGroup.h"
#import "MeHeadView.h"
#import "GoodsOrderViewController.h"
#import "PhoneMaintainVC.h"
#import "DCReceiverAdressViewController.h"
#import "HotActivityVC.h"
#import "CouponVC.h"
#import "CreditViewController.h"

#import "CallBackCarViewController.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];

static NSString *reuseID = @"itemCell";
static NSString *sectionHeaderID = @"sectionHeader";

@interface MeVC ()<UICollectionViewDelegate, UICollectionViewDataSource> {
   // NSIndexPath *_originalIndexPath;
   // NSIndexPath *_moveIndexPath;
   // UIView *_snapshotView;
    MeHeadView* _headerView;
    UIScrollView *_scrollV;
    CGFloat _scrollVH;
    
  //  BOOL isSetUpMiMa;
    
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *itemGroups;
@property (nonatomic, strong) NSArray *allItemModel;
//@property (nonatomic, assign) BOOL isEditing;
@end

@implementation MeVC

//- (void)setIsEditing:(BOOL)isEditing {
//    _isEditing = isEditing;
//    UIBarButtonItem *managerItem = self.navigationItem.rightBarButtonItem;
//    UIButton *managerButton = managerItem.customView;
//    managerButton.selected = isEditing;
//}

- (NSArray *)itemGroups {
    if (!_itemGroups) {
        
        NSArray *datas = @[
                          @{
                               @"type" : @"订单中心",
                               @"items" : @[@{@"imageName" : @"Recyclingme",@"itemTitle" : @"快递回收"},
                                            @{@"imageName" : @"-door",@"itemTitle" : @"上门回收"},
                                            @{@"imageName" : @"Fine",@"itemTitle" : @"恋旧优品"},
                                            @{@"imageName" : @"Quick-fix",@"itemTitle" : @"手机快修"},@{@"imageName" : @"dazongyl",@"itemTitle" : @"大宗交易"},
                                            @{@"imageName" : @"Recycling-the-carme",@"itemTitle" : @"回收车"},]
                             },
                           @{
                               @"type":@"必备工具",
                               @"items" : @[@{@"imageName" : @"guide",@"itemTitle" : @"帮助中心"},
                                            @{@"imageName" : @"Popular",@"itemTitle" : @"热门活动"},
                                            @{@"imageName" : @"coupon",@"itemTitle" : @"优惠劵"},
                                            @{@"imageName" : @"address",@"itemTitle" : @"地址管理"},
                                            @{@"imageName" : @"Environmental-protection",@"itemTitle" : @"环保称号"},
                                            @{@"imageName" : @"Customer-service",@"itemTitle" : @"联系客服"},
                                            ]
                               },
                            ];//@{@"imageName" : @"Valuation",@"itemTitle" : @"本机估价"},
        
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:datas.count];
        NSMutableArray *allItemModels = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in datas) {
            ItemGroup *group = [[ItemGroup alloc] initWithDict:dict];
            if ([group.type isEqualToString:@"首页快捷入口"]) {
                for (ItemModel *model in group.items) {
                    model.status = StatusMinusSign;
                }
            }else {
                [allItemModels addObjectsFromArray:group.items];
            }
            [array addObject:group];
        }
        _itemGroups = [array copy];
        _allItemModel = [allItemModels copy];
    }
    
    return _itemGroups;
}
-(void)setUpAction{
    
    
    
    SetUpViewController *svc = [[SetUpViewController alloc] init];
    
    if ( [self.userModel.isPwd isEqualToString:@"0"]) {
        svc.isSetUpMiMa = NO;;
    }else if ( [self.userModel.isPwd isEqualToString:@"1"]) {
        svc.isSetUpMiMa = YES;
    }else {
        svc.isSetUpMiMa = NO;
    }
    

    
    
    svc.phoneStr = self.userModel.userPhone;
    
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isRequestData = YES;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(setUpAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 22, 20)];//59 67
    // 使用自定义的按钮初始化一个导航条按钮
    UIBarButtonItem* rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    // 使用数组给导航条添加多个控件
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
    
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
   // [self setupNavigationBar];
    [self setupCollectionView];
    
    
    
    
    
    
    // 判断用户是否设置了密码
    
 //   isSetUpMiMa = YES;
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *username = [def objectForKey:@"username"];
//    [networking AFNPOSTNotCode:[NSString stringWithFormat:@"%@/%@/username=126",ISPWD,username] withparameters:nil success:^(NSMutableDictionary *dic) {
//        NSLog(@"ISPWD%@",dic);
//        NSNumber *status = dic[@"status"];
//        if ([status isEqualToNumber:@200]) {
//            isSetUpMiMa = YES;
//        }else if ([status isEqualToNumber:@400]){
//            //没有设置密码=调到设置密码页面
//            isSetUpMiMa = NO;
//        }else{
//            isSetUpMiMa = YES;//这里假设默认设置过密码
//        }
//        
//        
//    } error:^(NSError *error) {
//        isSetUpMiMa = YES;
//    } HUDAddView:self.view];
//
}

//- (void)setupNavigationBar {
//    self.navigationItem.title = @"全部";
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [button setTitle:@"管理" forState:UIControlStateNormal];
//    [button setTitle:@"完成" forState:UIControlStateSelected];
//    [button sizeToFit];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(managerAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *managerItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = managerItem;
//    
//}

//- (void)managerAction:(UIButton *)managerButton {
//    managerButton.selected = !managerButton.selected;
//    self.isEditing = managerButton.selected;
//    [self.collectionView reloadData];
//}
-(void)payButtonAction{
    LianjiuMoneyVC *lvc = [[LianjiuMoneyVC alloc] init];
    lvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:lvc animated:YES];
    
}
- (void)setupCollectionView {
    _scrollVH = 0;
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    
    
    
    _headerView = [[[NSBundle mainBundle]loadNibNamed:@"MeHeadView" owner:nil options:nil]lastObject];
    _headerView.frame = CGRectMake(0, _scrollVH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*154);
    _headerView.payButton.layer.cornerRadius = 5;
    _headerView.payButton.layer.borderColor = MAINColor.CGColor;
    _headerView.payButton.layer.borderWidth = 1;
    [_headerView.payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollV addSubview:_headerView];
    
    _scrollVH += [UIScreen mainScreen].bounds.size.width/320.0*154;
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth / 4, kScreenWidth / 4);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _scrollVH, [UIScreen mainScreen].bounds.size.width, kScreenHeight-[UIScreen mainScreen].bounds.size.width/320.0*154) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_scrollV addSubview:_collectionView];
    [_collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:reuseID];
    [_collectionView registerClass:[ItemCellHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeaderID];
    
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, kScreenHeight+50+64+30);
    
}


#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.itemGroups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ItemGroup *group = self.itemGroups[section];
    return group.items.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
   // cell.delegate = self;
//    cell.backgroundColor = kRandomColor;
    ItemGroup *group = self.itemGroups[indexPath.section];
   // ItemModel *itemModel = group.items[indexPath.row];
//    if (indexPath.section != 0) {
//        BOOL isAdded = NO;
//        ItemGroup *homeGroup = self.itemGroups[0];
//        for (ItemModel *homeItemModel in homeGroup.items) {
//            
//            if ([homeItemModel.itemTitle isEqualToString:itemModel.itemTitle]) {
//                isAdded = YES;
//                break;
//            }
//        }
//        
//        if (isAdded) {
//            itemModel.status = StatusCheck;
//        }else {
//            itemModel.status = StatusPlusSign;
//        }
//    }
   // cell.isEditing = _isEditing;
    cell.itemModel = group.items[indexPath.row];
    cell.indexPath = indexPath;
    
    
    
//    //在UICollectionView上面添加分割线
//    CGSize contentSize = self.collectionView.contentSize;
//    UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, (20 + cell.frame.size.height) * indexPath.row , contentSize.width, 1)];//每一个cell的framee是 17.00, 10.00, 160.00, 160.00  ,
//    NSLog(@"%ld, =>  %.2f, %.2f, %.2f, %.2f, ", indexPath.row, horizontalLine.frame.origin.x, horizontalLine.frame.origin.y, horizontalLine.frame.size.width, horizontalLine.frame.size.height);
//    horizontalLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    horizontalLine.alpha = 0.35;
//    [self.collectionView addSubview:horizontalLine];
    
    
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        ItemCellHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeaderID forIndexPath:indexPath];
        
        ItemGroup *group = self.itemGroups[indexPath.section];
        headerView.title = group.type;

        return headerView;
    }else {
        return nil;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }else {
        return UIEdgeInsetsMake(0, 0, 1 / [UIScreen mainScreen].scale, 0);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath.section:%zd    indexPath.row:%zd",indexPath.section,indexPath.row);
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //快递回收
            KuaiDiOrderViewController *uvc = [[KuaiDiOrderViewController alloc] init];
            uvc.title = @"快递回收";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];

            
        }else if (indexPath.row == 1){
            //上门回收
            ShangMenOrderViewController *uvc = [[ShangMenOrderViewController alloc] init];
            uvc.title = @"上门回收";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];

        }else if (indexPath.row == 2){
            //二手精品
            GoodsOrderViewController *uvc = [[GoodsOrderViewController alloc] init];
            uvc.title = @"优品订单";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
            
        }else if (indexPath.row == 3){
            //手机快修
            WeiOrderViewController *uvc = [[WeiOrderViewController alloc] init];
            uvc.title = @"手机快修";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
//            UIViewController *v = [UIViewController new];
//            UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:v];
//            [v.view addSubview:[self test2]];
//            [self showViewController:nv sender:nil];
           
        }else if (indexPath.row == 4){
            //大宗回收
            DaZongOrderViewController *uvc = [[DaZongOrderViewController alloc] init];
            uvc.title = @"大宗交易";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
            
        }else if (indexPath.row == 5){
            //回收车
            CallBackCarViewController *uvc = [[CallBackCarViewController alloc] init];
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
            
        }
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //帮助中心
            HelpCenterVC *uvc = [[HelpCenterVC alloc] init];
            uvc.title = @"帮助中心";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];

            
        }else if (indexPath.row == 1){
            //热门活动
            HotActivityVC *uvc = [[HotActivityVC alloc] init];
            uvc.title = @"热门活动";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];
        }else if (indexPath.row == 2){
            //优惠劵
            CouponVC *uvc = [[CouponVC alloc] init];
            uvc.title = @"优惠劵";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];

        }else if (indexPath.row == 3){
            //地址管理
            DCReceiverAdressViewController *uvc = [[DCReceiverAdressViewController alloc] init];
            uvc.title = @"地址管理";
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];

        }else if (indexPath.row == 4){
            //环保称号
            CreditViewController *uvc = [[CreditViewController alloc] init];
            uvc.title = @"环保称号";
            uvc.userModel = _userModel;
            self.isRequestData = YES;
            uvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uvc animated:YES];

        }else if (indexPath.row == 5){
            //联系客服
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001818209"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];

            
        }else if (indexPath.row == 6){
            //本机估价
//            DeatailsViewController *dvc = [[DeatailsViewController alloc] init];
//            dvc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:dvc animated:YES];
 
            

        }

        
    }
    
    
//    static BOOL hiden = NO;
//    hiden = !hiden;
//    [self setNavBarHidden:hiden];
}


//- (HYPageView *)test2 {
//    
//    
//    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT) withTitles:@[@"待维修",@"上门中",@"已维修"] withViewControllers:@[@"WaitDoorViewController",@"HaveDoorViewController",@"YiWeiXiuViewController"] withParameters:nil];
//    pageView.selectedColor = MAINColor;
//    pageView.unselectedColor = [UIColor blackColor];
//    pageView.defaultSubscript = 0;
//  //  [self.view addSubview:pageView];
//
//    
//    return pageView;
//}
//




//- (void)setNavBarHidden:(BOOL)hiden {
//    if (hiden) {
//        [UIView animateWithDuration:0.5 animations:^{
//            CGRect frame = self.navigationController.navigationBar.frame;
//            frame.origin.y = -64;
//            self.navigationController.navigationBar.frame = frame;
//        } completion:^(BOOL finished) {
//            [self.navigationController.navigationBar setHidden:hiden];
//        }];
//
//    }else {
//        [self.navigationController.navigationBar setHidden:hiden];
//        [UIView animateWithDuration:0.5 animations:^{
//            CGRect frame = self.navigationController.navigationBar.frame;
//            frame.origin.y = 20;
//            self.navigationController.navigationBar.frame = frame;
//        } completion:^(BOOL finished) {
//        }];
//
//    }
//}

//#pragma mark - 长按手势
//- (void)longPressAction:(UILongPressGestureRecognizer *)recognizer {
//    
//    CGPoint touchPoint = [recognizer locationInView:self.collectionView];
//    _moveIndexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
//
//    switch (recognizer.state) {
//        case UIGestureRecognizerStateBegan: {
//            if (_isEditing == NO) {
//                self.isEditing = YES;
//                [self.collectionView reloadData];
//                [self.collectionView layoutIfNeeded];
//            }
//            if (_moveIndexPath.section == 0) {
//                ItemCell *selectedItemCell = (ItemCell *)[self.collectionView cellForItemAtIndexPath:_moveIndexPath];
//                _originalIndexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
//                if (!_originalIndexPath) {
//                    return;
//                }
//                _snapshotView = [selectedItemCell.container snapshotViewAfterScreenUpdates:YES];
//                _snapshotView.center = [recognizer locationInView:self.collectionView];
//                [self.collectionView addSubview:_snapshotView];
//                selectedItemCell.hidden = YES;
//                [UIView animateWithDuration:0.2 animations:^{
//                    _snapshotView.transform = CGAffineTransformMakeScale(1.03, 1.03);
//                    _snapshotView.alpha = 0.98;
//                }];
//            }
//            
//        } break;
//        case UIGestureRecognizerStateChanged: {
//            
//            _snapshotView.center = [recognizer locationInView:self.collectionView];
//            
//            if (_moveIndexPath.section == 0) {
//                if (_moveIndexPath && ![_moveIndexPath isEqual:_originalIndexPath] && _moveIndexPath.section == _originalIndexPath.section) {
//                    ItemGroup *homeGroup = self.itemGroups[0];
//                    NSMutableArray *array = homeGroup.items;
//                    NSInteger fromIndex = _originalIndexPath.item;
//                    NSInteger toIndex = _moveIndexPath.item;
//                    if (fromIndex < toIndex) {
//                        for (NSInteger i = fromIndex; i < toIndex; i++) {
//                            [array exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
//                        }
//                    }else{
//                        for (NSInteger i = fromIndex; i > toIndex; i--) {
//                            [array exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
//                        }
//                    }
//                    [self.collectionView moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
//                    _originalIndexPath = _moveIndexPath;
//                }
//            }
//        } break;
//        case UIGestureRecognizerStateEnded: {
//            ItemCell *cell = (ItemCell *)[self.collectionView cellForItemAtIndexPath:_originalIndexPath] ;
//            cell.hidden = NO;
//            [_snapshotView removeFromSuperview];
//        } break;
//            
//        default: break;
//    }
//}

#pragma mark - 点击右上角按钮
//- (void)rightUpperButtonDidTappedWithItemCell:(ItemCell *)itemCell {
//    ItemModel *itemModel = itemCell.itemModel;
//    if (itemModel.status == StatusMinusSign) {
//        ItemGroup *homeGroup = self.itemGroups[0];
//        [(NSMutableArray *)homeGroup.items removeObject:itemModel];
//        for (ItemModel *model in self.allItemModel) {
//            if ([itemModel.itemTitle isEqualToString:model.itemTitle]) {
//                model.status = StatusPlusSign;
//                break;
//            }
//        }
//        UIView *snapshotView = [itemCell snapshotViewAfterScreenUpdates:YES];
//        snapshotView.frame = [itemCell convertRect:itemCell.bounds toView:self.view];;
//        [self.view addSubview:snapshotView];
//        itemCell.hidden = YES;
//        [UIView animateWithDuration:0.4 animations:^{
//            snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        } completion:^(BOOL finished) {
//            [snapshotView removeFromSuperview];
//            itemCell.hidden = NO;
//            [self.collectionView reloadData];
//        }];
//        
//    }else if (itemModel.status == StatusPlusSign) {
//        itemModel.status = StatusCheck;
//        ItemGroup *homeGroup = self.itemGroups[0];
//        ItemModel *homeItemModel = [[ItemModel alloc] init];
//        homeItemModel.imageName = itemModel.imageName;
//        homeItemModel.itemTitle = itemModel.itemTitle;
//        homeItemModel.status = StatusMinusSign;
//        [homeGroup.items addObject:homeItemModel];
//        
//        UIView *snapshotView = [itemCell snapshotViewAfterScreenUpdates:YES];
//        snapshotView.frame = [itemCell convertRect:itemCell.bounds toView:self.view];
//        [self.view addSubview:snapshotView];
//        
//        [self.collectionView reloadData];
//        [self.collectionView layoutIfNeeded];
//        
//        ItemCell *lastCell = (ItemCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:homeGroup.items.count - 1 inSection:0]];
//        lastCell.hidden = YES;
//        CGRect targetFrame = [lastCell convertRect:lastCell.bounds toView:self.view];
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            snapshotView.frame = targetFrame;
//        } completion:^(BOOL finished) {
//            [snapshotView removeFromSuperview];
//            lastCell.hidden = NO;
//        }];
//        
//    }else if (itemModel.status == StatusCheck) {
//        ///
//    }
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [defaults boolForKey:@"islogin"];
    if (!islogin) {
        self.isRequestData = YES;
        LoginViewController *loginVc = [[LoginViewController alloc] init];
        loginVc.isBackMain = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
        [self.tabBarController presentViewController:nav animated:YES completion:^{
            
        }];
    }else{
        [self addUserDetail];
    }

    
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    BOOL islogin = [defaults boolForKey:@"islogin"];
//    if (!islogin) {
//        self.isRequestData = YES;
//        LoginViewController *loginVc = [[LoginViewController alloc] init];
//        loginVc.isBackMain = YES;
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
//        [self.tabBarController presentViewController:nav animated:NO completion:^{
//            
//        }];
//    }else{
//         [self addUserDetail];
//    }
//}
-(void)addUserDetail
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *vip = [def objectForKey:@"userId"];
    
    [networking AFNRequestNotCode:[NSString stringWithFormat:@"%@/%@",SELECTASSET,vip] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"dic:%@  vip:%@",dic,vip);
        NSNumber *code=dic[@"status"];
        if ([code isEqualToNumber:@200]) {
            NSDictionary *response = dic[@"lianjiuData"];
//            self.zuJi = response[@"zjtj"];
//            _souCang = response[@"sctj"];
//            self.xiaoXi = response[@"MessAge"];;
//            self.isHuiShouShang = response[@"HS"];
            
           
            
            NSString *userName = [NSString stringWithFormat:@"%@",response[@"username"]];
            if (userName.length>0) {
               if (userName.length>9) {
                    NSString *tel = [userName stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                    _headerView.titleLLLL.text = [NSString stringWithFormat:@"%@",tel];
                }else{
                    _headerView.titleLLLL.text =  [NSString stringWithFormat:@"%@",userName];
                }

            }else{
                
                 _headerView.titleLLLL.text = [NSString stringWithFormat:@"用户:%@",response[@"nickName"]];
            }
            
            
            
            
            // _headerView.titleLLLL.text = @"23232";
            [_headerView.headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",response[@"userphoto"]]] placeholderImage:[UIImage imageNamed:@"lianjijuLOGO"] options:SDWebImageLowPriority | SDWebImageRetryFailed |SDWebImageTransformAnimatedImage|SDWebImageProgressiveDownload];
            
            _headerView.ziChanMoney.text = [NSString stringWithFormat:@"%@元",response[@"userAsset"]];//
            _headerView.zhuanQuMoney.text =   [NSString stringWithFormat:@"%@元",response[@"accumulatedAmount"]];//
            _headerView.huanBaoLevel.text =  [NSString stringWithFormat:@"%@",response[@"integral"]];//
            _headerView.huanBaoL.text = [NSString stringWithFormat:@"环保达人%@级",response[@"grade"]];//;
            
            
            
#pragma -----
            self.userModel = [AccountModel ModelWith:response];
            //
            self.isRequestData = NO;
            [NSKeyedArchiver archiveRootObject:self.userModel toFile:ACCOUNTPATH];
           
        }else{
            
            
            [MBProgressHUD showNotPhotoError:dic[@"msg"] toView:self.view];
            
//            if ([code isEqualToNumber:@-2]) {
//                [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请重新登录", nil) toView:self.view];
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                //                    [defaults removeObjectForKey:@"vip"];
//                //                    [defaults removeObjectForKey:@"sessionid"];
//                [defaults setObject:@"" forKey:@"vip"];
//                [defaults setBool:NO forKey:@"islogin"];
//                [defaults setBool:NO forKey:@"isRealName"];
//                [defaults synchronize];
//                //    删除归档模型
//                NSFileManager *defaultManager = [NSFileManager defaultManager];
//                if ([defaultManager isDeletableFileAtPath:ACCOUNTPATH]) {
//                    [defaultManager removeItemAtPath:ACCOUNTPATH error:nil];
//                }
//            }
//            
            self.userModel=[NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNTPATH];
         
            
        }
    } error:^(NSError *error) {
        self.userModel=[NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNTPATH];
       // [_tableView reloadData];
        
    } HUDAddView:self.view];
}

@end



