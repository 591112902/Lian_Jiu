

#import "QiYeRecycleVC.h"
#import "SDCycleScrollView.h"
#import "UITextView+YLTextView.h"

#import "ZSWViewController.h"
#import "UIImageView+WebCache.h"
#import "NewViewController.h"

@interface QiYeRecycleVC ()<SDCycleScrollViewDelegate>
{
    UIScrollView *_scrollV;
    CGFloat _scrollVH;
    SDCycleScrollView *cycleScrollView;//滚动视图
    NSMutableArray *scrollPhotoList;
    
    
    UITextField *qymcTF;UITextField *lxrTF;UITextField *lxdhTF;UITextField *lxdzBtn;UITextField *mphTF;UITextView *hswpTV;
}


@property (nonatomic, strong) AMapPOI *model;

@end

@implementation QiYeRecycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ADDCarousel];
    
    self.title = @"企业回收";
    
    
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];
    //图片轮播器
    CGFloat headImageH = BOUND_WIDTH/750.0*300;
    // 本地加载 --- 创建不带标题的图片轮播器
    cycleScrollView = [[SDCycleScrollView alloc ] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, headImageH)];
    cycleScrollView.backgroundColor = BGColor;
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.dotColor = MAINColor; // 自定义分页控件小圆标颜色
    cycleScrollView.imageURLStringsGroup =@[@"qhshead"];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"qhshead"];
    [_scrollV addSubview:cycleScrollView];
    _scrollVH +=5+headImageH;
    
    
    
    CGFloat imgH = BOUND_WIDTH*0.245;
    UIView *pinzhiV = [[UIView alloc] init];
    pinzhiV.backgroundColor = [UIColor whiteColor];
    pinzhiV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, imgH);
    _scrollVH +=imgH;
    [_scrollV addSubview:pinzhiV];
    
    
    
    UIImageView *biv1 =[[UIImageView alloc] init];
    biv1.image = [UIImage imageNamed:@"qhsleft1"];
    //biv1.backgroundColor = [UIColor greenColor];
    biv1.frame = CGRectMake(0, 0, (BOUND_WIDTH-10)/3.0, imgH);
    [pinzhiV addSubview:biv1];
    
    UIImageView *biv2 =[[UIImageView alloc] init];
    biv2.image = [UIImage imageNamed:@"qhsceter2"];
    // biv2.backgroundColor = [UIColor greenColor];
    biv2.frame = CGRectMake((BOUND_WIDTH-10)/3.0+5, 0, (BOUND_WIDTH-10)/3.0, imgH);
    [pinzhiV addSubview:biv2];
    
    UIImageView *biv3 =[[UIImageView alloc] init];
    biv3.image = [UIImage imageNamed:@"qhsright3"];
    // biv3.backgroundColor = [UIColor greenColor];
    biv3.frame = CGRectMake(((BOUND_WIDTH-10)/3.0+5)*2, 0, (BOUND_WIDTH-10)/3.0, imgH);
    [pinzhiV addSubview:biv3];
    
    _scrollVH +=5;
    
    
    
    UIView *remaiqianV = [[UIView alloc] init];
    remaiqianV.backgroundColor = [UIColor whiteColor];
    remaiqianV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 350);
    _scrollVH +=350;
    [_scrollV addSubview:remaiqianV];
    
    UILabel *qymcLabel = [[UILabel alloc] init];
    qymcLabel.text = @"企业名称:";
    qymcLabel.textColor = [UIColor darkGrayColor];
    qymcLabel.font = PFR15Font;
    qymcLabel.textAlignment = NSTextAlignmentLeft;
    qymcLabel.frame = CGRectMake(10, 10, 90, 35);
    [remaiqianV addSubview:qymcLabel];
    qymcTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, BOUND_WIDTH-110, 30)];
    qymcTF.borderStyle = UITextBorderStyleRoundedRect;
    [remaiqianV addSubview:qymcTF];
    
    UILabel *lxrLabel = [[UILabel alloc] init];
    lxrLabel.text = @"联系人:";
    lxrLabel.textColor = [UIColor darkGrayColor];
    lxrLabel.font = PFR15Font;
    lxrLabel.textAlignment = NSTextAlignmentLeft;
    lxrLabel.frame = CGRectMake(10, 10+45, 90, 35);
    [remaiqianV addSubview:lxrLabel];
    lxrTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 13+45, BOUND_WIDTH-110, 30)];
    lxrTF.borderStyle = UITextBorderStyleRoundedRect;
    [remaiqianV addSubview:lxrTF];
    
    
    UILabel *lxdhLabel = [[UILabel alloc] init];
    lxdhLabel.text = @"联系电话:";
    lxdhLabel.textColor = [UIColor darkGrayColor];
    lxdhLabel.font = PFR15Font;
    lxdhLabel.textAlignment = NSTextAlignmentLeft;
    lxdhLabel.frame = CGRectMake(10, 10+45*2, 90, 35);
    [remaiqianV addSubview:lxdhLabel];
    lxdhTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 13+45*2, BOUND_WIDTH-110, 30)];
    lxdhTF.borderStyle = UITextBorderStyleRoundedRect;
    [remaiqianV addSubview:lxdhTF];
    
    
    
    //    UILabel *lxdzLabel = [[UILabel alloc] init];
    //    lxdzLabel.text = @"联系地址:";
    //    lxdzLabel.textColor = [UIColor darkGrayColor];
    //    lxdzLabel.font = PFR15Font;
    //    lxdzLabel.textAlignment = NSTextAlignmentLeft;
    //    lxdzLabel.frame = CGRectMake(10, 10+45*3, 90, 35);
    //    [remaiqianV addSubview:lxdzLabel];
    //
    //    lxdzBtn = [[UITextField alloc] init];
    //    lxdzBtn.borderStyle = UITextBorderStyleRoundedRect;
    //    [remaiqianV addSubview:lxdzBtn];
    //    UIImageView *jiantouV = [[UIImageView alloc] init];
    //    jiantouV.frame = CGRectMake(BOUND_WIDTH -35, 13+45*3  +7, 10, 17);
    //    jiantouV.image = [UIImage imageNamed:@"jiantou.png"];
    //    [remaiqianV addSubview:jiantouV];
    
    
    
    
    UILabel *mphLabel = [[UILabel alloc] init];
    mphLabel.text = @"联系地址:";
    mphLabel.textColor = [UIColor darkGrayColor];
    mphLabel.font = PFR15Font;
    mphLabel.textAlignment = NSTextAlignmentLeft;
    mphLabel.frame = CGRectMake(10, 10+45*3, 90, 35);
    [remaiqianV addSubview:mphLabel];
    mphTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 13+45*3, BOUND_WIDTH-110, 30)];
    mphTF.borderStyle = UITextBorderStyleRoundedRect;
    [remaiqianV addSubview:mphTF];
    
    
    
    
    UILabel *hswpLabel = [[UILabel alloc] init];
    hswpLabel.text = @"回收物品:";
    hswpLabel.textColor = [UIColor darkGrayColor];
    hswpLabel.font = PFR15Font;
    hswpLabel.textAlignment = NSTextAlignmentLeft;
    hswpLabel.frame = CGRectMake(10, 10+45*4, 90, 35);
    [remaiqianV addSubview:hswpLabel];
    hswpTV = [[UITextView alloc] initWithFrame:CGRectMake(90, 13+45*4, BOUND_WIDTH-110, 100)];
    hswpTV.placeholder = @"如办公室电脑10台";
    hswpTV.layer.borderWidth = 1;
    hswpTV.layer.borderColor = BGColor.CGColor;
    hswpTV.layer.cornerRadius = 3;
    [remaiqianV addSubview:hswpTV];
    
    
    
    _scrollVH  += 30;
    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(10, _scrollVH, BOUND_WIDTH-20, 44);
    commitBtn.layer.cornerRadius = 5;
    commitBtn.backgroundColor = MAINColor;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollV addSubview:commitBtn];
    
    _scrollVH+=44;
    
    UILabel *quxiaoTS = [[UILabel alloc] initWithFrame:CGRectMake(10, _scrollVH , BOUND_WIDTH-20, 44)];
    quxiaoTS.text = @"提交成功后,工作人员将在24小时内与你联系";
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

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)commitBtnClick{
    if (qymcTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"企业名称未填写" toView:self.view];
        return;
    }
    if (lxrTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"联系人未填写" toView:self.view];
        return;
    }
    if (lxdhTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"联系电话未填写" toView:self.view];
        return;
    }
    //    if (lxdzBtn.text.length==0) {//请选择联系地址
    //        [MBProgressHUD showNotPhotoError:@"请选择联系地址" toView:self.view];
    //        return;
    //    }
    if (mphTF.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"联系地址未填写" toView:self.view];
        return;
    }
    if (hswpTV.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"回收物品未填写" toView:self.view];
        return;
    }
    
    //[NSString stringWithFormat:@"%@ %@",self.model.name,mphTF.text]
    [networking AFNPOST:ADDCOMPANY withparameters:@{@"orCompanyName":qymcTF.text,@"orCompanyUser":lxrTF.text,@"orCompanyPhone":lxdhTF.text,@"orCompanyLocation":[NSString stringWithFormat:@"%@",mphTF.text],@"orCompanyProducts":hswpTV.text} success:^(NSMutableDictionary *dic) {
        
        
        
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            qymcTF.text = @"";lxrTF.text = @"";
            lxdhTF.text = @"";
            mphTF.text = @"";
            hswpTV.text = @"";
            
            
            
            
            // [self.navigationController popViewControllerAnimated:YES];
        }];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];
        
        
        
        
    } error:nil HUDAddView:self.view];
    
    
    
}
-(void)lxdzBtnClick{
    //    NewViewController *mapVC = [[NewViewController alloc] init];
    //
    //
    //    mapVC.sendAMapAPIBlock = ^(AMapPOI *poi) {
    //        self.model = poi;
    //        
    //        [lxdzBtn setTitle:[NSString stringWithFormat:@"%@",poi.name] forState:UIControlStateNormal];
    //    };
    //
    //    [self.navigationController pushViewController:mapVC animated:YES];
    
}

@end
