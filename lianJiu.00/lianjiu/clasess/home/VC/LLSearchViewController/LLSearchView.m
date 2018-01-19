//
//  LLSearchView.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchView.h"

#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]

@interface LLSearchView ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) UIView *searchHistoryView;
@property (nonatomic, strong) UIView *hotSearchView;



@property (nonatomic, strong) NSMutableArray *textMutArr;
@end
@implementation LLSearchView

- (instancetype)initWithFrame:(CGRect)frame hotArray:(NSMutableArray *)hotArr historyArray:(NSMutableArray *)historyArr
{
    if (self = [super initWithFrame:frame]) {
        self.historyArray = historyArr;
        self.hotArray = hotArr;
        [self addSubview:self.searchHistoryView];
        [self addSubview:self.hotSearchView];
        
        
        
    }
    return self;
}


- (UIView *)hotSearchView
{
//    if (!_hotSearchView) {
//        self.hotSearchView = [self setViewWithOriginY:CGRectGetHeight(_searchHistoryView.frame) title:@"热门搜索" textArr:self.hotArray];
//    }
//   // return _hotSearchView;
    return nil;//把热门搜索隐藏
}



- (UIView *)searchHistoryView
{
    if (!_searchHistoryView) {
        if (_historyArray.count > 0) {
            self.searchHistoryView = [self setViewWithOriginY:0 title:@"最近搜索" textArr:self.historyArray];
        } else {
            self.searchHistoryView = [self setNoHistoryView];
        }
    }
    return _searchHistoryView;
}



- (UIView *)setViewWithOriginY:(CGFloat)riginY title:(NSString *)title textArr:(NSMutableArray *)textArr
{
    
    _textMutArr = [[NSMutableArray alloc] init];
    //[_textMutArr removeAllObjects];
    _textMutArr = textArr;
    
    
    NSLog(@"_textMutArr%@",_textMutArr);
    
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30 - 45, 30)];
    titleL.text = title;
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleL];
    
    if ([title isEqualToString:@"最近搜索"]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 10, 28, 30);
        [btn setImage:[UIImage imageNamed:@"sort_recycle"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(clearnSearchHistory:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    CGFloat y = 10 + 40;
    CGFloat letfWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *text = textArr[i];
        CGFloat width = [self getWidthWithStr:[text componentsSeparatedByString:@"/"][0]] + 30;
        if (letfWidth + width + 15 > [UIScreen mainScreen].bounds.size.width) {
            if (y >= 130 && [title isEqualToString:@"最近搜索"]) {
                [self removeTestDataWithTextArr:textArr index:i];
                break;
            }
            y += 40;
            letfWidth = 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(letfWidth, y, width, 30)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:12];
        label.text = [text componentsSeparatedByString:@"/"][0];
        label.layer.borderWidth = 0.5;
        label.layer.cornerRadius = 5;
        label.textAlignment = NSTextAlignmentCenter;
        if (i % 2 == 0 && [title isEqualToString:@"热门搜索"]) {
            label.layer.borderColor = [UIColor colorWithRed:(255/255.0) green:(148/255.0) blue:(153/255.0) alpha:1.0].CGColor;
            label.textColor = [UIColor colorWithRed:(255/255.0) green:(148/255.0) blue:(153/255.0) alpha:1.0];
        } else {
            label.textColor = [UIColor colorWithRed:(111/255.0) green:(111/255.0) blue:(111/255.0) alpha:1.0];
            label.layer.borderColor = [UIColor colorWithRed:(227/255.0) green:(227/255.0) blue:(227/255.0) alpha:1.0].CGColor;
        }
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        
        label.tag = i+100;
        
        [view addSubview:label];
        letfWidth += width + 10;
    }
    view.frame = CGRectMake(0, riginY, [UIScreen mainScreen].bounds.size.width, y + 40);
    return view;
}


- (UIView *)setNoHistoryView
{
    UIView *historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30, 30)];
    titleL.text = @"最近搜索";
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    
    UILabel *notextL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleL.frame) + 10, 100, 20)];
    notextL.text = @"无搜索历史";
    notextL.font = [UIFont systemFontOfSize:12];
    notextL.textColor = [UIColor blackColor];
    notextL.textAlignment = NSTextAlignmentLeft;
    [historyView addSubview:titleL];
    [historyView addSubview:notextL];
    return historyView;
}

- (void)tagDidCLick:(UITapGestureRecognizer *)tap
{
    
    
    NSLog(@"_textMutArr%@",_textMutArr);
    UILabel *label = (UILabel *)tap.view;
    NSInteger index = label.tag -100;
    NSLog(@"_textMutArr%@",_textMutArr);
    NSString *textS = _textMutArr[index];
    
    
    
    if (self.tapAction) {
        self.tapAction(textS);
    }
    
    
    
    
    NSString *productName = [textS componentsSeparatedByString:@"/"][0];
    
    NSString *productId  = [textS componentsSeparatedByString:@"/"][1];
    NSString *category = [textS componentsSeparatedByString:@"/"][2];
    if ([category isEqualToString:@"1"]) {
        
        ScrapDetailViewController *svc = [[ScrapDetailViewController alloc] init];
        svc.wPriceId =productId;
        svc.name = productName;
        
        
        UIViewController *vc = [UIApplication sharedApplication].windows[0].rootViewController;
        [vc.navigationController pushViewController:svc animated:YES];
        
    }else if ([category isEqualToString:@"2"]){//家电
        
        
        
        ChooseConditionVC *cvc = [[ChooseConditionVC alloc] init];
        cvc.titleStr = productName;
        cvc.productID = productId;
        // cvc.productPrice = model.productPrice;
        cvc.isPhoneNotJD = NO;
        
        
        UIViewController *vc = [UIApplication sharedApplication].windows[0].rootViewController;
        
        [vc.navigationController pushViewController:cvc animated:YES];
    }else if ([category isEqualToString:@"3"]){
        ChooseConditionVC *cvc = [[ChooseConditionVC alloc] init];
        cvc.titleStr = productName;
        cvc.productID = productId;
        // cvc.productPrice = model.productPrice;
        cvc.isPhoneNotJD = YES;
        
        
        UIViewController *vc = [UIApplication sharedApplication].windows[0].rootViewController;

        [vc.navigationController pushViewController:cvc animated:YES];
        
        
    }

    
}

- (CGFloat)getWidthWithStr:(NSString *)text
{
    CGFloat width = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.width;
    return width;
}


- (void)clearnSearchHistory:(UIButton *)sender
{
    
    UIAlertController *clear = [UIAlertController alertControllerWithTitle:@"确认删除全部历史记录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quXiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *queRen = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        [self.searchHistoryView removeFromSuperview];
        self.searchHistoryView = [self setNoHistoryView];
        [_historyArray removeAllObjects];
        [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
        [self addSubview:self.searchHistoryView];
        CGRect frame = _hotSearchView.frame;
        frame.origin.y = CGRectGetHeight(_searchHistoryView.frame);
        _hotSearchView.frame = frame;

        
        
        
        
        
    }];
    [clear addAction:quXiao];
    [clear addAction:queRen];
    
    UIViewController *vc = [UIApplication sharedApplication].windows[0].rootViewController;
    
    [vc presentViewController:clear animated:YES completion:nil];
    
    
    
    
    
   }

- (void)removeTestDataWithTextArr:(NSMutableArray *)testArr index:(int)index
{
    NSRange range = {index, testArr.count - index - 1};
    [testArr removeObjectsInRange:range];
    [NSKeyedArchiver archiveRootObject:testArr toFile:KHistorySearchPath];
}



@end
