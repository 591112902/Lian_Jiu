//
//  ScrapDetailViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/8.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "ScrapDetailViewController.h"
#import "ScrapDetailTableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface ScrapDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation ScrapDetailViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
     CALayer *layer;
    EvaluateFooterView *footerView;ScrapDetailFooterView *footerView2;
    //float _priceCount;
    
   // NSString * number;
    UILabel *manSHIYuanL;
     UIWebView *_webView;
}
-(void)clickkefuView:(UITapGestureRecognizer *)tap{
    // 提示：不要将webView添加到self.view，如果添加会遮挡原有的视图
    // 懒加载
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://4001818209"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}
-(void)clickhscView:(UITapGestureRecognizer *)tap{
    //回收车
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [def boolForKey:@"islogin"];
    if (!islogin) {
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否登录？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self.tabBarController presentViewController:nav animated:YES completion:^{
            }];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

       // [MBProgressHUD showNotPhotoError:@"尚未登录" toView:self.view];
        return;
    }
    
    
    //回收车
    CallBackCarViewController *uvc = [[CallBackCarViewController alloc] init];
    uvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uvc animated:YES];
}
-(void)hscBtnAction{
    
    
    
    NSLog(@"_wPriceSingle:%@   %@",_wPriceSingle,_wPriceUnit);
    //加入回收车
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [def boolForKey:@"islogin"];
    NSString *uid = [def objectForKey:@"userId"];
    if (!islogin) {
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否登录？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self.tabBarController presentViewController:nav animated:YES completion:^{
            }];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

       // [MBProgressHUD showNotPhotoError:@"尚未登录" toView:self.view];
        return;
    }
    
  
    
    UITextField *numberTF = [_tableView viewWithTag:560000];
    
    if (numberTF.text.floatValue<=0) {
        [MBProgressHUD showNotPhotoError:@"请输入数量！" toView:self.view];

    } else {
        
        NSLog(@"withparameters:%@",@{@"orItemsProductId":_wPriceId,@"orItemsName":_name?_name:@"",@"orItemsPicture":_wasteImage?_wasteImage:@"",@"orItemsStemFrom":@"3",@"orItemsPrice":_wPriceSingle? _wPriceSingle:@"",@"orItemsPriceUnit":_wPriceUnit?_wPriceUnit:@"",@"userId":uid,@"orItemsNum":[NSString stringWithFormat:@"%.2f",numberTF.text.floatValue]});
        
        
        
        
//        if (jiaDianClick.length>0) {
//            [MBProgressHUD showNotPhotoError:@"该商品已加入回收车" toView:self.view];
//            return;
//        }
//
        
        
        [networking AFNPOST:INTRODUCTIONWASTE withparameters:@{@"orItemsProductId":_wPriceId,@"orItemsName":_name?_name:@"",@"orItemsPicture":_wasteImage?_wasteImage:@"",@"orItemsStemFrom":@"3",@"orItemsPrice":_wPriceSingle? _wPriceSingle:@"",@"orItemsPriceUnit":_wPriceUnit?_wPriceUnit:@"",@"userId":uid,@"orItemsNum":[NSString stringWithFormat:@"%.2f",numberTF.text.floatValue]} success:^(NSMutableDictionary *dic) {
            
            
            if (!layer) {
               
                
                layer = [CALayer layer];//test0n.png
                layer.contents = (__bridge id)[UIImage imageNamed:@"test0n.png"].CGImage;
                layer.contentsGravity = kCAGravityResizeAspectFill;
                layer.bounds = CGRectMake(0, 0, 25, 25);
                [layer setCornerRadius:CGRectGetHeight([layer bounds]) / 2];
                layer.masksToBounds = YES;
                layer.position =CGPointMake(50, 150);
                [self.view.layer addSublayer:layer];
            }
            [self groupAnimation];
            
        } error:nil HUDAddView:self.view];
    }
}
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 1.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 1.0f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [layer addAnimation:groups forKey:@"group"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    [anim def];
    if (anim == [layer animationForKey:@"group"]) {
        //_btn.enabled = YES;
        
        [layer removeFromSuperlayer];
        layer = nil;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [footerView.recycleImageView.layer addAnimation:shakeAnimation forKey:nil];
        
        [MBProgressHUD showNotPhotoError:@"加入回收车成功" toView:[UIApplication sharedApplication].keyWindow];
        
        
        UITextField *numberTF = [_tableView viewWithTag:560000];
        numberTF.text = @"";
        
    }
}

