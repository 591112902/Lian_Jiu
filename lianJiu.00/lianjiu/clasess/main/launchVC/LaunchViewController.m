//
//  LaunchViewController.m
//
//
//  Created by cnmobi on 17/12/24.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *photosList;
@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *headSCView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    
    for (int i = 0; i<self.photosList.count; i++) {
        UIImageView *headImag = [[UIImageView alloc] initWithFrame:CGRectMake(i*(BOUND_WIDTH), 0, BOUND_WIDTH, BOUND_HIGHT)];
        headImag.image = self.photosList[i];
        headImag.userInteractionEnabled = YES;
        if (i==self.photosList.count-1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImage:)];
            [headImag addGestureRecognizer:tap];
            
        }
        headImag.backgroundColor = [UIColor redColor];
        [headSCView addSubview:headImag];
    }
    headSCView.delegate =self;
    headSCView.showsHorizontalScrollIndicator = NO;
    headSCView.pagingEnabled = YES;
    headSCView.contentSize = CGSizeMake(self.photosList.count*(BOUND_WIDTH), BOUND_HIGHT);
    [self.view addSubview:headSCView];
    
    //设置默认语音
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
//    
//    NSString * preferredLang = [allLanguages objectAtIndex:0];

    [InternationalControl setUserlanguage:@"zh-Hans"];

    //[InternationalConrtol setUerlanguage:@""];

    
}
-(NSMutableArray *)photosList
{
    if (!_photosList) {
        _photosList= [[NSMutableArray alloc] init];
        for (int i = 1; i<=2; i++) {
            NSString *str = [NSString stringWithFormat:@"luang_%d",i];
            UIImage *img = [UIImage imageNamed:str];
            [_photosList addObject:img];
        }
    }
    return _photosList;
}
- (void)clickHeadImage:(UITapGestureRecognizer *)tap
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:YES forKey:@"user_has_onboarded"];
    
    
    
    PRJTabBarViewController *tab = [[PRJTabBarViewController alloc] init];
    [self presentViewController:tab animated:YES completion:nil];
   // self.window.rootViewController = tab;
    
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    self.view.window.rootViewController = [storyboard instantiateInitialViewController];
}

@end
