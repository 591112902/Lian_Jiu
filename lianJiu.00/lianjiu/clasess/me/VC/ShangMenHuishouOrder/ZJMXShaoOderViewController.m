//
//  OderViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/12.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//
#define GROUP_NAME @"NAME"
//#define GROUP_STATE @"NAME1"
#define GROUP_CONTENT @"NAME2"
#import "ZJMXShaoOderViewController.h"

#import "OrderTableViewCell.h"


#import "OrderViewForHeader.h"
#import "OrderHeadView.h"

@interface ZJMXShaoOderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    UIButton *bottomBtn;

}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation ZJMXShaoOderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = BGColor;
    reuseIdentifier = @"OrderTableViewCell";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT-44) style:UITableViewStylePlain];
     [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
     [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, BOUND_HIGHT-44, BOUND_WIDTH, 44);
    bottomBtn.backgroundColor = MAINColor;
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
//    OrderHeadView *hView = [[[NSBundle mainBundle]loadNibNamed:@"OrderHeadView" owner:nil options:nil]lastObject];
//    hView.frame = CGRectMake(0, BOUND_HIGHT, [UIScreen mainScreen].bounds.size.width, 133);
//    _tableView.tableHeaderView = hView;
    
    
    
    
    
    
     _dataSource = [[NSMutableArray alloc] init];

   
    NSString *url;
    if (_isPhone) {
        url = QUALITYCHECKINGDETAILS;
    }else{
        url = FACEQUALITYCHECKINGDETAILS;
    }

    
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",url,_orItemsId?_orItemsId:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"SHaopara:%@",[NSString stringWithFormat:@"%@/%@",url,_orItemsId?_orItemsId:@""]);
        
       
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * lianjiuData = dic[@"lianjiuData"];
            NSString *dataStr = lianjiuData[@"orItemsParam"];
            NSData *nsData=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dataArr =[NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
            
            [bottomBtn setTitle:[NSString stringWithFormat:@"评估价格:%@元",lianjiuData[@"orItemsPrice"]?lianjiuData[@"orItemsPrice"]:@""] forState:UIControlStateNormal];
            
            
            // NSArray *children = [dataArr[0] objectForKey:@"children"];
            NSLog(@"dataStrdataStrdataStrdataStr:%@",dataStr);
            
            [_dataSource addObjectsFromArray:dataArr];
            [_tableView reloadData];
        }
        
        
    } error:nil HUDAddView:self.view];
    

}
#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 大数组的长度是我要加载的分区个数
    return _dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 每一个小数组的长度是每一个分区要展示数据的行数
//    NSDictionary *dic =[_dataSource objectAtIndex:section] ;
//    return [[dic objectForKey:GROUP_CONTENT] count];
    
  return   [[_dataSource[section] objectForKey:@"children"] count];
    
   // return [[_dataSource objectAtIndex:section] count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightL.hidden = YES;
    cell.rightImgeView.hidden = YES;
//    // 内容设置
//    NSDictionary *dic = [_dataSource objectAtIndex:indexPath.section];
//    NSArray *array=[dic objectForKey:GROUP_CONTENT];
//    
//    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    //尺寸
    NSArray *array = [_dataSource[indexPath.section] objectForKey:@"children"];
    
   NSString *chiCun = [array[indexPath.row] objectForKey:@"major"];//尺寸

    NSArray *nextArr = array[indexPath.row][@"children"];
    
   NSString *pingNext = [nextArr.firstObject objectForKey:@"major"];//20以下",
    
    
    cell.leftL.text = [NSString stringWithFormat:@"%@: %@",chiCun,pingNext];
    
    
    
    
    
    
    if (_dataSource.count-1==indexPath.section && pingNext.length==0 ) {
        cell.leftL.hidden = YES;
//        cell.rightImgeView.hidden = YES;
//        cell.rightL.hidden = YES;
    }else{
        cell.leftL.hidden = NO;
//        cell.rightImgeView.hidden = YES;
//        cell.rightL.hidden = YES;
    }

    
    
    
    
    return cell;
}
// 设置行高为60
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

// 设置分区view标题
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        
    OrderViewForHeader *hView = [[[NSBundle mainBundle]loadNibNamed:@"OrderViewForHeader" owner:nil options:nil]lastObject];
    hView.frame = CGRectMake(0, BOUND_HIGHT, [UIScreen mainScreen].bounds.size.width, 44);
    hView.wenHeL.hidden = YES;
    hView.selectIV.hidden = YES;

    hView.HeaderL.text =[_dataSource[section] objectForKey:@"major"];//基本信息
    
    
    
    
    
    
    
    
    NSArray *array = [_dataSource[section] objectForKey:@"children"];
    NSArray *nextArr = array.count>0?array[0][@"children"]:@[];
    NSString *pingNext = [nextArr.firstObject objectForKey:@"major"];//20以下",
    if (_dataSource.count-1==section && pingNext.length==0 ) {
        hView.HeaderL.hidden = YES;
//        hView.selectIV.hidden = YES;
//        hView.wenHeL.hidden = YES;
        hView.leftIV.hidden = YES;
    }else{
        hView.HeaderL.hidden = NO;
//        hView.selectIV.hidden = YES;
//        
//        hView.wenHeL.hidden = YES;
        hView.leftIV.hidden = NO;
    }

    
    
    
    
//    UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
//    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [b setTitle:[NSString stringWithFormat:@"机器型号%zd                                  %zd/%zd       ",section+1,section+3,section+99] forState:UIControlStateNormal];
//    
//    
//    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    b.frame=CGRectMake(0, 0, BOUND_WIDTH, 40);
//    b.backgroundColor=[UIColor whiteColor];
//    b.tag=section+100;
    
    return hView;
    
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

@end
