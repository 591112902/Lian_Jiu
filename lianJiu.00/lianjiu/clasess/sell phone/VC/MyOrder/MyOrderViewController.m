


#import "MyOrderViewController.h"
#import "DLFixedTabbarView.h"
#import "DLTabedSlideView.h"
#import "OrderManageTVController.h"
@interface MyOrderViewController ()<DLTabedSlideViewDelegate>
@property(nonatomic,strong)DLTabedSlideView *tabedSlideView;
@end

@implementation MyOrderViewController
{
    NSArray *controllers;
    
    
//    NSArray *imgArr ;
//    
//    NSArray *imgSArr;
    

}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的订单";
    
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
    self.tabedSlideView.tabbarHeight = BOUND_WIDTH/5.0/150.0*116.0;
    
    
    
    
    
   // @[@"快递回收",@"jiesuan",@"jiesuanS"],;
    controllers = @[@[@"",@"kuaidi",@"kuaidiS"],@[@"",@"daifahuo",@"daifahuoS"],@[@"",@"yanji",@"yanjiS"],@[@"",@"jiesuan",@"jiesuanS"],@[@"",@"quxiao",@"quxiaoS"],];//5个
    
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
    
    OrderManageTVController *controller = [[OrderManageTVController alloc] initWithStyle:UITableViewStyleGrouped];
    
   // [MBProgressHUD showNotPhotoError:[NSString stringWithFormat:@"%zd",index] toView:[UIApplication sharedApplication].keyWindow];
    if (index == 0) {
        
        controller.type = 1;//议价中(买)
        
    }else if (index == 1){
        
        controller.type = 2;//交易中(买)
             
    }else if (index == 2){
        
        controller.type = 4;//已成交(买)
        
    }else if (index == 3){
        
        controller.type = 3;//已结束(买)
    }
    //controller.type = index+1;
  //  controller.url = TBGL;
  //  controller.state = controllers[index];

//[childrenVCs addObject:controller];
    return controller;
}
@end
