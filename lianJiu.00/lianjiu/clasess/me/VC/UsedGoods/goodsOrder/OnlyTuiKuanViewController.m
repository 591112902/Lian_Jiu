//
//  OnlyTuiKuanViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/9/30.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//


//#import "PhotoCollectionViewCell.h"
//#import "GWLPhotoLibrayController.h"

#import "OnlyTuiKuanViewController.h"
#import "UITextView+YLTextView.h"
@interface OnlyTuiKuanViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UIView *footView;
//@property (nonatomic)UICollectionView *collectionView;
//@property(nonatomic,strong)NSMutableArray *photoDataSouc;
@property(nonatomic,strong)UIButton *conmitBtn;
//@property(nonatomic,assign)BOOL isaddPhoto;
//@property(nonatomic,assign)NSInteger photoNum;

@end

@implementation OnlyTuiKuanViewController
{
    UIScrollView *_scrollV;
    CGFloat _scrollVH;
    UITextView *descriptiontv;//yuan yin
    UITextField *descriptiontf;//jin e
    
    NSString *orExceProductStatus;
    
}
#pragma mark - 按钮点击 键盘收起
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.title = @"仅退款";
    orExceProductStatus = @"0";//weishoudaohuo
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = BGColor;
    [self.view addSubview:_scrollV];

    
    UIView *headContenV = [[UIView alloc] init];
    headContenV.backgroundColor = [UIColor whiteColor];
     headContenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 140);
    [_scrollV addSubview:headContenV];
    _scrollVH += 140+5;
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 76-64, BOUND_WIDTH-20, 21)];
    titleL.text = _model.orItemsNamePreview?_model.orItemsNamePreview:@"";
    titleL.font =PFR15Font;
    [headContenV addSubview:titleL];
    
    UIImageView *headIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 105-64, 95, 80)];
   // headIV.image = [UIImage imageNamed:@"esjpr.png"];
    [headIV sd_setImageWithURL:[NSURL URLWithString:_model.orItemsPictruePreview]];
    
    [headContenV addSubview:headIV];
    
    UITextView *contentTV = [[UITextView alloc] initWithFrame:CGRectMake(113, 98-64, BOUND_WIDTH/320.0*205, 95)];
    contentTV.userInteractionEnabled = NO;
    contentTV.scrollEnabled = NO;
    contentTV.font = PFR15Font;
    
    contentTV.text = _model.orItemsParam?_model.orItemsParam:@"";
    [headContenV addSubview:contentTV];
    
    
    
    
    
    UIView *contenV = [[UIView alloc] init];
    contenV.backgroundColor = [UIColor whiteColor];
   // contenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, 500);
    [_scrollV addSubview:contenV];
    //_scrollVH += 500;

    
    UILabel *cTitleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, BOUND_WIDTH-20, 21)];
    
   
    cTitleL.text =  [NSString stringWithFormat:@"订单编号:%@",_model.ordersId];
    cTitleL.font =PFR15Font;
    [contenV addSubview:cTitleL];
    
    
    //分割线
    UIImageView *kxCutLine = [[UIImageView alloc] init];
    kxCutLine.frame = CGRectMake(10, cTitleL.frame.size.height+cTitleL.frame.origin.y+5, BOUND_WIDTH-20, 0.5);
    kxCutLine.backgroundColor = BGColor;
    [contenV addSubview:kxCutLine];

    
    
    