-(void)sellBtnAction{
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [def boolForKey:@"islogin"];
    if (!islogin) {
        //提示框
        UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否登录？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self.tabBarController presentViewController:nav animated:YES completion:^{
            }];
            
            
        }];
        [clear addAction:quXiao];
        [clear addAction:queRen];
        [self presentViewController:clear animated:YES completion:nil];

       // [MBProgressHUD showNotPhotoError:@"尚未登录" toView:self.view];
        return;
    }

    
    UITextField *numberTF = [_tableView viewWithTag:560000];
    
    UILabel *hsjgLabel = [_tableView viewWithTag:160000];
    if (hsjgLabel.text.floatValue < 10.00) {//
        [MBProgressHUD showNotPhotoError:@"需要满10元才可以提交订单" toView:self.view];
    } else {
        
        UILabel *hsjgLabel = [_tableView viewWithTag:160000];
        
        //家电--上门
        // [footerView.sellBtn setTitle:@"上门回收" forState:UIControlStateNormal];
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *usid = [def objectForKey:@"userId"];
       
        //@"orItemsPriceUnit":@""
        [networking AFNPOST:DIRECTSUBWASTE withparameters:@{@"orItemsProductId":_wPriceId?_wPriceId:@"",@"orItemsName":_name?_name:@"",@"orItemsPicture":_wasteImage,@"orItemsPrice":_wPriceSingle,@"userId":usid?usid:@"",@"orItemsNum":[NSString stringWithFormat:@"%.2f",numberTF.text.floatValue],@"orItemsStemFrom":@"3",@"orItemsPriceUnit":_wPriceUnit?_wPriceUnit:@""} success:^(NSMutableDictionary *dic) {
            
            NSLog(@"家电--上门%@",dic);
            NSDictionary *lianjiuData = dic[@"lianjiuData"];
            NSString *imageStr = lianjiuData[@"maximage"];
            NSArray *plArr = lianjiuData[@"productIdList"];
            NSString *totalprice = lianjiuData[@"totalprice"];
         
            
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *userId = [user objectForKey:@"userId"];
            AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            UIView *superView = [UIApplication sharedApplication].keyWindow;
            [MBProgressHUD showHUDAddedTo:superView animated:YES];
            [manager GET:[NSString stringWithFormat:@"%@/%@",SELECTADDRESSDEFAULT,userId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSNumber *code=dic[@"status"];
                int c = [code intValue];
                
                if (c==200) {
                    
                    NSDictionary *lianjiuData = [dic objectForKey:@"lianjiuData"];
                    NSDictionary *address = [lianjiuData objectForKey:@"address"];
                    BOOL b = (BOOL)[address objectForKey:@"userDefault"];
                    
                    
                    ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                    smVC.price = hsjgLabel.text;
                    smVC.userDefault = b;
                    smVC.address = address;
                    smVC.goodImageViewStr = imageStr;
                    if (plArr.count>0) {
                        smVC.productIdList = plArr[0];
                    }
                    [self.navigationController pushViewController:smVC animated:YES];
                    
                    
                }else if (c==500) {//没有设置默认地址",
                    
                    ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                    smVC.price = hsjgLabel.text;
                    smVC.userDefault = NO;
                    smVC.goodImageViewStr = imageStr;
                    if (plArr.count>0) {
                        smVC.productIdList = plArr[0];
                    }
                    [self.navigationController pushViewController:smVC animated:YES];
                    
                    
                }else{
                    
                    ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                    smVC.price = hsjgLabel.text;
                    smVC.userDefault = NO;
                    smVC.goodImageViewStr = imageStr;
                    if (plArr.count>0) {
                        smVC.productIdList = plArr[0];
                    }
                    [self.navigationController pushViewController:smVC animated:YES];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:superView animated:NO];
                [MBProgressHUD showError:@"网络不给力" toView:superView];
            }];
            
        } error:nil HUDAddView:self.view];
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    footerView = [[[NSBundle mainBundle]loadNibNamed:@"EvaluateFooterView" owner:nil options:nil]lastObject];
    footerView.frame = CGRectMake(0, BOUND_HIGHT-50, [UIScreen mainScreen].bounds.size.width, 50);
    
    UITapGestureRecognizer *kefuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickkefuView:)];
    [footerView.kefuView addGestureRecognizer:kefuTap];
    footerView.kefuView.userInteractionEnabled = YES;
    
    [footerView.sellBtn setTitle:@"上门回收" forState:UIControlStateNormal];
    UITapGestureRecognizer *hscTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhscView:)];
    [footerView.huishoucheView addGestureRecognizer:hscTap];
    footerView.huishoucheView.userInteractionEnabled = YES;
    [footerView.hscBtn addTarget:self action:@selector(hscBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView.sellBtn addTarget:self action:@selector(sellBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   footerView2 = [[[NSBundle mainBundle]loadNibNamed:@"ScrapDetailFooterView" owner:nil options:nil]lastObject];
    footerView2.frame = CGRectMake(0, BOUND_HIGHT-50, [UIScreen mainScreen].bounds.size.width, 50);
    
    UITapGestureRecognizer *kefuTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickkefuView:)];
    [footerView2.kefuView addGestureRecognizer:kefuTap2];
    footerView2.kefuView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *hscTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhscView:)];
    [footerView2.huishoucheView addGestureRecognizer:hscTap2];
    footerView2.huishoucheView.userInteractionEnabled = YES;
    
    [footerView2.hscBtn addTarget:self action:@selector(hscBtnAction) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    
    
   
    manSHIYuanL = [[UILabel alloc] init];
    manSHIYuanL.frame =  CGRectMake(0, BOUND_HIGHT-50 -30, [UIScreen mainScreen].bounds.size.width, 30);
    manSHIYuanL.font = [UIFont systemFontOfSize:13];
    manSHIYuanL.text = @"需要满10元才可以提交订单，可先加入回收车哟";
    manSHIYuanL.textAlignment = NSTextAlignmentCenter;
    manSHIYuanL.textColor  = [UIColor lightGrayColor];
   
    
    
    
    
    
    self.view.backgroundColor = BGColor;
    reuseIdentifier = @"ScrapDetailTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = BGColor;
    
     [self requestData];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
     [self.view addSubview:footerView2];
    [self.view addSubview:manSHIYuanL];
    
    [self.view layoutSubviews];
    
    
    
    
    self.path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/8.0*5, [UIScreen mainScreen].bounds.size.height-50)];
    [_path addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/8.0*3, [UIScreen mainScreen].bounds.size.height-50) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0)];

}

