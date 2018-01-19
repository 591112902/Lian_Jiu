
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "SellPhoneVC2.h"
#import "CategoryTableCell.h"
#import "CollectionHeader.h"
#import "ChanPinListVC.h"
#import "ChooseConditionVC.h"
#define CategoryIdentifier           @"CategoryIdentifier"
#define CollectionCell               @"CollectionCell"
#define CollectionHead               @"CollectionHead"

@interface SellPhoneVC2 ()

@property (strong, nonatomic)  UITableView *categoryTable;
@property (strong, nonatomic)  UICollectionView *contentCollection;

@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (strong, nonatomic) NSMutableArray *categoryArrayIDID;
@property (strong, nonatomic) NSIndexPath *selectIndex;
@property (strong, nonatomic) NSMutableArray *contentArray;
@property (strong, nonatomic) NSMutableArray *contentArrayIDID;
@end

@implementation SellPhoneVC2
{
     NSString *headPhotosUrl;
 
}


-(void)headClickRequestData:(NSString *)categoryId WithOrder:(NSString *)order{
    if ([order isEqualToString:@"4"]) {
        order = @"5";
    }else if ([order isEqualToString:@"5"]) {
        order = @"4";
    }

    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/%@",ELECTRONICSWITCH,categoryId,order] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        NSLog(@"ELECTRONICSWITCH:%@  %@  %@",dic,categoryId,order);
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        
        //左边一排的文字...
        [_categoryArray removeAllObjects];
        [_categoryArrayIDID removeAllObjects];
        if ([lianjiuData[@"brands"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"brands"];
            for (NSDictionary *temp in response) {
                [_categoryArray addObject:[temp objectForKey:@"categoryName"]];
                [_categoryArrayIDID addObject:[temp objectForKey:@"categoryId"]];
            }
        }
        
        
        //轮播图片...
        if ([lianjiuData[@"adElectronic"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *adElectronic =   lianjiuData[@"adElectronic"];
            
            headPhotosUrl = adElectronic[@"elePicture"]?adElectronic[@"elePicture"]:@"";
            NSLog(@"headPhotosUrl:%@",headPhotosUrl);
            
        }
        
        
        
        //中间内容图片
        if ([lianjiuData[@"product"] isKindOfClass:[NSArray class]]) {
            
            [_contentArray removeAllObjects];
            [_contentArrayIDID removeAllObjects];
            
            NSArray *response = lianjiuData[@"product"];
            for (NSDictionary *temp in response) {
                
                //手机 1，平板电脑 2，笔记本 3，摄影摄像 4，智能数码 5
                if ([_typeStr isEqualToString:@"1"] ||[_typeStr isEqualToString:@"2"]||[_typeStr isEqualToString:@"3"]) {
                    [_contentArray addObject:[NSString stringWithFormat:@"%@价格:%@",[temp objectForKey:@"productName"],[temp objectForKey:@"productPrice"]]];
                    [_contentArrayIDID addObject:[temp objectForKey:@"productId"]?[temp objectForKey:@"productId"]:@""];
                }else{
                    [_contentArray addObject:[temp objectForKey:@"categoryImage"]?[temp objectForKey:@"categoryImage"]:@""];
                    [_contentArrayIDID addObject:[temp objectForKey:@"categoryId"]?[temp objectForKey:@"categoryId"]:@""];

                }
                
            
//                [_contentArrayIDID addObject:[temp objectForKey:@"productId"]];
//                [_contentArrayIDID addObject:@""];
            }
            
        }
        
        [_contentCollection reloadData];
        [self.categoryTable reloadData];//
    } error:^(NSError *err){
        
    } HUDAddView:self.view];

}






-(void)requestData{
    
//    [networking AFNRequest:[NSString stringWithFormat:@"%@",PRODUCTELECTRONIC] withparameters:nil success:^(NSMutableDictionary *dic) {
//        NSDictionary *lianjiuData = dic[@"lianjiuData"];
//        
//        //左边一排的文字...
//        
//        if ([lianjiuData[@"brands"] isKindOfClass:[NSArray class]]) {
//            
//            [_categoryArray removeAllObjects];
//            [_categoryArrayIDID removeAllObjects];
//            
//            NSArray *response = lianjiuData[@"brands"];
//            for (NSDictionary *temp in response) {
//                
//                
//                [_categoryArray addObject:[temp objectForKey:@"categoryName"]];
//                 [_categoryArrayIDID addObject:[temp objectForKey:@"categoryId"]];
//            }
//        }
//        
//        
//        //轮播图片...
//        if ([lianjiuData[@"adElectronic"] isKindOfClass:[NSDictionary class]]) {
////            NSArray *response = lianjiuData[@"adElectronic"];
////             headPhotosUrl = [[NSMutableArray alloc] init];
////            
////            for (NSDictionary *temp in response) {
////                NSString *str = temp[@"caPicture"]?temp[@"caPicture"]:@"";
////                NSString *urlStr = [str excisionForFistString];
////                urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
////                [headPhotosUrl addObject:[@"" stringByAppendingString:urlStr]];
////            }
//            
//            NSDictionary *adElectronic =   lianjiuData[@"adElectronic"];
//            
//            headPhotosUrl = adElectronic[@"elePicture"]?adElectronic[@"elePicture"]:@"";
//            NSLog(@"headPhotosUrl:%@",headPhotosUrl);
//            // [headPhotosUrl addObject:uStr];
//           
//        }
//
//        
//        
//        //中间内容图片
//        if ([lianjiuData[@"product"] isKindOfClass:[NSArray class]]) {
//            [_contentArray removeAllObjects];
//            [_contentArrayIDID removeAllObjects];
//
//            
//            
//            NSArray *response = lianjiuData[@"product"];
//            for (NSDictionary *temp in response) {
//             
//                //手机 1，平板电脑 2，笔记本 3，摄影摄像 4，智能数码 5
//                if ([_typeStr isEqualToString:@"1"] ||[_typeStr isEqualToString:@"2"]||[_typeStr isEqualToString:@"3"]) {
//                    [_contentArray addObject:[NSString stringWithFormat:@"%@价格:%@",[temp objectForKey:@"productName"],[temp objectForKey:@"productPrice"]]];
//                    [_contentArrayIDID addObject:[temp objectForKey:@"productId"]?[temp objectForKey:@"productId"]:@""];
//                }else{
//                    [_contentArray addObject:[temp objectForKey:@"categoryImage"]?[temp objectForKey:@"categoryImage"]:@""];
//                    [_contentArrayIDID addObject:[temp objectForKey:@"categoryId"]?[temp objectForKey:@"categoryId"]:@""];
//                    
//                }
//
//                
////                [_contentArray addObject:[NSString stringWithFormat:@"%@ 价格:%@",[temp objectForKey:@"productName"],[temp objectForKey:@"productPrice"]]];
////                
////                [_contentArrayIDID addObject:[temp objectForKey:@"productId"]];
//            }
//          
//        }
//        
//          [_contentCollection reloadData];
//        [self.categoryTable reloadData];//
//    } error:^(NSError *err){
//        
//    } HUDAddView:self.view];
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear_typeStr:%@ _categoryId%@",_typeStr,_categoryId);
   
     self.selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    [self headClickRequestData:_categoryId WithOrder:_typeStr];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"viewDidLoad_self.title:%@",self.title);
    
    
    self.view.backgroundColor = BGColor;
    
    //headPhotosUrl = [[NSMutableArray alloc] init];
    [self setup];
   // [self requestData];
    
    
     
    
}

