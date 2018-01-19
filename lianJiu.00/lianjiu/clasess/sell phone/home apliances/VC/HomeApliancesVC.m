
#import "SDCycleScrollView.h"

#import "HomeApliancesVC.h"
#import "CategoryTableCell.h"
#import "CollectionHeader.h"
#import "ChanPinListVC.h"
#define CategoryIdentifier           @"CategoryIdentifier"
#define CollectionCell               @"CollectionCell"
#define CollectionHead               @"CollectionHead"

@interface HomeApliancesVC ()

@property (strong, nonatomic)  UITableView *categoryTable;
@property (strong, nonatomic)  UICollectionView *contentCollection;

@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (strong, nonatomic) NSMutableArray *categoryArrayIDID;
@property (strong, nonatomic) NSIndexPath *selectIndex;
@property (strong, nonatomic) NSMutableArray *contentArray;
@property (strong, nonatomic) NSMutableArray *contentArrayIDID;
@end

@implementation HomeApliancesVC
{
     NSMutableArray *headPhotosUrl;
}
-(void)requestData{
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@",PRODUCTHOUSEHOLD] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        
        //左边一排的文字...
        
        if ([lianjiuData[@"households"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"households"];
            for (NSDictionary *temp in response) {
                [_categoryArray addObject:[temp objectForKey:@"categoryName"]];
                 [_categoryArrayIDID addObject:[temp objectForKey:@"categoryId"]];
            }
        }
        
        
        //轮播图片...
        if ([lianjiuData[@"adElectronic"] isKindOfClass:[NSDictionary class]]) {
            
             NSDictionary *adElectronic =   lianjiuData[@"adElectronic"];
            NSString *str = adElectronic[@"elePicture"]?adElectronic[@"elePicture"]:@"";
          
            
            [headPhotosUrl addObject:str];
            
            
//            NSArray *response = lianjiuData[@"adElectronic"];
//            headPhotosUrl = [[NSMutableArray alloc] init];

//            for (NSDictionary *temp in response) {
//                NSString *str = temp[@"caPicture"]?temp[@"caPicture"]:@"";
//                NSString *urlStr = [str excisionForFistString];
//                urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//                [headPhotosUrl addObject:[@"" stringByAppendingString:urlStr]];
//            }
           
        }

        
        
        //中间内容图片
        if ([lianjiuData[@"brands"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"brands"];
            for (NSDictionary *temp in response) {
                [_contentArray addObject:[temp objectForKey:@"categoryImage"]];
                [_contentArrayIDID addObject:[temp objectForKey:@"categoryId"]];
            }
          
        }

        
        
        
        
          [_contentCollection reloadData];
        [self.categoryTable reloadData];//
    } error:^(NSError *err){
        
    } HUDAddView:self.view];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    headPhotosUrl = [[NSMutableArray alloc] init];
    [self setup];
    [self requestData];
    
}

