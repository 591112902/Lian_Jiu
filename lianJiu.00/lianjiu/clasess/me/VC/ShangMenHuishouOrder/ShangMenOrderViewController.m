


#import "ShangMenOrderViewController.h"
#import "DLFixedTabbarView.h"
#import "DLTabedSlideView.h"
#import "ShangMenOrderManageTVController.h"
@interface ShangMenOrderViewController ()<DLTabedSlideViewDelegate>
@property(nonatomic,strong)DLTabedSlideView *tabedSlideView;
@end

@implementation ShangMenOrderViewController
{
    NSArray *controllers;
    
    
//    NSArray *imgArr ;
//    
//    NSArray *imgSArr;
    

}

-(void)backBtn{
   // B_C_TViewController *bct = [[B_C_TViewController alloc] init];
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
    if (_isPay) {
            UIViewController *viewCtl = self.navigationController.viewControllers[2];
            [self.navigationController popToViewController:viewCtl animated:YES];

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
    
    
    self.title = @"上门回收";
    
    
    
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
    self.tabedSlideView.tabbarHeight = BOUND_WIDTH/5.0/150.0*75.0;
    
    
    
    
    
   // @[@"快递回收",@"jiesuan",@"jiesuanS"],;
    controllers = @[@[@"",@"s_shangmen",@"s_shangmenS"],@[@"",@"s_paidan",@"s_paidanS"],@[@"",@"s_shangzhong",@"s_shangzhongS"],@[@"",@"s_jiesuan",@"s_jiesuanS"],@[@"",@"s_quxiao",@"s_quxiaoS"],];//5个--文字:图片
    
//   imgArr = @[@"jiesuan",@"jiesuan",@"jiesuan",@"jiesuan",@"jiesuan"];
//    
//     imgSArr = @[@"jiesuanS",@"jiesuanS",@"jiesuanS",@"jiesuanS"];
    
    
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
    return 5;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    
    ShangMenOrderManageTVController *controller = [[ShangMenOrderManageTVController alloc] initWithStyle:UITableViewStyleGrouped];
    
  
    controller.type = index+1;
  


    
    return controller;
}
@end
