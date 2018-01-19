//
//  CallBackCarViewController.m
//  lianjiu
//
//  Created by 123 on 17/11/14.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "CallBackCarViewController.h"
#import "KDTableViewCell.h"
#import "SMTableViewCell.h"
#import "CallbackModel.h"

#import "CalculateManager.h"
#import "UIColor+ChangeColor.h"
@interface CallBackCarViewController()<UITableViewDelegate, UITableViewDataSource>
{
    float KD_Count;
    float SM_Count;
    NSInteger KD_Row;
    NSInteger SM_Row;
}

@property (nonatomic, strong) UITableView *tableView;

// 快递回收tableView
@property (nonatomic, strong) NSMutableArray *KDdataArr;

// 上门回收tableView
@property (nonatomic, strong) NSMutableArray *SMdataArr;

// 订单号
@property (nonatomic, strong) NSString *orderList;

@end

@implementation CallBackCarViewController

- (NSMutableArray *)KDdataArr{
    if (!_KDdataArr) {
        _KDdataArr = [[NSMutableArray alloc] init];
    }
    return _KDdataArr;
}

- (NSMutableArray *)SMdataArr{
    if (!_SMdataArr) {
        _SMdataArr = [[NSMutableArray alloc] init];
    }
    return _SMdataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CreateALL) name:@"HUISHOUCHE_SX_NOTIFICATION" object:nil];//监听一个通
    self.title = @"回收车";
    [self CreateALL];
}

-(void)CreateALL{
    [self CreateUI];
    [self LoadData];
}

- (void)LoadData{
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uid = [def objectForKey:@"userId"];
    if (uid.length == 0) {
        
        [MBProgressHUD showNotPhotoError:@"请先登陆" toView:self.view];
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%@/%@/userId", SELECTPRODUCTFROM, uid];
    NSLog(@"==========%@", str);
    
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/userId", SELECTPRODUCTFROM, uid] withparameters:nil success:^(NSMutableDictionary *dic) {
        
        [self.SMdataArr removeAllObjects];
        [self.KDdataArr removeAllObjects];
        
        NSLog(@"/////////////%@", dic);
        NSDictionary *dataDic = dic[@"lianjiuData"];
        NSMutableArray *faceArr = [dataDic objectForKey:@"facefaceList"];
        for (NSDictionary *dic in faceArr) {
            CallbackModel *model = [CallbackModel ModelWith:dic];
            [self.SMdataArr addObject:model];
        }
        NSLog(@"---------%@", self.KDdataArr);
        
        NSMutableArray *expressArr = [dataDic objectForKey:@"expressList"];
        for (NSDictionary *dic in expressArr) {
            CallbackModel *model = [CallbackModel ModelWith:dic];
            [self.KDdataArr addObject:model];
        }
        
        NSLog(@"++++++++++%@", self.SMdataArr);
        
        [self.tableView reloadData];

    } error:^(NSError *error) {
         NSLog(@"error = %@", error);
    } HUDAddView:self.view];
    
}


