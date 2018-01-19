


#import "WeiOrderViewController.h"
#import "DLFixedTabbarView.h"
#import "DLTabedSlideView.h"
#import "WeiOrderManageTVController.h"
@interface WeiOrderViewController ()<DLTabedSlideViewDelegate>
@property(nonatomic,strong)DLTabedSlideView *tabedSlideView;
@end

@implementation WeiOrderViewController
{
    NSArray *controllers;
    
    
//    NSArray *imgArr ;
//    
//    NSArray *imgSArr;
    

}

-(void)backBtn{
   // B_C_TViewController *bct = [[B_C_TViewController alloc] init];
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
//    if (_isPay) {
//            UIViewController *viewCtl = self.navigationController.viewControllers[2];
//            [self.navigationController popToViewController:viewCtl animated:YES];
//
//    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    //}
  
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"手机快修";
    
    
    
    if (_isPay) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 50, 50);
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = backItem;

    }
    
    
    
    
    
    
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
    self.tabedSlideView.tabbarHeight = BOUND_WIDTH/3.0/251.0*84;
    
    
    
    
    
   // @[@"快递回收",@"jiesuan",@"jiesuanS"],;
    controllers = @[@[@"",@"daidai",@"daidaiS"],@[@"",@"shangshang",@"shangshangS"],@[@"",@"yiyiyi",@"yiyiyiS"],];//3个--文字:图片
    
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
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    
    WeiOrderManageTVController *controller = [[WeiOrderManageTVController alloc] initWithStyle:UITableViewStyleGrouped];
    
  
    controller.type = index+1;
  


    
    return controller;
}
@end
