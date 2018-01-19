//
//  DCFeatureSelectionViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
/** 屏幕高度 */
#import "DCSpeedy.h"
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
#import "DCFeatureSelectionViewController.h"

// Controllers
//#import "DCFillinOrderViewController.h"
// Models
#import "DCFeatureItem.h"
#import "DCFeatureTitleItem.h"
#import "DCFeatureList.h"

#import "UIView+DCExtension.h"
// Views
//#import "PPNumberButton.h"//
#import "DCFeatureItemCell.h"//
#import "DCFeatureHeaderView.h"//
#import "DCCollectionHeaderLayout.h"//
#import "DCFeatureChoseTopCell.h"
// Vendors
#import "MJExtension.h"

#import "MBProgressHUD.h"
//#import <SVProgressHUD.h>
#import "UIImageView+WebCache.h"
#import "UIViewController+XWTransition.h"//
// Categories

// Others

#define NowScreenH ScreenH * 0.8

@interface DCFeatureSelectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HorizontalCollectionLayoutDelegate,UITableViewDelegate,UITableViewDataSource>

/* contionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;

/* 选择属性 */
@property (strong , nonatomic)NSMutableArray *seleArray;
/* 商品选择结果Cell */
@property (weak , nonatomic)DCFeatureChoseTopCell *cell;

@end

static NSInteger num_;

static NSString *const DCFeatureHeaderViewID = @"DCFeatureHeaderView";
static NSString *const DCFeatureItemCellID = @"DCFeatureItemCell";
static NSString *const DCFeatureChoseTopCellID = @"DCFeatureChoseTopCell";
@implementation DCFeatureSelectionViewController
{
    UIWebView *_webView;
}
#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        DCCollectionHeaderLayout *layout = [DCCollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = 10;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        layout.itemInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[DCFeatureItemCell class] forCellWithReuseIdentifier:DCFeatureItemCellID];//cell
        [_collectionView registerClass:[DCFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[DCFeatureChoseTopCell class] forCellReuseIdentifier:DCFeatureChoseTopCellID];
    }
    return _tableView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpFeatureAlterView];
    
    [self setUpBase];
    
    [self setUpBottonView];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    _featureAttr = [DCFeatureItem mj_objectArrayWithFilename:@"ShopItem.plist"];
    self.tableView.frame = CGRectMake(0, 0, ScreenW, 100);
    self.tableView.rowHeight = 100;
    self.collectionView.frame = CGRectMake(0, self.tableView.dc_bottom ,ScreenW , NowScreenH - 155);
   
    NSLog(@"_featureAttr_featureAttr%@",_featureAttr);
    
//    if (_lastSeleArray.count == 0) return;
//    for (NSString *str in _lastSeleArray) {//反向遍历
//        for (NSInteger i = 0; i < _featureAttr.count; i++) {
//            for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
//                if ([_featureAttr[i].list[j].infoname isEqualToString:str]) {
//                    _featureAttr[i].list[j].isSelect = YES;
//                    [self.collectionView reloadData];
//                }
//            }
//        }
//    }

}

#pragma mark - 底部按钮
- (void)setUpBottonView
{
    NSArray *titles = @[@"联系客服",@"立即购买"];
    CGFloat buttonH = BOUND_WIDTH/320.0*38;
    CGFloat buttonW = ScreenW / titles.count;
    CGFloat buttonY = NowScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:titles[i] forState:0];
        buttton.backgroundColor = (i == 0) ? [UIColor redColor] : [UIColor orangeColor];
        CGFloat buttonX = buttonW * i;
        buttton.tag = i+8888;
        
        if (i==0) {
            [buttton setImage:[UIImage imageNamed:@"jpinKF"] forState:UIControlStateNormal];//kefu
        }else{
            [buttton setImage:[UIImage imageNamed:@"JpoijMaoi"] forState:UIControlStateNormal];//mai
        }
        
        buttton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:buttton];
        [buttton addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    UILabel *numLabel = [UILabel new];
//    numLabel.text = @"数量";
//    numLabel.font = PFR14Font;
//    [self.view addSubview:numLabel];
//    numLabel.frame = CGRectMake(10, NowScreenH - 90, 50, 35);
//    
//    UIButton *numberButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    numberButton.frame = CGRectMake(CGRectGetMaxX(numLabel.frame), numLabel.dc_y, 110, numLabel.dc_height);
//    numberButton.shakeAnimation = YES;
//    numberButton.minValue = 1;
//    numberButton.inputFieldFont = 23;
//    numberButton.increaseTitle = @"＋";
//    numberButton.decreaseTitle = @"－";
   // num_ = (_lastNum == 0) ?  1 : [_lastNum integerValue];
   // numberButton.currentNumber = num_;
   // numberButton.delegate = self;
    
//    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
//        num_ = num;
//    };
    //[self.view addSubview:numberButton];
}

#pragma mark - 底部按钮点击
- (void)buttomButtonClick:(UIButton *)button
{
//    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {//未选择全属性警告
//        
//       // [MBProgressHUD showNotPhotoError:@"请选择全属性" toView:self.view];
////        [SVProgressHUD showInfoWithStatus:@"请选择全属性"];
////        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
////        [SVProgressHUD dismissWithDelay:1.0];
//       // return;
//    }
    
    
//    if (button.tag ==100) {//kefu
//        // 提示：不要将webView添加到self.view，如果添加会遮挡原有的视图
//        // 懒加载
//        if (_webView == nil) {
//            _webView = [[UIWebView alloc] init];
//        }
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://4001818209"]];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:request];
//
//        
//    }else{//sell===
//        
//    }
    
    [self dismissFeatureViewControllerWithTag:button.tag];
    
}

