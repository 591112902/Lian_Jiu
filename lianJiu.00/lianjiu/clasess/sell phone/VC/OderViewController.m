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
#import "OderViewController.h"

#import "OrderTableViewCell.h"


#import "OrderViewForHeader.h"
#import "OrderHeadView.h"

@interface OderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *reuseIdentifier;
    NSInteger pageNo;
    BOOL isDown;
    OrderHeadView *ohView;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;//要显示的
//@property (nonatomic,copy)NSString *orItemsParamDb;//用来对比的
@property(nonatomic,strong)NSMutableArray *duiBiDataSource;//
@end

@implementation OderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = BGColor;
    reuseIdentifier = @"OrderTableViewCell";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT) style:UITableViewStylePlain];
     [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
     [_tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
    
    
    
    
    
    ohView = [[[NSBundle mainBundle]loadNibNamed:@"OrderHeadView" owner:nil options:nil]lastObject];
    ohView.frame = CGRectMake(0, BOUND_HIGHT, [UIScreen mainScreen].bounds.size.width, 133);
    _tableView.tableHeaderView = ohView;
    
    
//    [ohView.orItemsPictureIV sd_setImageWithURL:[NSURL URLWithString:_model.orItemsPicture]];
//    ohView.orItemsPictureIV.contentMode = UIViewContentModeScaleAspectFit;
//    ohView.orItemsNameL.text = _model.orItemsName;
//    ohView.orItemsUserL.text = _model.orItemsUser;
//    ohView.hsfsL.text = _model.hsfs;
//   // ohView.orItemsPriceL.text = _model.orItemsPrice;
    
    
    
    _dataSource = [[NSMutableArray alloc] init];
    _duiBiDataSource = [[NSMutableArray alloc] init];
    [self requestData];
    
    

}
- (void)requestData{
    NSString *url;
    if (_isPhone) {
        url = QUALITYCHECKINGDETAILS;
    }else{
        url = FACEQUALITYCHECKINGDETAILS;
    }
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@",url,_orItemsId?_orItemsId:@""] withparameters:nil success:^(NSMutableDictionary *dic) {
        NSLog(@"para:%@",[NSString stringWithFormat:@"%@/%@",url,_orItemsId?_orItemsId:@""]);
        
        if ([dic[@"lianjiuData"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *lianjiuData = dic[@"lianjiuData"];
            //_orItemsParamDb = lianjiuData[@"orItemsParam"];
            
            [_dataSource removeAllObjects];
            [_duiBiDataSource removeAllObjects];
            
            
            
            [ohView.orItemsPictureIV sd_setImageWithURL:[NSURL URLWithString:lianjiuData[@"orItemsPicture"]]];
            ohView.orItemsPictureIV.contentMode = UIViewContentModeScaleAspectFit;
           
            
            ohView.orItemsNameL.text = lianjiuData[@"orItemsName"];
           // ohView.orItemsUserL.text = lianjiuData[@"orItemsUser"];
            NSString *orItemsUserS = lianjiuData[@"orItemsUser"];
            if (orItemsUserS.length>9) {
                
                NSString *tel = [orItemsUserS stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                ohView.orItemsUserL.text = [NSString stringWithFormat:@"%@",tel];
            }else{
                
                ohView.orItemsUserL.text =  [NSString stringWithFormat:@"%@",orItemsUserS];
                
            }

            
            
            
            
            
            ohView.hsfsL.text = lianjiuData[@"orItemsRecycleType"];
           // ohView.pingguPriceL.text = lianjiuData[@"orItemsPrice"];
            ohView.maichuPriceL.text = lianjiuData[@"orItemsAccountPrice"];
            
            
            NSString *timeS = lianjiuData[@"orItemsUpdated"];
            if (timeS.length>10) {
                ohView.orItemsCreatedL.text = [lianjiuData[@"orItemsUpdated"] substringToIndex:10];
                
            }else{
                ohView.orItemsCreatedL.text = lianjiuData[@"orItemsUpdated"] ;
            }
           
            
            
            
            
            
            NSString *dataStr = lianjiuData[@"orItemsParam"];
            NSData *nsData=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dataArr =[NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
            
            [_duiBiDataSource addObjectsFromArray:dataArr];
//NSLog(@"_duiBiSTRsrtstr:%@",_duiBiDataSource);
            
            
            //orItemsParamModify:一进来展示使用..       orItemsParam对比使用
            
            NSString *dataStr1 = lianjiuData[@"orItemsParamModify"];//orItemsParam.
            NSData *nsData1=[dataStr1 dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dataArr1 =[NSJSONSerialization JSONObjectWithData:nsData1 options:NSJSONReadingMutableContainers error:nil];
           
            [_dataSource addObjectsFromArray:dataArr1];

            // NSLog(@"dataStrdataStrdataStrdataStr:%@",_dataSource);
            
            
            
        }
         [_tableView reloadData];
    } error:nil HUDAddView:self.view];
    
//    [networking AFNRequestNotHUD:[NSString stringWithFormat:@"%@/%@/%zd/10",,@"",@""] withparameters:nil success:^(NSMutableDictionary *dic) {
//        
//        
////        NSDictionary *lianjiuData = dic[@"lianjiuData"];
////        NSArray *response = lianjiuData[@"product"];
////        for (NSDictionary *temp in response) {
////            ChanPinListModel *model = [ChanPinListModel ModelWith:temp ];
////            [_dataSour addObject:model];
////        }
//        [_tableView reloadData];
//    } error:nil];

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
    
    
    
    //对比如下;
    NSArray *array1 = [_duiBiDataSource[indexPath.section] objectForKey:@"children"];
    NSArray *nextArr1 = array1[indexPath.row][@"children"];
    NSString *pingNext1 = [nextArr1.firstObject objectForKey:@"major"];//20以下",
    if (![pingNext1 isEqualToString:pingNext]) {
        cell.rightImgeView.image = [UIImage imageNamed:@"gantanhao.png"];//select_lj.png
    }
    
    NSLog(@"pingNext%@  pingNext1%@",pingNext,pingNext1);
    
    
    
    
    cell.leftL.text = [NSString stringWithFormat:@"%@",chiCun];
    cell.rightL.text = [NSString stringWithFormat:@"%@",pingNext];
    
    
    
    
    
    
    if (_dataSource.count-1==indexPath.section && pingNext.length==0 ) {
        cell.leftL.hidden = YES;
        cell.rightImgeView.hidden = YES;
       cell.rightL.hidden = YES;
    }else{
        cell.leftL.hidden = NO;
        cell.rightImgeView.hidden = NO;
        cell.rightL.hidden = NO;
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
   

    
    
    
    
    NSArray *array = [_dataSource[section] objectForKey:@"children"];
    NSArray *nextArr = array.count>0?array[0][@"children"]:@[];
    NSString *pingNext = [nextArr.firstObject objectForKey:@"major"];//20以下",
    
   
    hView.HeaderL.text = [NSString stringWithFormat:@"%@(%ld项)",[_dataSource[section] objectForKey:@"major"],(long)array.count];//基本信息
    
    
    
    
    if (![[_dataSource[section] objectForKey:@"major"] isEqualToString:@"基本信息"]) {
        
        hView.leftIV.image = [UIImage imageNamed:@"qiyu"];
    }
    
    
    if (_dataSource.count-1==section && pingNext.length==0 ) {
        hView.HeaderL.hidden = YES;
        hView.selectIV.hidden = YES;
        hView.wenHeL.hidden = YES;
        hView.leftIV.hidden = YES;
    }else{
        hView.HeaderL.hidden = NO;
        hView.selectIV.hidden = NO;
        hView.wenHeL.hidden = NO;
        hView.leftIV.hidden = NO;
    }

    
    
    
    
    
    
    //对比如下;
    NSArray *array1 = [_duiBiDataSource[section] objectForKey:@"children"];
    NSArray *nextArr1 = array1.count>0?array1[0][@"children"]:@[];
    NSString *pingNext1 = [nextArr1.firstObject objectForKey:@"major"];//20以下",
    if (![pingNext1 isEqualToString:pingNext]) {//不吻合
        hView.selectIV.image = [UIImage imageNamed:@"gantanhao"];
        hView.wenHeL.text = @"不吻合";
        
    }else{//全部合格
        hView.wenHeL.text = @"全部合格";
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