- (void)requestData{
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",GETWASTEDETAILS,_wPriceId] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"%@",dic);
        NSDictionary *temp = dic[@"lianjiuData"];
        [_dataSour addObject:temp];
        [_tableView reloadData];

    } error:nil HUDAddView:self.view];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSour.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString* identifier = @"gczCell";
    ScrapDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ScrapDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

   
    
   // ScrapDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (_dataSour.count>0) {
        
        NSString *danwei ;NSString *wPriceUnit =[NSString stringWithFormat:@"%@",[_dataSour[0] objectForKey:@"wPriceUnit"]];
        if ([wPriceUnit isEqualToString:@"0"]) {
            danwei = @"米";
        }else if ([wPriceUnit isEqualToString:@"1"]) {
            danwei = @"个";
        }else if ([wPriceUnit isEqualToString:@"2"]) {
            danwei = @"克";
        }else if ([wPriceUnit isEqualToString:@"3"]) {
            danwei = @"千克";
        }else if ([wPriceUnit isEqualToString:@"4"]) {
            danwei = @"台";
        }else if ([wPriceUnit isEqualToString:@"5"]) {
            danwei = @"斤";
        }else if ([wPriceUnit isEqualToString:@"6"]) {
            danwei = @"公斤";
        }else if ([wPriceUnit isEqualToString:@"7"]) {
            danwei = @"部";
        }
        cell.danweiL.text = danwei;
        
        
        
        cell.rightL4.tag = 160000;
        cell.rightL1.text = [_dataSour[0] objectForKey:@"name"];
        
        cell.rightL2.text = [NSString stringWithFormat:@"%@元/%@",[_dataSour[0] objectForKey:@"wPriceSingle"],danwei];//单价
        // cell.rightL.text = moel.name;//数量
        
        
        cell.numberTextField.delegate = self;
        cell.numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.numberTextField.tag =560000;
