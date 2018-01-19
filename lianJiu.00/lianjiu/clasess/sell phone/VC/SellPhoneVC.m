//
//  SellPhoneVC.m
//  lianjiu
//
//  Created by LIHONG on 2017/8/24.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "SellPhoneVC.h"
#import "FSScrollContentView.h"
#import "DCCommodityViewController.h"

@interface SellPhoneVC ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *titleArrID;


@end

@implementation SellPhoneVC
{
    NSArray *controllers; //子页面
    UIButton *shuaXinbtn;
}
//ADDTOEXPRESSPRODUCTCAR
-(void)requestData{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    [manager GET:PRODUCTELECTRONIC parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {//PRODUCTELECTRONIC
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *status=dic[@"status"];
        int c = [status intValue];
        
        if (c==200) {
            [shuaXinbtn removeFromSuperview];
            NSDictionary *lianjiuData = dic[@"lianjiuData"];
            NSArray *electronics = lianjiuData[@"electronics"];
            
            for (NSDictionary *categoryName in electronics) {
                
                [_titleArr addObject:categoryName[@"categoryName"]];
                [_titleArrID addObject:categoryName[@"categoryId"]];
            }
            NSLog(@"_titleArr%@",_titleArr);
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.view.backgroundColor = [UIColor whiteColor];
            // self.title = @"pageContentView";
            self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 35) titles:_titleArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
            self.titleView.titleSelectFont = [UIFont systemFontOfSize:15];
            self.titleView.titleSelectColor = MAINColor;
            self.titleView.indicatorColor = MAINColor;
            self.titleView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
            self.titleView.selectIndex = 0;
            [self.view addSubview:_titleView];
            
            NSMutableArray *childVCs = [[NSMutableArray alloc]init];
#pragma mark---点击上面一排的按钮
            for (int i = 0; i<3; i++) {//前面三个
                SellBottomFirstVC *vc = [[SellBottomFirstVC alloc]init];
                vc.categoryId = _titleArrID[i];
                vc.typeStr = [NSString stringWithFormat:@"%d",i+1];
                [childVCs addObject:vc];
            }
            for (int i = 3; i<5; i++) {//后两个
                SellPhoneVC2 *vc = [[SellPhoneVC2 alloc]init];
                vc.categoryId = _titleArrID[i];
                vc.typeStr = [NSString stringWithFormat:@"%d",i+1];
                [childVCs addObject:vc];
            }
            
            self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 64+ 35, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) ) childVCs:childVCs parentVC:self delegate:self];
            self.pageContentView.contentViewCurrentIndex = 0;
            self.pageContentView.backgroundColor = [UIColor whiteColor];
            //self.pageContentView.contentViewCanScroll = NO;//设置滑动属性
            [self.view addSubview:_pageContentView];

        }else{
             [self.view addSubview:shuaXinbtn];
             [MBProgressHUD showNotPhotoError:dic[@"msg"] toView:superView];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
       
         [self.view addSubview:shuaXinbtn];
    }];

 
    
//    [networking AFNRequest:ADDTOEXPRESSPRODUCTCAR withparameters:nil success:^(NSMutableDictionary *dic) {//PRODUCTELECTRONIC
//    } error:^(NSError *error) {
//    } HUDAddView:self.view];
 

}


-(void)viewWillAppear:(BOOL)animated{
    _titleArr = [[NSMutableArray alloc] init];
    _titleArrID = [[NSMutableArray alloc] init];
    
    
    shuaXinbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shuaXinbtn.frame = CGRectMake(10, 300, BOUND_WIDTH-20, 44);
    shuaXinbtn.layer.cornerRadius = 5;
    [shuaXinbtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    [shuaXinbtn setTitle:@"点击刷新" forState:UIControlStateNormal];
    [shuaXinbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shuaXinbtn.backgroundColor = MAINColor;

   // [self requestData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

   // headPhotosUrl = [[NSMutableArray alloc] init];
  
    //PRODUCTELECTRONIC
    
    
    
    [self requestData];
    
    
   

}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
    //self.title = @[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"][endIndex];
    
   // self.title = [NSString stringWithFormat:@"%ld",endIndex+1];
    
    
//     NSLog(@"titleView:%zd",endIndex);
//     vc.typeStr = [NSString stringWithFormat:@"%d",i+1];
//    
//     [vc headClickRequestData:_titleArrID[i] WithOrder:[NSString stringWithFormat:@"%d",endIndex+1]];
    
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    //self.title = @[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"][endIndex];
    
    NSLog(@"contentViewcontentView:%zd",endIndex);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
