


#import "DaZongOrderViewController.h"
#import "DLFixedTabbarView.h"
#import "DLTabedSlideView.h"
#import "DaZongOrderManageTVController.h"
@interface DaZongOrderViewController ()<DLTabedSlideViewDelegate>
@property(nonatomic,strong)DLTabedSlideView *tabedSlideView;
@end

@implementation DaZongOrderViewController
{
    NSArray *controllers;
}

-(void)backBtn{
   // B_C_TViewController *bct = [[B_C_TViewController alloc] init];
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
    if (_isPay) {
//            UIViewController *viewCtl = self.navigationController.viewControllers[2];
//            [self.navigationController popToViewController:viewCtl animated:YES];
        
        [self.navigationController popToRootViewControllerAnimated:YES];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
  
}

-(void)viewDidLoad
{
    [super viewDidLoad];
      
    if (_isPay) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 50, 50);
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = backItem;

    }
    
    
    self.title = @"大宗交易";
    
    
    
    self.view.backgroundColor = BGColor;
//    childrenVCs = [[NSMutableArray alloc] init];
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0,64, BOUND_WIDTH, BOUND_HIGHT-64)];
    self.tabedSlideView.delegate =self;
    [self.view addSubview:self.tabedSlideView];
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = MAINColor;
    self.tabedSlideView.tabbarTrackColor = [UIColor clearColor];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@""];
    self.tabedSlideView.tabbarBottomSpacing = 0;
    self.tabedSlideView.tabbarHeight = BOUND_WIDTH/4.0/187.0*73.0;
    
    
    
    controllers = @[@[@"",@"dz_huishou",@"dz_huishouS"],@[@"",@"dz_jiaoyi",@"dz_jiaoyiS"],@[@"",@"dz_jiesuan",@"dz_jiesuanS"],@[@"",@"dz_quxiao",@"dz_quxiaoS"],];//4个--文字:图片
    
    NSMutableArray *list =[[NSMutableArray alloc] init];
//    //[UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArr[i]]];
//    for (int i = 0; i<5; i++) {
//        DLTabedbarItem *item = [DLTabedbarItem itemWithTitle:controllers[i] image: [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArr[i]]] selectedImage: [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgSArr[i]]]];
//        [list addObject:item];
//
//    }
    
    
    for (NSArray *arr in controllers) {
        DLTabedbarItem *item = [DLTabedbarItem itemWithTitle:arr[0] image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",arr[1]]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",arr[2]]]];
        [list addObject:item];
    }
    
    
    
    self.tabedSlideView.tabbarItems = list;
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
   
  
    
    
}
#pragma mark - DLTabedSliderViewDelegate
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 4;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    
    DaZongOrderManageTVController *controller = [[DaZongOrderManageTVController alloc] initWithStyle:UITableViewStyleGrouped];
    
  
    controller.type = index+1;
  


    
    return controller;
}
@end
