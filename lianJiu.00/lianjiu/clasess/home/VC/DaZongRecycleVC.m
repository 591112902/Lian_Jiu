


#import "DaZongRecycleVC.h"
#import "SDCycleScrollView.h"


#import "ZSWViewController.h"
#import "UIImageView+WebCache.h"
#import "NewViewController.h"

@interface DaZongRecycleVC ()<SDCycleScrollViewDelegate>
{
    UIScrollView *_scrollV;
    CGFloat _scrollVH;
    SDCycleScrollView *cycleScrollView;//滚动视图
    NSMutableArray *scrollPhotoList;
    
}


@property (nonatomic, strong) AMapPOI *model;

@end

@implementation DaZongRecycleVC
-(void)requestData{
    [networking AFNRequest:PRODUCTBULK withparameters:nil success:^(NSMutableDictionary *dic) {
        
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *lianjiuData =dic[@"lianjiuData"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:lianjiuData[@"TAKEN"] forKey:@"BulkToken"];
            [defaults synchronize];
        }
       
        
    } error:^(NSError *error) {
    } HUDAddView:self.view];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self ADDCarousel];
    
    self.title = @"大宗货物交易";
    
    
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    //图片轮播器
    CGFloat headImageH = BOUND_WIDTH/750.0*319;
    // 本地加载 --- 创建不带标题的图片轮播器
    cycleScrollView = [[SDCycleScrollView alloc ] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, headImageH)];
    cycleScrollView.backgroundColor = BGColor;
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.dotColor = [UIColor clearColor];//MAINColor; // 自定义分页控件小圆标颜色
    cycleScrollView.imageURLStringsGroup =@[@"qyhshead"];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"qyhshead"];
    [_scrollV addSubview:cycleScrollView];
    _scrollVH +=5+headImageH;

    //750 377
    
    CGFloat imgH = BOUND_WIDTH/750.0*377.0;
    UIImageView *pinzhiV = [[UIImageView alloc] init];
    pinzhiV.image = [UIImage imageNamed:@"qyhsceter2"];
    pinzhiV.backgroundColor = [UIColor whiteColor];
    pinzhiV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, imgH);
    _scrollVH +=imgH;
    [_scrollV addSubview:pinzhiV];
    _scrollVH +=35;
    
    
    UILabel *hswpLabel = [[UILabel alloc] init];
    hswpLabel.text = @"选择回收送货仓库";
    hswpLabel.textColor = [UIColor darkGrayColor];
    hswpLabel.font = PFR13Font;
    hswpLabel.textAlignment = NSTextAlignmentLeft;
    hswpLabel.frame = CGRectMake(10, _scrollVH, BOUND_WIDTH-20, 30);
    [_scrollV addSubview:hswpLabel];
    _scrollVH +=30;
    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(10, _scrollVH, BOUND_WIDTH-20, 44);
    commitBtn.layer.cornerRadius = 5;
    commitBtn.backgroundColor = MAINColor;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitle:@"深圳观澜仓库" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollV addSubview:commitBtn];
    _scrollVH+=44;
    
    UILabel *quxiaoTS = [[UILabel alloc] initWithFrame:CGRectMake(10, _scrollVH , BOUND_WIDTH-20, 44)];
    quxiaoTS.text = @"若清单中无您要回收的货物可联系链旧客服:400-1818-209";
    quxiaoTS.textColor = [UIColor lightGrayColor];
    quxiaoTS.textAlignment = NSTextAlignmentCenter;
    quxiaoTS.font = PFR12Font;
    quxiaoTS.numberOfLines = 0;
    quxiaoTS.adjustsFontSizeToFitWidth = YES;
    [_scrollV addSubview:quxiaoTS];

    
    

    
    _scrollVH +=44 +20;
    _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -广告接口
- (void)ADDCarousel
{
//    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/1",SELECTCARAROUSE] withparameters:nil success:^(NSMutableDictionary *dic) {
//        
//        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
//            NSArray *response = dic[@"lianjiuData"];
//            
//            NSMutableArray *arr = [[NSMutableArray alloc] init];
//            scrollPhotoList = [[NSMutableArray alloc] init];
//            for (NSDictionary *temp in response) {
//                NSString *str = temp[@"caPicture"]?temp[@"caPicture"]:@"";
//                NSString *urlStr = [str excisionForFistString];
//                urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//                
//                [arr addObject:[@"" stringByAppendingString:urlStr]];
//                
//                [scrollPhotoList addObject:temp[@"caPicLink"]?temp[@"caPicLink"]:@""];
//            }
//            
//            cycleScrollView.imageURLStringsGroup =arr;
//        }
//    } error:nil];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (scrollPhotoList.count>0) {
        ZSWViewController *ZSWWebView = [[ZSWViewController alloc] init];
        ZSWWebView.title = @"链旧";
        ZSWWebView.url= scrollPhotoList[index];
        ZSWWebView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ZSWWebView animated:YES];
    }
}


-(void)commitBtnClick{
    
    SetUpListVC *svc = [[SetUpListVC alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
//   
//    [networking AFNPOST:ADDCOMPANY withparameters:@{@"orCompanyName":qymcTF.text,@"orCompanyUser":lxrTF.text,@"orCompanyPhone":lxdhTF.text,@"orCompanyLocation":[NSString stringWithFormat:@"%@",mphTF.text],@"orCompanyProducts":hswpTV.text} success:^(NSMutableDictionary *dic) {
//        
//        //提示框
//        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [clear addAction:queRen];
//        [self presentViewController:clear animated:YES completion:nil];
//        
//    } error:nil HUDAddView:self.view];
    
}

@end