#pragma mark-服务类型:
//    UILabel *fTitleL = [[UILabel alloc] initWithFrame:CGRectMake(10, kxCutLine.frame.size.height+kxCutLine.frame.origin.y+8, 70, 21)];
//    fTitleL.text = @"服务类型:";
//   // fTitleL.backgroundColor = [UIColor blueColor];
//    fTitleL.font =PFR15Font;
//    [contenV addSubview:fTitleL];
//
//    NSArray *qarr =@[@"仅退款",@"退货退款",];
//    CGFloat qbtngap = 10;
//    CGFloat qbtnH = 30;
//    CGFloat leftgap = 110;
//    CGFloat qbtnW = 85;
//    //(BOUND_WIDTH-leftgap-qbtngap*(qarr.count-1))/qarr.count;
//    UIView *qbtnView = [[UIView alloc] initWithFrame:CGRectMake(leftgap, kxCutLine.frame.size.height+kxCutLine.frame.origin.y+4,BOUND_WIDTH-leftgap , qbtnH)];
//    [contenV addSubview:qbtnView];
//    for (int i = 0; i<qarr.count; i++) {
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(qbtnW+qbtngap), 0, qbtnW, qbtnH)];
//        [btn setTitle:qarr[i] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(chooseClass:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        btn.titleLabel.font = PFR13Font;
//        btn.imageEdgeInsets =UIEdgeInsetsMake(10 -2,5 -2,10 -2,qbtnW-15 -2);
//        [qbtnView addSubview:btn];
//        
//        btn.tag = 60+i;
//        if (i==0) {
//            btn.selected =YES;
//        }
//
//    }
////    
//    //分割线
//    UIImageView *CutLine = [[UIImageView alloc] init];
//    CutLine.frame = CGRectMake(10, fTitleL.frame.size.height+fTitleL.frame.origin.y+8, BOUND_WIDTH-20, 0.5);
//    CutLine.backgroundColor = BGColor;
//    [contenV addSubview:CutLine];
    
    
#pragma mark-货物状态:
    UILabel *hTitleL = [[UILabel alloc] initWithFrame:CGRectMake(10, kxCutLine.frame.size.height+kxCutLine.frame.origin.y+8, 70, 21)];
    hTitleL.text = @"货物状态:";
    // fTitleL.backgroundColor = [UIColor blueColor];
    hTitleL.font =PFR15Font;
    [contenV addSubview:hTitleL];
    
    NSArray *qarr2 =@[@"未收到货",@"已收到货",];
    CGFloat qbtngap2 = 10;
    CGFloat qbtnH2 = 30;
    CGFloat leftgap2 = 110;
    CGFloat qbtnW2 = 85;
    //(BOUND_WIDTH-leftgap-qbtngap*(qarr.count-1))/qarr.count;
    UIView *qbtnView2 = [[UIView alloc] initWithFrame:CGRectMake(leftgap2, kxCutLine.frame.size.height+kxCutLine.frame.origin.y+4,BOUND_WIDTH-leftgap2 , qbtnH2)];
    [contenV addSubview:qbtnView2];
    for (int i = 0; i<qarr2.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(qbtnW2+qbtngap2), 0, qbtnW2, qbtnH2)];
        [btn setTitle:qarr2[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseClass2:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        btn.titleLabel.font = PFR13Font;
        btn.imageEdgeInsets =UIEdgeInsetsMake(10 -2,5 -2,10 -2,qbtnW2-15 -2);
        [qbtnView2 addSubview:btn];
        
        btn.tag = 70+i;
        if (i==0) {
            btn.selected =YES;
        }
        
    }
    
    
    //分割线
    UIImageView *CutLine2 = [[UIImageView alloc] init];
    CutLine2.frame = CGRectMake(10, hTitleL.frame.size.height+hTitleL.frame.origin.y+8, BOUND_WIDTH-20, 0.5);
    CutLine2.backgroundColor = BGColor;
    [contenV addSubview:CutLine2];

    
    
    
    
    UILabel *tTitleL = [[UILabel alloc] initWithFrame:CGRectMake(10, CutLine2.frame.size.height+CutLine2.frame.origin.y+8, 70, 21)];
    tTitleL.text = @"退货原因:";
    tTitleL.font =PFR15Font;
    [contenV addSubview:tTitleL];
    descriptiontv = [[UITextView alloc] initWithFrame:CGRectMake(80, CutLine2.frame.size.height+CutLine2.frame.origin.y+8, BOUND_WIDTH-80-10, 120)];
    descriptiontv.font = [UIFont systemFontOfSize:15];
    descriptiontv.backgroundColor = [UIColor whiteColor];
    //descriptiontv.limitLength = @200;
    descriptiontv.layer.borderWidth = 0.5;
    descriptiontv.layer.borderColor = BGColor.CGColor;
    descriptiontv.layer.cornerRadius = 3;
    // descriptiontv.placeholder =@"在此输入";
     [contenV addSubview:descriptiontv];
    
    
    
    //分割线
    UIImageView *CutLine3 = [[UIImageView alloc] init];
    CutLine3.frame = CGRectMake(10, descriptiontv.frame.size.height+descriptiontv.frame.origin.y+10, BOUND_WIDTH-20, 0.5);
    CutLine3.backgroundColor = BGColor;
    [contenV addSubview:CutLine3];

    
    
    UILabel *mTitleL = [[UILabel alloc] initWithFrame:CGRectMake(10, CutLine3.frame.size.height+CutLine3.frame.origin.y+8, 70, 21)];
    mTitleL.text = @"退货金额:";
    mTitleL.font =PFR15Font;
    [contenV addSubview:mTitleL];
    descriptiontf = [[UITextField alloc] initWithFrame:CGRectMake(80, CutLine3.frame.size.height+CutLine3.frame.origin.y+3, BOUND_WIDTH-80-40, 30)];
    descriptiontf.font = [UIFont systemFontOfSize:15];
    descriptiontf.backgroundColor = [UIColor whiteColor];
    //descriptiontv.limitLength = @200;
    
    descriptiontf.delegate = self;
    descriptiontf.keyboardType = UIKeyboardTypeDecimalPad;
    descriptiontf.text = _model.ordersPrice;
    descriptiontf.layer.borderWidth = 0.5;
    descriptiontf.layer.borderColor = BGColor.CGColor;
    descriptiontf.layer.cornerRadius = 3;
   // descriptiontf.placeholder =@"  在此输入";
    [contenV addSubview:descriptiontf];
    UILabel *tishiTitleL = [[UILabel alloc] initWithFrame:CGRectMake(80, descriptiontf.frame.size.height+descriptiontf.frame.origin.y+8, BOUND_WIDTH-80, 21)];
    
    
    tishiTitleL.text = [NSString stringWithFormat:@"最多¥%@元",_model.ordersPrice];
    tishiTitleL.textColor = [UIColor lightGrayColor];
    tishiTitleL.font =PFR14Font;
    [contenV addSubview:tishiTitleL];
    
    
    
    
    
    //分割线
    UIImageView *CutLine4 = [[UIImageView alloc] init];
    CutLine4.frame = CGRectMake(10, tishiTitleL.frame.size.height+tishiTitleL.frame.origin.y+5, BOUND_WIDTH-20, 0.5);
    CutLine4.backgroundColor = BGColor;
    [contenV addSubview:CutLine4];
    
    
    

    
    
    CGFloat photoVCH  =(BOUND_WIDTH-80)/3+20;
    CGFloat H = CutLine4.frame.size.height+CutLine4.frame.origin.y+8;
    contenV.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, H  );
    _scrollVH+=H;
    
    
    UIView *baiView = [[UIView alloc] init];
    baiView.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, photoVCH);
    baiView.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:baiView];
    UILabel *sTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    sTitleL.text = @" 上传图片:";
    sTitleL.font =PFR15Font;
    [baiView addSubview:sTitleL];

    
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    flowLayout.headerReferenceSize =  CGSizeMake(BOUND_WIDTH, 0);
    flowLayout.minimumLineSpacing = 1;
      flowLayout.minimumInteritemSpacing = 1;
    
    
    self.askPhotoVC = [[TuiMulPhotoCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    self.askPhotoVC.view.frame = CGRectMake(80, _scrollVH, BOUND_WIDTH-80, photoVCH);
    self.askPhotoVC.collectionView.scrollEnabled = NO;
    self.askPhotoVC.dataSource = [[NSMutableArray alloc] init];
    PhotoMultModel *model = [[PhotoMultModel alloc] init];
    model.headTitle = CustomLocalizedString(@"", nil);
    model.photoNumber = 3;
    [self.askPhotoVC.dataSource addObject:model];
    [self addChildViewController:self.askPhotoVC];
    [_scrollV addSubview:self.askPhotoVC.view];
    [self.askPhotoVC didMoveToParentViewController:self];
    //_scrollVH+= self.view.frame.size.width/5.0+25;

    
    
    
     _scrollVH+=photoVCH  +30;
    
    
    
    self.conmitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _scrollVH, BOUND_WIDTH-20, 44)];
    self.conmitBtn.backgroundColor = MAINColor;
    [self.conmitBtn addTarget:self action:@selector(ToCommit) forControlEvents:UIControlEventTouchUpInside];
    self.conmitBtn.layer.cornerRadius = 5;
    [self.conmitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [_scrollV addSubview:self.conmitBtn];
    
    
    
     _scrollVH += 44+70;
     _scrollV.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);
}
//- (void)chooseClass:(UIButton *)btn
//{
//    for (UIButton *button in btn.superview.subviews) {
//        button.selected = NO;
//    }
//    btn.selected = YES;
//    
//    
//    if (btn.tag == 60) {
//        NSLog(@"退款");
//        
//    }else if (btn.tag == 61) {
//         NSLog(@"退款退货");
//    }
//}
- (void)chooseClass2:(UIButton *)btn
{
    for (UIButton *button in btn.superview.subviews) {
        button.selected = NO;
    }
    btn.selected = YES;
    
    
    if (btn.tag == 70) {
        NSLog(@"未收到货");
        orExceProductStatus = @"0";
        
    }else if (btn.tag == 71) {
        NSLog(@"已收到货");
        orExceProductStatus = @"1";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








//- (void)addPhoto
//{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:@"添加照片"
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:@"从相册获取", @"拍照",nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
//    
//}
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [self addPhotoWithPhotoLibrary];
//    }else if (buttonIndex == 1) {
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        imagePicker.allowsEditing = YES;
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//        imagePicker = nil;
//    }
//}
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    image = [image fixOrientation];
//    [self displayImages:@[image]];
//    image = nil;
//}
//- (void)addPhotoWithPhotoLibrary {
//    __weak typeof (self)weakSelf = self;
//    GWLPhotoLibrayController *photoSelector = [GWLPhotoLibrayController photoLibrayControllerWithBlock:^(NSArray *images) {
//        [weakSelf displayImages:images];
//    }];
//    photoSelector.maxCount = 3;
//    photoSelector.multiAlbumSelect = YES;
//    [self presentViewController:photoSelector animated:YES completion:nil];
//}
//
//- (void)displayImages:(NSArray *)images {
//    
//    UIImage *imge = self.photoDataSouc.lastObject;
//    [self.photoDataSouc removeLastObject];
//    [self.photoDataSouc addObjectsFromArray:images];
//    [self.photoDataSouc addObject:imge];
//    
//    if (self.photoDataSouc.count>self.photoNum) {
//        self.isaddPhoto = NO;
//        NSRange range = NSMakeRange(0, self.photoNum);
//        NSArray *temp = [self.photoDataSouc subarrayWithRange:range];
//        self.photoDataSouc = [NSMutableArray arrayWithArray:temp];
//    }
//    
//    
//    CGRect rect = self.collectionView.frame;
//    rect.size.height = ceil (self.photoDataSouc.count/3.0) *(BOUND_WIDTH-95)/3+(ceil (self.photoDataSouc.count/3.0)+1)*10;
//    CGFloat addH = rect.size.height - self.collectionView.frame.size.height;
//    self.collectionView.frame = rect;
//    CGRect footFram = self.footView.frame;
//    footFram.size.height += addH;
//    [self.collectionView reloadData];
//    
//    self.footView.frame = footFram;
//    CGSize tabelViewSize = _scrollV.contentSize;
//    tabelViewSize.height += addH;
//    _scrollV.contentSize = tabelViewSize;
//    
//    CGRect conmbtnFram = self.conmitBtn.frame;
//    conmbtnFram.origin.y +=addH;
//    self.conmitBtn.frame =  conmbtnFram;
//}
////压缩图片
//- (NSArray *)photoDataSoucToData:(NSArray*) arr
//{
//    NSMutableArray *dataArr= [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i<arr.count;i++) {
//        UIImage *image =arr[i];
//        
//        NSData *data = [image imageCompress];
//        
//        [dataArr addObject:data];
//    }
//    return dataArr;
//    
//}

//压缩图片
- (NSArray *)photoDataSoucToData:(NSArray*) arr
{
    NSMutableArray *dataArr= [[NSMutableArray alloc] init];
    
    for (int i = 0; i<arr.count;i++) {
        UIImage *image =arr[i];
        
        NSData *data = [image imageCompress];
        
        [dataArr addObject:data];
    }
    return dataArr;
}


- (void)ToCommit
{
    PhotoMultModel *model = self.askPhotoVC.dataSource[0];
    NSArray *dataArr= [self photoDataSoucToData:model.photoDataSouc];
   
    if (descriptiontv.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写退款原因" toView:self.view];
        return;
    }
    if (descriptiontf.text.length==0) {
        [MBProgressHUD showNotPhotoError:@"请填写退款金额" toView:self.view];
        return;
    }
    if ([descriptiontf.text floatValue]==0) {
        [MBProgressHUD showNotPhotoError:@"退款金额最少为0.01" toView:self.view];
        return;
    }

    
    
//    if (model.photoDataSouc.count==0) {
//        [MBProgressHUD showNotPhotoError:@"请添加图片" toView:self.view];
//        return;
//    }

    //http://101.132.38.30:8081weakSelf/pic/upload/multi
    LOADIMGLJ;
    //@"http://192.168.0.121:8081/pic/upload/multi"
    [networking GAFNPOSTMutableArrfile:LOADIMGLJ withparameters:nil dataName:@"file" dataSource:dataArr success:^(NSMutableDictionary *dic) {
        
        
        NSString *photostr1 = dic[@"lianjiuData"];
        NSLog(@"photostr1:%@   photostr1_+str%@",photostr1,dic);
        
        
        
        
        
        NSMutableString *mutStr = [[NSMutableString alloc] init];
        [mutStr setString:@""];
        if ([dic[@"lianjiuData"] isKindOfClass:[NSArray class]]) {
            
            NSArray *lianjiuData = dic[@"lianjiuData"];
            for (NSDictionary *temp in lianjiuData) {
               // [NSString stringWithFormat:@"%@,",temp[@"url"]];
                
                [mutStr appendString:[NSString stringWithFormat:@"%@,",temp[@"url"]]];
            }
            
           mutStr =  [mutStr substringToIndex:mutStr.length-1];
            
        }
        
        
        
        NSDictionary *para = @{@"orExcellentId":_model.ordersId,@"orExceProductStatus":orExceProductStatus,@"orExceRefundCause":descriptiontv.text,@"orExceRefundMoney":descriptiontf.text,@"orExceRefundExpresspic":mutStr};
                [networking AFNPOST:ORDERSREFUNDJP withparameters:para success:^(NSMutableDictionary *dic) {
        
                   // [MBProgressHUD showNotPhotoError:@"退款成功" toView:self.view];
                   // [self.navigationController popViewControllerAnimated:YES];
                    
                    //提示框
                    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"提示" message:@"退款单已提交成功，请耐心等待。我们将尽快为您受理！" preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        
                        
                        NSNotification *notification = [NSNotification notificationWithName:@"GOODORDER__NOTIFICATION" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];

                        
                        
                     [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                  
                    [clear addAction:queRen];
                    [self presentViewController:clear animated:YES completion:nil];
                    
                } error:nil HUDAddView:self.view];
        
    } progress:^(NSProgress *uploadProgress) {
    } error:nil HUDAddView:self.view];
}



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

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([textField.text floatValue]>[_model.ordersPrice floatValue]) {
        textField.text = _model.ordersPrice;
        
        
        [MBProgressHUD showNotPhotoError:@"已超过最高退款价格" toView:self.view];
    }

    return YES;
}


@end