#pragma mark - 弹出弹框
- (void)setUpFeatureAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    __weak typeof(self)weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [weakSelf dismissFeatureViewControllerWithTag:1009];
        }];
    } edgeSpacing:0];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCFeatureChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCFeatureChoseTopCellID forIndexPath:indexPath];
    _cell = cell;
//    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {
//        //cell.chooseAttLabel.textColor = [UIColor redColor];
//        cell.chooseAttLabel.text = @"有货";
//    }else {
//        cell.chooseAttLabel.textColor = [UIColor darkGrayColor];
//        NSString *attString = (_seleArray.count == _featureAttr.count) ? [_seleArray componentsJoinedByString:@"，"] : [_lastSeleArray componentsJoinedByString:@"，"];
//        cell.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",attString];
//    }

    
   
     cell.chooseAttLabel.text = _goodTitieStr;

    cell.goodPriceLabel.text = _goodPriceStr;
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageView]];
    __weak typeof(self)weakSelf = self;
    cell.crossButtonClickBlock = ^{
        [weakSelf dismissFeatureViewControllerWithTag:1009];
    };
    return cell;
}

#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag
{
    
    __weak typeof(self)weakSelf = self;
    [weakSelf dismissViewControllerAnimated:YES completion:^{
        //if (![weakSelf.cell.chooseAttLabel.text isEqualToString:@"有货"]) {//当选择全属性才传递出去
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSMutableArray *numArray = [NSMutableArray arrayWithArray:_lastSeleArray];
            NSDictionary *paDict = @{
                                     @"Tag" : [NSString stringWithFormat:@"%zd",tag],
                                     @"Num" : [NSString stringWithFormat:@"%zd",num_],
                                     @"Array" : numArray
                                     };
            NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:paDict];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"itemSelectBack" object:nil userInfo:dict];

//            if (_seleArray.count == 0) {
//                           }else{
//                NSDictionary *paDict = @{
//                                         @"Tag" : [NSString stringWithFormat:@"%zd",tag],
//                                         @"Num" : [NSString stringWithFormat:@"%zd",num_],
//                                         @"Array" : _seleArray
//                                         };
//                NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:paDict];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"itemSelectBack" object:nil userInfo:dict];
//            }
        });
        // }
    }];
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *cDic = _featureAttr[section];
    NSArray *arr =  [cDic objectForKey:@"children"];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DCFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCFeatureItemCellID forIndexPath:indexPath];
    
     NSArray *arr =  [_featureAttr[indexPath.section] objectForKey:@"children"];
    
    NSString *retrieveType = [_featureAttr[indexPath.section] objectForKey:@"retrieveType"];
    
    
    cell.attLabel.text = [arr[indexPath.row] objectForKey:@"major"];
    
    
    
    if ([retrieveType isEqualToString:[arr[indexPath.row] objectForKey:@"major"]]) {//选中的
        cell.attLabel.textColor = MAINColor;
        [DCSpeedy dc_chageControlCircularWith:cell.attLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:MAINColor canMasksToBounds:YES];

        
    }else{
        
        cell.attLabel.textColor = [UIColor blackColor];
        [DCSpeedy dc_chageControlCircularWith:cell.attLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4] canMasksToBounds:YES];

    }
    
    
   // if (content.isSelect) {
         // }else{
           //}

    
    
    
    
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        DCFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID forIndexPath:indexPath];
        
        
         headerView.headerLabel.text = [_featureAttr[indexPath.section]objectForKey:@"major"];
      //  headerView.headTitle = [_featureAttr[indexPath.section]objectForKey:@"major"];
        return headerView;
    }else {

        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//    //限制每组内的Item只能选中一个(加入质数选择)
//    if (_featureAttr[indexPath.section].list[indexPath.row].isSelect == NO) {
//        for (NSInteger j = 0; j < _featureAttr[indexPath.section].list.count; j++) {
//            _featureAttr[indexPath.section].list[j].isSelect = NO;
//        }
//    }
//    _featureAttr[indexPath.section].list[indexPath.row].isSelect = !_featureAttr[indexPath.section].list[indexPath.row].isSelect;
//
//    
//    //section，item 循环讲选中的所有Item加入数组中 ，数组mutableCopy初始化
//    _seleArray = [@[] mutableCopy];
//    for (NSInteger i = 0; i < _featureAttr.count; i++) {
//        for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
//            if (_featureAttr[i].list[j].isSelect == YES) {
//                [_seleArray addObject:_featureAttr[i].list[j].infoname];
//            }else{
//                [_seleArray removeObject:_featureAttr[i].list[j].infoname];
//                [_lastSeleArray removeAllObjects];
//            }
//        }
//    }
//    
//    //刷新tableView和collectionView
//    [self.collectionView reloadData];
//    [self.tableView reloadData];
}


#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    
    
    NSArray *arr =  [_featureAttr[indexPath.section] objectForKey:@"children"];
    
    
   return  [arr[indexPath.row] objectForKey:@"major"];

    
    
    //return _featureAttr[indexPath.section].list[indexPath.row].infoname;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
