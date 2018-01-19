//
//  ScrapDetailViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/8.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "JianDianBtnNextViewController.h"
#import "ScrapDetailTableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface JianDianBtnNextViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@end

@implementation JianDianBtnNextViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataSour;
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    
    
   // float _priceCount;
  
    
}
-(void)clickkefuView{
    //UIView *imgeV = (UIImageView *)tap.view;
   // [MBProgressHUD showNotPhotoError:@"点击了联系客服" toView:self.view];
    
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001818209"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}

-(void)sureAddBtnClick{
    
    NSLog(@"_wPriceSingle:%@   %@",_wPriceSingle,_wPriceUnit);
    //加单-添加
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
    
  // float price =  [_wPriceSingle floatValue]* [_wPriceUnit floatValue];
    
   UITextField *numberTF = [_tableView viewWithTag:560000];
    
  //  PPNumberButton *btn = [_tableView viewWithTag:2323];
   
    
  //  NSLog(@"btnCurrentNumber:%ld", (long)btn.currentNumber);
    
    
   
    if (numberTF.text.floatValue<=0) {
        [MBProgressHUD showNotPhotoError:@"您尚未选择回收物品！" toView:self.view];

    } else {//_wasteImage
        [networking AFNPOST:ADDWASTE withparameters:@{@"orItemsProductId":_wPriceId,@"orItemsName":_name?_name:@"",@"orItemsPicture":_wasteImage?_wasteImage:@"",@"orItemsPrice": _wPriceSingle? _wPriceSingle:@"",@"orItemsPriceUnit":_wPriceUnit?_wPriceUnit:@"",@"userId":uid,@"orItemsNum":[NSString stringWithFormat:@"%f",numberTF.text.floatValue]} success:^(NSMutableDictionary *dic) {
            
            [MBProgressHUD showNotPhotoError:@"成功加入" toView:self.view];
            
            
            
#pragma mark-返回至指定页面====
                UIViewController *viewCtl = self.navigationController.viewControllers[2];
                [self.navigationController popToViewController:viewCtl animated:YES];

            
            
        } error:nil HUDAddView:self.view];
    }
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    self.title = [NSString stringWithFormat:@"%@",_name];
    
     CGFloat subViewH2 = BOUND_WIDTH/320.0*44;
    
    UIButton *jdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jdBtn.frame = CGRectMake(0, BOUND_HIGHT-subViewH2, BOUND_WIDTH/2.0, subViewH2);
    [jdBtn setBackgroundImage:[UIImage imageNamed:@"jiaDanImage"] forState:UIControlStateNormal];//
    //[jdBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [jdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    [jdBtn addTarget:self action:@selector(clickkefuView) forControlEvents:UIControlEventTouchUpInside];
    [jdBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:jdBtn];
    
    
    
    
    UIButton *jdjsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jdjsBtn.frame = CGRectMake(BOUND_WIDTH/2.0, BOUND_HIGHT-subViewH2, BOUND_WIDTH/2.0, subViewH2);
    
    [jdjsBtn setTitle:@"加单" forState:UIControlStateNormal];
    [jdjsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jdjsBtn addTarget:self action:@selector(sureAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [jdjsBtn setBackgroundColor:MAINColor];
    [self.view addSubview:jdjsBtn];

    
    
    
    
    
    
    
    
    
    
    
    self.view.backgroundColor = BGColor;
    reuseIdentifier = @"ScrapDetailTableViewCell";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BOUND_WIDTH, BOUND_HIGHT-subViewH2-64)];
    [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataSour = [[NSMutableArray alloc] init];
    _tableView.backgroundColor = BGColor;
    
     [self requestData];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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

        
        
         cell.rightL4.tag = 160000;
        
        cell.rightL1.text = [_dataSour[0] objectForKey:@"name"];
        
        cell.rightL2.text = [NSString stringWithFormat:@"%@元/%@",[_dataSour[0] objectForKey:@"wPriceSingle"],danwei];//单价
        // cell.rightL.text = moel.name;//数量
        
        
        cell.numberTextField.delegate = self;
        cell.numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.numberTextField.tag =560000;

        
//        cell.numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
//          //  NSLog(@"num:%ld",num);
//            NSString *danjia = [_dataSour[0] objectForKey:@"wPriceSingle"];
//            cell.rightL4.text = [NSString stringWithFormat:@"%.2f元",[danjia floatValue]*num];//回收价格
//            _priceCount = [cell.rightL4.text floatValue];
//            
//        };

        
        
       // cell.numberButton.tag = 2323;
//       btnCurrentNumber = [NSString stringWithFormat:@"%zd",cell.numberButton.currentNumber];
       // cell.numberButton.currentNumber =  [[NSString stringWithFormat:@"%@",[_dataSour[0] objectForKey:@"wPriceUnit"]] integerValue];//数量
        [cell.iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dataSour[0] objectForKey:@"wasteImage"]]] placeholderImage:nil];
        
        
        
        _wPriceSingle = [_dataSour[0] objectForKey:@"wPriceSingle"];
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
       return 150;
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
}

@end