- (void)CreateUI{
    [self createUI_tableView];
}
- (void)createUI_tableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"KDTableViewCell" bundle:nil] forCellReuseIdentifier:@"KDTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SMTableViewCell" bundle:nil] forCellReuseIdentifier:@"SMTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Calculate_Height(214);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.KDdataArr == nil || self.KDdataArr.count == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            return cell;
        } else {
            if (self.KDdataArr.count < 2) {
                if (indexPath.row == 1) {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                    return cell;
                }
            }
            KDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KDTableViewCell" forIndexPath:indexPath];
            CallbackModel *model = self.KDdataArr[indexPath.row];
            cell.model = model;
            return cell;
        }
    } else {
        if (self.SMdataArr == nil || self.SMdataArr.count == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            return cell;
        } else {
            if (self.SMdataArr.count < 2) {
                if (indexPath.row == 1) {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                    return cell;
                }
            }
            SMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SMTableViewCell" forIndexPath:indexPath];
            CallbackModel *model = self.SMdataArr[indexPath.row];
            cell.model = model;
            return cell;
        }
    }
}
//+
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (self.KDdataArr != nil && self.KDdataArr.count != 0) {
            if (self.KDdataArr.count >= 2 || indexPath.row == 0) {
                CallbackModel *model = self.KDdataArr[indexPath.row];
                model.isSelected = !model.isSelected;
                [self.KDdataArr replaceObjectAtIndex:indexPath.row withObject:model];
                KD_Count = 0;
                NSString *str = @"";
                for (int i = 0; i < (self.KDdataArr.count>=2?2:self.KDdataArr.count); i++) {
                    CallbackModel *model = self.KDdataArr[i];
                    NSString *orderid = model.orItemsId;
                    
                    float count = [model.orItemsPrice floatValue];
                    if (model.isSelected) {
                        KD_Count += count;
                        str = [str stringByAppendingFormat:@",%@", orderid];
                    }
                }
                self.orderList = str;
                 [self.tableView reloadData];
               // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    } else {
        if (self.SMdataArr != nil && self.SMdataArr.count != 0) {
            if (self.SMdataArr.count >= 2 || indexPath.row == 0) {
                CallbackModel *model = self.SMdataArr[indexPath.row];
                model.isSelected = !model.isSelected;
                [self.SMdataArr replaceObjectAtIndex:indexPath.row withObject:model];
                SM_Count = 0;
                NSString *str = @"";
                for (int i = 0; i < (self.SMdataArr.count>=2?2:self.SMdataArr.count); i++) {
                    CallbackModel *model = self.SMdataArr[i];
                    NSString *orderid = model.orItemsId;
                    
                    float count = [model.orItemsPrice floatValue];
                    float num = [model.orItemsNum floatValue];
                    if (model.isSelected) {
                        SM_Count += count * num;
                        str = [str stringByAppendingFormat:@",%@", orderid];

                    }
                }
                self.orderList = str;
                [self.tableView reloadData];
            }
        }
    }
}
//顶部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return Calculate_Height(80);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.sectionHeaderHeight)];
    UILabel *label = [[UILabel alloc] init];
    label.font = Calculate_Font(26);
    if (section == 0) {
        label.text = @"快递回收";
    } else {
        label.text = @"上门回收";
    }
    [headerView addSubview:label];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"more1@3x"] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreBtn setTintColor:[UIColor blackColor]];
    moreBtn.showsTouchWhenHighlighted = YES;
    moreBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 25)];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 0, - 45)];
    [moreBtn addTarget:self action:@selector(moreView:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.tag = section;
    [headerView addSubview:moreBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor HexString:@"#e5e5e5"];
    [headerView addSubview:lineView];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top);
        make.left.equalTo(headerView.mas_left).offset(15);
        make.bottom.equalTo(headerView.mas_bottom).offset(-1);
    }];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right);
        make.top.equalTo(headerView.mas_top);
        make.bottom.equalTo(headerView.mas_bottom).offset(-1);
        make.width.offset(70);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right).offset(-15);
        make.top.equalTo(label.mas_bottom);
        make.left.equalTo(headerView.mas_left).offset(15);
        make.height.offset(1);
    }];
    return headerView;
}
//底部结算
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Calculate_Height(100);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.sectionFooterHeight)];
    
    UILabel *flagLabel = [[UILabel alloc] init];
    flagLabel.text = @"合计：";
    flagLabel.font = Calculate_Font(24);
    [footerView addSubview:flagLabel];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor HexString:@"#2bd82a"];
    label.font = Calculate_Font(26);
    [footerView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"结算" forState:UIControlStateNormal];
    btn.titleLabel.font = Calculate_Font(26);
    [btn setTitleColor:[UIColor HexString:@"#2bd82a"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 3;
    btn.layer.borderColor = [UIColor HexString:@"#2bd82a"].CGColor;
    btn.layer.borderWidth = 1;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(settlement:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor HexString:@"#f0f0f0"];
    [footerView addSubview:lineView];
    NSString *labelText = @"";
    if (section == 0) {
        labelText = [NSString stringWithFormat:@"%.2f元", KD_Count];
        btn.tag = 0;
    } else {
        labelText = [NSString stringWithFormat:@"%.2f元", SM_Count];
        btn.tag = 1;
    }
    label.text = labelText;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footerView.mas_right).offset(-10);
        make.centerY.equalTo(flagLabel.mas_centerY);
        make.width.offset(Calculate_Width(132));
        make.height.offset(Calculate_Height(43));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left).offset(-10);
        make.bottom.equalTo(lineView.mas_top);
        make.top.equalTo(footerView.mas_top);
    }];
    [flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top);
        make.right.equalTo(label.mas_left).offset(-4);
        make.bottom.equalTo(lineView.mas_top);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footerView.mas_right);
        make.bottom.equalTo(footerView.mas_bottom);
        make.left.equalTo(footerView.mas_left);
        if (section == 0) {
            make.height.offset(Calculate_Height(12));
        } else {
            make.height.offset(0);
        }
        
    }];
    return footerView;
}

