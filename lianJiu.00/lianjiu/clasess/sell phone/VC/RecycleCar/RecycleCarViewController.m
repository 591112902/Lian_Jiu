//
//  ShoppingCarVC.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "RecycleCarViewController.h"
#import "UConstants.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"

#import "ExpressRecycleOrderVC.h"


@interface RecycleCarViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingCarCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮

@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额

@property(nonatomic,assign) double allPrice;

@end

@implementation RecycleCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.dataArray = [[NSMutableArray alloc]init];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//    @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.allPrice = 0.00;
    [self createSubViews];
    [self initData];
}
/**
 * 初始化假数据
 */

-(void)initData{
    
  //  SELECTPRODUCTFROMCAR
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *UID = [def objectForKey:@"userId"];
    
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/userId",SELECTPRODUCTFROMCAR,@"LJ1507790108765"] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        
        
        
        NSDictionary *lianjiuData = [dic objectForKey:@"lianjiuData"];
        if ([lianjiuData[@"expressList"] isKindOfClass:[NSArray class]]) {
            
            
            for (NSDictionary *temp in lianjiuData[@"expressList"]) {
                
                ShoppingModel *goodsModel = [[ShoppingModel alloc]initWithShopDict:temp];
                
                goodsModel.selectState = NO;
                
                [self.dataArray addObject:goodsModel];
            }
            
        }
        
        
        [_tableView reloadData];

        
        
    } error:nil HUDAddView:self.view];
    
    
    
    
//        for (int i = 0; i<10; i++)
//    {
//        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
//        [infoDict setValue:@"img.png" forKey:@"imageName"];
//        [infoDict setValue:@"小皮皮" forKey:@"goodsTitle"];
//        [infoDict setValue:@"Miss?怎么可能..." forKey:@"goodsType"];
//        [infoDict setValue:@"50.00元" forKey:@"goodsPrice"];
//        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
//        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
//      
//        ShoppingModel *goodsModel = [[ShoppingModel alloc]initWithShopDict:infoDict];
//       
//        [self.dataArray addObject:goodsModel];
//    }
    
    
}

-(void)createSubViews{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth, kScreenHeight-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(10,self.tableView.bottom+(50-20)/2.0, 60, 20);
    [self.selectAllBtn setImage:IMAGENAMED(@"check_n") forState:UIControlStateNormal];
    [self.selectAllBtn setImage:IMAGENAMED(@"check_p") forState:UIControlStateSelected];
    [self.selectAllBtn addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectAllBtn.titleLabel.font = SYSTEMFONT(15.0);
    self.selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.selectAllBtn];
    

    
    self.totalMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(self.selectAllBtn.right+10, self.selectAllBtn.top, kScreenWidth-self.selectAllBtn.right-30-GetWidth(184),20)];

    self.totalMoneyLab.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLab.font = SYSTEMFONT(13.0);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:SYSTEMFONT(17) range:NSMakeRange(3,str.length-3)];
    [str addAttribute:NSForegroundColorAttributeName value:MAINColor range:NSMakeRange(3,str.length-3)];
    self.totalMoneyLab.attributedText = str;
    
    
    [self.view addSubview:self.totalMoneyLab];
    
    
    self.jieSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBtn.frame = CGRectMake(kScreenWidth-GetWidth(184)-10,self.tableView.bottom+(50-GetHeight(74))/2.0,GetWidth(184), GetHeight(74));
    [self.jieSuanBtn setBackgroundColor:MAINColor];
    [self.jieSuanBtn addTarget:self action:@selector(jieSuanAction) forControlEvents:UIControlEventTouchUpInside];
    self.jieSuanBtn.layer.masksToBounds = YES;
    self.jieSuanBtn.layer.cornerRadius = GetHeight(74)/2.0;
    [self.jieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    
    [self.jieSuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jieSuanBtn.titleLabel.font = SYSTEMFONT(15.0);
    self.jieSuanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.jieSuanBtn];

    
    
}
//结算
-(void)jieSuanAction{
    
    NSLog(@"结算");
    
    NSString * moneyStr = self.totalMoneyLab.text;
    NSArray * array = [moneyStr componentsSeparatedByString:@"合计:￥"];
    NSString * carStr;
    NSString * messegeStr;
    if (array.count == 2 && [[array objectAtIndex:1] intValue] < 0.00000001) {
        NSLog(@"请先选择商品");
        carStr = @"请先选择商品!";
        messegeStr = @"呵呵哒";
    }else
    {
        NSLog(@"去结算");
        messegeStr = @"GO";
        carStr = [NSString stringWithFormat:@"总计:%d元",[[array objectAtIndex:1] intValue]];
        
        
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:messegeStr message:carStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
    
//    ExpressRecycleOrderVC *expressVC = [[ExpressRecycleOrderVC alloc] init];
//    [self.navigationController pushViewController:expressVC animated:YES];
//
    
}

//全选
-(void)selectAllaction:(UIButton *)sender{
    
    
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
        
    }
    //改变单元格选中状态
    for (int i=0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        model.selectState = sender.tag;
    }
 
    [self CalculationPrice];
   
    [self.tableView reloadData];
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellStr = @"ShopCarCell";
    
   ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
  
    if(!cell){
        
        cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
   
        
    }
    
    
    
    cell.delegate = self;
    cell.shoppingModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    


    return 110;
}



//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     * 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    ShoppingModel *model = self.dataArray[indexPath.row];
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }

    //刷新当前行
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self CalculationPrice];
}





//侧滑删除按钮
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//侧滑删除按钮 执行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataArray removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
   
    //重新计算价格
    [self CalculationPrice];
}



//删除按钮点击代理
- (void)isDelet:(UITableViewCell *)cell andDeletButtonTag:(NSInteger)deletTag
{
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    [_dataArray removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    //重新计算价格
    [self CalculationPrice];
}




#pragma mark -- 实现加减按钮点击代理事件
/**
 * 实现加减按钮点击代理事件
 *
 * @param cell 当前单元格
 * @param flag 按钮标识，11 为减按钮，12为加按钮
 */



//-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
//{
//    NSIndexPath *index = [self.tableView indexPathForCell:cell];
//    switch (flag) {
//        case 11:
//        {
//            //做减法
//            //先获取到当期行数据源内容，改变数据源内容，刷新表格
//            ShoppingModel *model = self.dataArray[index.row];
//            if (model.goodsNum > 1)
//            {
//                model.goodsNum --;
//            }
//        }
//            break;
//        case 12:
//        {
//            //做加法
//            ShoppingModel *model = self.dataArray[index.row];
//            model.goodsNum ++;
//        }
//            break;
//        default:
//            break;
//    }
//    //刷新表格
//    [self.tableView reloadData];
//    //计算总价
//    [self CalculationPrice];
//}
//计算价格
-(void)CalculationPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        if (model.selectState)
        {
            self.allPrice = self.allPrice + model.orItemsNum.intValue *[model.orItemsPrice doubleValue];
        }
    }
     //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:SYSTEMFONT(17) range:NSMakeRange(3,str.length-3)];
    [str addAttribute:NSForegroundColorAttributeName value:MAINColor range:NSMakeRange(3,str.length-3)];
    self.totalMoneyLab.attributedText = str;

         //NSLog(@"%f",self.allPrice);

         self.allPrice = 0.0;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