//        cell.numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
//            NSLog(@"num:%ld",(long)num);
//            
//            number = [NSString stringWithFormat:@"%ld",(long)num];
//            NSLog(@"num:%ld  number%@",num ,number);
//            NSString *danjia = [_dataSour[0] objectForKey:@"wPriceSingle"];
//            cell.rightL4.text = [NSString stringWithFormat:@"%.2f元",[danjia floatValue]*num];//回收价格
//        
//            
//            _priceCount = [cell.rightL4.text floatValue];
//            
//        };
//        cell.numberButton.tag = 2323;
//       btnCurrentNumber = [NSString stringWithFormat:@"%zd",cell.numberButton.currentNumber];
       // cell.numberButton.currentNumber =  [[NSString stringWithFormat:@"%@",[_dataSour[0] objectForKey:@"wPriceUnit"]] integerValue];//数量
        [cell.iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dataSour[0] objectForKey:@"wasteImage"]]] placeholderImage:nil];
        
        
        
        
        _wPriceSingle = [_dataSour[0] objectForKey:@"wPriceSingle"];//orItemsPrice价格，单价price
        _wPriceUnit =[_dataSour[0] objectForKey:@"wPriceUnit"];
        
        _wasteImage =[_dataSour[0] objectForKey:@"wasteImage"];
        
    }
    
             
//        ScrapDetailModel *moel = _dataSour[indexPath.row];//只有一个数据. 
//        cell.rightL1.text = moel.name;
//        cell.rightL2.text = moel.wPriceSingle;
//       // cell.rightL.text = moel.name;//数量
//        cell.rightL4.text = moel.wPriceUnit;

          //  [cell fillCellWithModel:moel];
    
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return [UIScreen mainScreen].bounds.size.width/320.0*150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - uitextFileDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]&&textField.text.length<1) {
        return NO;
    }
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toString.length > 0) {//(\\+|\\-)?
        //正则表达式，可输入正负，小数点前10位，小数点后2位，位数可控
        NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,9}(([.]\\d{0,2})?)))?";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        BOOL flag = [phoneTest evaluateWithObject:toString];
        if (!flag) {
            return NO;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField

{
    UILabel *hsjgL = [_tableView viewWithTag:160000];
    hsjgL.text = [NSString stringWithFormat:@"%.2f元",[_wPriceSingle floatValue]*textField.text.floatValue];//回收价格
    
  
    if (hsjgL.text.floatValue >= 10.00) {//
      
        [manSHIYuanL removeFromSuperview];
        [footerView2 removeFromSuperview];
        [self.view addSubview:footerView];
    }
    
    
}
@end