// 结算按钮
- (void)settlement:(UIButton *)btn {
    if (btn.tag == 0) {//快递
        
        NSString *str = @"";
        for (int i = 0; i < (self.KDdataArr.count>=2?2:self.KDdataArr.count); i++) {
            CallbackModel *model = self.KDdataArr[i];
            NSString *orderid = model.orItemsId;
            
            if (model.isSelected) {
                if (![str isEqualToString:@""]) {
                    str = [str stringByAppendingString:@","];
                }
                str = [str stringByAppendingFormat:@"%@", orderid];
            }
        }
        self.orderList = str;
        
        NSLog(@"000==%@  kaugdi:%zd",self.orderList,KD_Count);
        if (self.orderList.length>0) {
            if (KD_Count < 50) {
                [MBProgressHUD showNotPhotoError:@"需要满50元才可以结算" toView:self.view];
            } else {
                
                NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                NSString *uId = [def objectForKey:@"userId"];
                
                [networking AFNPOST:PRODUCTBALANCE withparameters:@{@"itemIdList":self.orderList,@"userId":uId} success:^(NSMutableDictionary *dic) {
                    NSLog(@"kuaidi==dic%@userIduserIduserId:%@",dic,uId);
                    ExpressRecycleOrderVC *expressVC = [[ExpressRecycleOrderVC alloc] init];
                    [self.navigationController pushViewController:expressVC animated:YES];
                } error:nil HUDAddView:self.view];
            }
        }else{
            [MBProgressHUD showNotPhotoError:@"请选择商品" toView:self.view];
        }
        
        
    } else {//上门
//        NSString *str = @"";
//        for (int i = 0; i < (self.SMdataArr.count>=2?2:self.SMdataArr.count); i++) {
//            CallbackModel *model = self.SMdataArr[i];
//            NSString *orderid = model.orItemsId;
//            
//            if (model.isSelected) {
//                if (![str isEqualToString:@""]) {
//                    str = [str stringByAppendingString:@","];
//                }
//                str = [str stringByAppendingFormat:@"%@", orderid];
//            }
//        }
//        self.orderList = str;
        
        NSLog(@"1111==%@   shgnm:%zd",self.orderList,SM_Count);
        if (self.orderList.length>0) {
           
            
            if (SM_Count < 10) {
                [MBProgressHUD showNotPhotoError:@"需要满10元才可以结算" toView:self.view];
                return;
            }
            
            
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSString *uId = [def objectForKey:@"userId"];
            
            [networking AFNPOST:BALANCE withparameters:@{@"itemIdList":self.orderList,@"userId":uId} success:^(NSMutableDictionary *dic) {
               
                NSLog(@"+++++++%@", dic);
                NSDictionary *lianjiuData = dic[@"lianjiuData"];
                NSString *imageStr = lianjiuData[@"maximage"];
                NSArray *plArr = lianjiuData[@"productIdList"];
                
                
                
                
                
                
                AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                UIView *superView = [UIApplication sharedApplication].keyWindow;
                [MBProgressHUD showHUDAddedTo:superView animated:YES];
                [manager GET:[NSString stringWithFormat:@"%@/%@",SELECTADDRESSDEFAULT,uId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    
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
                        smVC.price = [NSString stringWithFormat:@"%zd",SM_Count];
                        smVC.userDefault = b;
                        smVC.address = address;
                        smVC.goodImageViewStr = imageStr;
                        if (plArr.count>0) {
                            smVC.productIdList = plArr[0];
                        }
                        [self.navigationController pushViewController:smVC animated:YES];
                        
                        
                    }else if (c==500) {//没有设置默认地址",
                        
                        ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                        smVC.price = [NSString stringWithFormat:@"%zd",SM_Count];
                        smVC.userDefault = NO;
                        smVC.goodImageViewStr = imageStr;
                        if (plArr.count>0) {
                            smVC.productIdList = plArr[0];
                        }
                        [self.navigationController pushViewController:smVC animated:YES];
                        
                        
                    }else{
                        
                        ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
                        smVC.price = [NSString stringWithFormat:@"%zd",SM_Count];
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

                
                
                
                
                
                
                
                
//                ShangMenFillinOrderVC *smVC = [[ShangMenFillinOrderVC alloc] init];
//                smVC.price = [NSString stringWithFormat:@"%zd",SM_Count];
//                smVC.goodImageViewStr = imageStr;
//                if (plArr.count>0) {
//                    smVC.productIdList = plArr[0];
//                }
//                [self.navigationController pushViewController:smVC animated:YES];

                
            } error:nil HUDAddView:self.view];
        }else{
            [MBProgressHUD showNotPhotoError:@"请选择商品" toView:self.view];
        }

        
    }
}

// 更多
- (void)moreView:(UIButton *)btn{
    if (btn.tag == 0) {
        ComeDoorRecycleCarViewController * c = [[ComeDoorRecycleCarViewController alloc] init];
        c.hsStyle = @"express";
        c.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:c animated:YES];

    } else {
        ComeDoorRecycleCarViewController * c = [[ComeDoorRecycleCarViewController alloc] init];
        c.hsStyle = @"face";
        c.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:c animated:YES];

    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        // 删除商品
        
        
        if (indexPath.section == 0) {
            CallbackModel *model = self.KDdataArr[indexPath.row];
            if (model.isSelected) {
                KD_Count -= [model.orItemsPrice integerValue];
            }
            
            
            
            
            // self.title = @"快递回收";
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSString *uid = [def objectForKey:@"userId"];
            [networking AFNPOST:EXPRESSDELETECAR withparameters:@{@"userId":uid,@"itemId":model.orItemsId} success:^(NSMutableDictionary *dic) {
                
               
               [self.KDdataArr removeObjectAtIndex:indexPath.row];
                 [self LoadData];
            } error:nil HUDAddView:self.view];
            
           
        } else {
            CallbackModel *model = self.SMdataArr[indexPath.row];
            if (model.isSelected) {
                SM_Count -= [model.orItemsPrice integerValue];
            }
            
            
            //self.title = @"上门回收"
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            NSString *uid = [def objectForKey:@"userId"];
            [networking AFNPOST:FACEDELETECAR withparameters:@{@"userId":uid,@"itemId":model.orItemsId} success:^(NSMutableDictionary *dic) {
                
                 [self.SMdataArr removeObjectAtIndex:indexPath.row];
                [self LoadData];
               
                
            } error:nil HUDAddView:self.view];

           
        }
        [tableView reloadData];
    }
    
}
@end