-(void)setup{
    self.selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
   // self.contentArray = @[@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},];
    // self.categoryArray = @[@"手机数码",@"母婴用品",@"生活需要",@"衣帽服饰",@"公司办公",@"衣食住行"];
    self.categoryArrayIDID = [[NSMutableArray alloc] init];
    self.categoryArray = [[NSMutableArray alloc] init];
    self.contentArray = [[NSMutableArray alloc] init];
    self.contentArrayIDID = [[NSMutableArray alloc] init];

   
    self.categoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH/375.0*83, BOUND_HIGHT-TARBARHEIGHT-35-64)];
       self.categoryTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.categoryTable.delegate = self;
     self.categoryTable.showsVerticalScrollIndicator = NO;
    self.categoryTable.dataSource = self;
    [self.view addSubview:self.categoryTable];
    [self.categoryTable registerNib:[UINib nibWithNibName:@"CategoryTableCell" bundle:nil] forCellReuseIdentifier:CategoryIdentifier];
    
    
    
    
    //  BOUND_WIDTH/375.0*
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(BOUND_WIDTH/375.0*90, BOUND_WIDTH/375.0*61);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, BOUND_WIDTH/375.0*129);
    layout.minimumLineSpacing = 3;
    layout.minimumInteritemSpacing = 3;

    
    self.contentCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(BOUND_WIDTH/375.0*83, 0, BOUND_WIDTH/375.0*292, [UIScreen mainScreen].bounds.size.height-TARBARHEIGHT-35-64) collectionViewLayout:layout];//BOUND_WIDTH/375.0*129
    self.contentCollection.backgroundColor = [UIColor whiteColor];
    self.contentCollection.delegate = self;
    self.contentCollection.dataSource = self;
    [self.view addSubview:self.contentCollection];

 
    
    
    
    [self.contentCollection registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:CollectionCell];
   // [self.contentCollection registerNib:[UINib nibWithNibName:@"CollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHead];
    
    
     [self.contentCollection registerClass:[CollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHead];
    
    
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return BOUND_WIDTH/320.0*70;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryIdentifier];
    [cell configCellWithTitle:[self.categoryArray objectAtIndex:indexPath.row] andIndexPath:indexPath andSelectIndexPath:self.selectIndex];
    return cell;
}