-(void)setup{
    self.selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
   // self.contentArray = @[@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},@{@"image":@"11.png"},];
    // self.categoryArray = @[@"手机数码",@"母婴用品",@"生活需要",@"衣帽服饰",@"公司办公",@"衣食住行"];
    self.categoryArrayIDID = [[NSMutableArray alloc] init];
    self.categoryArray = [[NSMutableArray alloc] init];
    self.contentArray = [[NSMutableArray alloc] init];
    self.contentArrayIDID = [[NSMutableArray alloc] init];

   
    self.categoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH/375.0*83, BOUND_HIGHT-TARBARHEIGHT)];
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
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, BOUND_WIDTH/375.0*159);
    layout.minimumLineSpacing = 3;
    layout.minimumInteritemSpacing = 3;

    
    self.contentCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(BOUND_WIDTH/375.0*83, 64, BOUND_WIDTH/375.0*292, [UIScreen mainScreen].bounds.size.height-TARBARHEIGHT-64) collectionViewLayout:layout];
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
    return BOUND_WIDTH/375.0*61;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryIdentifier];
    [cell configCellWithTitle:[self.categoryArray objectAtIndex:indexPath.row] andIndexPath:indexPath andSelectIndexPath:self.selectIndex];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath;
    [self.categoryTable reloadData];
    
    
    
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",GETBRANDBYCID,[self.categoryArrayIDID objectAtIndex:indexPath.row]] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        
        [_contentArray removeAllObjects];
         [_contentArrayIDID removeAllObjects];
        NSDictionary *lianjiuData = dic[@"lianjiuData"];
        //中间内容图片
        if ([lianjiuData[@"brands"] isKindOfClass:[NSArray class]]) {
            NSArray *response = lianjiuData[@"brands"];
            for (NSDictionary *temp in response) {
                [_contentArray addObject:[temp objectForKey:@"categoryImage"]];
                
                 [_contentArrayIDID addObject:[temp objectForKey:@"categoryId"]];
            }
            
        }
        
        [_contentCollection reloadData];
      
    } error:^(NSError *err){
        
    } HUDAddView:self.view];
    
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contentArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCell forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:301];
   // UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
//    NSDictionary *dic = [self.contentArray objectAtIndex:indexPath.row];
//    imageView.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    
    
    
  //  imageView.image = [UIImage imageNamed:[self.contentArray objectAtIndex:indexPath.row]];
    
  
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.contentArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@""]];
    NSLog(@"contentArrayIDID:%@",[self.contentArrayIDID objectAtIndex:indexPath.row]);
    
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
     return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
       // CollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHead forIndexPath:indexPath];
        
        
        CollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHead forIndexPath:indexPath];

        
        headerView.chLabel.text = @" 家电回收暂时仅限深圳市";
        
        
       CGFloat headImageH = [UIScreen mainScreen].bounds.size.width/375.0*129;
       UIScrollView *_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width/375.0*30, [UIScreen mainScreen].bounds.size.width/375.0*292, [UIScreen mainScreen].bounds.size.width/375.0*129)];
        //headSCView.delegate = self;
        _scrollView.tag = 199999;
        for (int i = 0; i<headPhotosUrl.count; i++) {
            UIImageView *headImag = [[UIImageView alloc] initWithFrame:CGRectMake(i*([UIScreen mainScreen].bounds.size.width/375.0*292), 0, [UIScreen mainScreen].bounds.size.width/375.0*292, headImageH)];
            NSString *urlStr = [@"" stringByAppendingString:headPhotosUrl[i]?headPhotosUrl[i]:@""];
            urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            [headImag sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"222"]];
            
            [_scrollView addSubview:headImag];
            headImag = nil;
        }
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(headPhotosUrl.count*([UIScreen mainScreen].bounds.size.width/375.0*292), headImageH);
        [headerView addSubview:_scrollView];
        _scrollView = nil;
        
        CGFloat pageItemW = 15;
        UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/375.0*292-pageItemW*headPhotosUrl.count)/2, headImageH, pageItemW*headPhotosUrl.count, 10)];
        page.tag = 44;
        page.numberOfPages = headPhotosUrl.count;
        page.currentPageIndicatorTintColor = MAINColor;
        [headerView addSubview:page];

        
        
//        ItemGroup *group = self.itemGroups[indexPath.section];
//        headerView.title = group.type;
        
        return headerView;
    }else {
        return nil;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
     [self.categoryTable reloadData];
    
    NSLog(@"点击了个第%zd分组第%zd几个Item   IDIDID:%@",indexPath.section,indexPath.row,[self.contentArrayIDID objectAtIndex:indexPath.row]);
    
    ChanPinListVC *cpvc = [[ChanPinListVC alloc] init];
    cpvc.categoryId = [self.contentArrayIDID objectAtIndex:indexPath.row];
    cpvc.title = @"所有产品";
    cpvc.jiaORShou = @"";
    cpvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cpvc animated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