-(void)collectionPagingRequestData:(NSString *)cid{
   
    
//    if (isDown) {
//        pageNo = 1;
//    }
    
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",YOUBRANDSWITCH,cid] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        if (isDown) {
            [_contentArray removeAllObjects];
            [_contentArrayIDID removeAllObjects];
        }
       
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        //中间内容图片
        if ([lianjiuData[@"brands"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"brands"];
            for (NSDictionary *temp in response) {
                
                
//                //手机 1，平板电脑 2，笔记本 3，摄影摄像 4，智能数码 5
//                [_contentArray addObject:[temp objectForKey:@"categoryImage"]?[temp objectForKey:@"categoryImage"]:@""];
//                [_contentArrayIDID addObject:[temp objectForKey:@"categoryId"]?[temp objectForKey:@"categoryId"]:@""];
                
                
                if ([_typeStr isEqualToString:@"1"] ||[_typeStr isEqualToString:@"2"]||[_typeStr isEqualToString:@"3"]) {
                    [_contentArray addObject:[NSString stringWithFormat:@"%@价格:%@",[temp objectForKey:@"productName"],[temp objectForKey:@"productPrice"]]];
                    [_contentArrayIDID addObject:[temp objectForKey:@"productId"]?[temp objectForKey:@"productId"]:@""];
                }else{
                    [_contentArray addObject:[temp objectForKey:@"categoryImage"]?[temp objectForKey:@"categoryImage"]:@""];
                    [_contentArrayIDID addObject:[temp objectForKey:@"categoryId"]?[temp objectForKey:@"categoryId"]:@""];
                    
                }

                
                
                
                
//                [_contentArray addObject:[temp objectForKey:@"productName"]];
//                
//                [_contentArrayIDID addObject:[temp objectForKey:@"productId"]];
            }
            
        }
//        if (isDown) {
//            pageNo = 2;
//        }else{
//            pageNo++;
//        }
//
        [_contentCollection reloadData];
        
    } error:^(NSError *err){
        
    } HUDAddView:self.view];
    
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath;
    [self.categoryTable reloadData];
    
    
    NSString *cateId = [self.categoryArrayIDID objectAtIndex:indexPath.row];
    
    
    isDown = YES;
    [self collectionPagingRequestData:cateId];
    WS(weakSelf);
    // 下拉刷新
    self.contentCollection.header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        isDown = YES;
         [self collectionPagingRequestData:cateId];
        // 结束刷新
        [weakSelf.contentCollection.header endRefreshing];
    }];
   // [self.contentCollection.header beginRefreshing];
    
    // 上拉刷新
    self.contentCollection.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        isDown = NO;
         [self collectionPagingRequestData:cateId];
        [weakSelf.contentCollection reloadData];
        // 结束刷新
        [weakSelf.contentCollection.footer endRefreshing];
    }];
    // 默认先隐藏footer
    self.contentCollection.footer.hidden = YES;
    
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contentArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCell forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:301];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    
    if ([_typeStr isEqualToString:@"1"] ||[_typeStr isEqualToString:@"2"]||[_typeStr isEqualToString:@"3"] ) {
        
        nameLabel.text = [self.contentArray objectAtIndex:indexPath.row];
        
        
        
    }else{
       [imageView sd_setImageWithURL:[NSURL URLWithString:[self.contentArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
     return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        CollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHead forIndexPath:indexPath];

        
        if (headPhotosUrl) {
            [headerView.chImageView sd_setImageWithURL:[NSURL URLWithString:headPhotosUrl] placeholderImage:[UIImage imageNamed:@""]];
        }
        
        
        return headerView;
    }else {
        return nil;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
     //[self.categoryTable reloadData];
    
    
    //手机 1，平板电脑 2，笔记本 3，摄影摄像 4，智能数码 5
    if ([_typeStr isEqualToString:@"1"] ||[_typeStr isEqualToString:@"2"]||[_typeStr isEqualToString:@"3"]) {
      
//        ChooseAssessVC *vc = [[ChooseAssessVC alloc] init];
        ChooseConditionVC *vc = [[ChooseConditionVC alloc] init];
        vc.productID = [self.contentArrayIDID objectAtIndex:indexPath.row];
        //3.分隔字符串
        NSString *string =[self.contentArray objectAtIndex:indexPath.row];
        NSArray *array = [string componentsSeparatedByString:@"价格:"]; //从字符A中分隔成2个元素的数组
        vc.titleStr = array.count>0?array[0]:@"";
        vc.productPrice = array.count>1?array[1]:@"";
        vc.hidesBottomBarWhenPushed = YES;
        vc.isPhoneNotJD = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        ChanPinListVC *cpvc = [[ChanPinListVC alloc] init];
        cpvc.categoryId = [self.contentArrayIDID objectAtIndex:indexPath.row];
        cpvc.title = @"所有产品";
        
        cpvc.jiaORShou = @"shouji";
        
        cpvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cpvc animated:YES];

    }

    
    
    
    NSLog(@"点击了个第%zd分组第%zd几个Item   IDIDID:%@",indexPath.section,indexPath.row,[self.contentArrayIDID objectAtIndex:indexPath.row]);
    
  
 
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
