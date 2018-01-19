//
//  SegmentViewController.m
//  SegmentPage
//
//  Created by 小李 on 16/9/2.
//  Copyright © 2016年 小李. All rights reserved.
//

#import "ProdctCanShu.h"
#import "EvaluateLeftCell.h"
#import "UIImageView+WebCache.h"


@interface ProdctCanShu ()<UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ProdctCanShu
{
    UIScrollView *scrollView;
    CGFloat _scrollVH;
   // CGFloat tuwenXQViewH;
   

}
//获取图片后更改图片高度
-(void)subImageView:(UIView *)view ChangeHeight:(CGFloat)Chageheight
{
    CGSize contenSize = scrollView.contentSize;
    contenSize.height += Chageheight;
    scrollView.contentSize = contenSize;
    BOOL isAddHeigth = NO;
    for (UIView *subview in view.superview.subviews) {
        if (view==subview) {
            CGRect oldrect = subview.frame;
            oldrect.size.height +=Chageheight;
            subview.frame = oldrect;
            isAddHeigth = YES;
            continue;
        }
        if (isAddHeigth) {
            CGRect oldrect = subview.frame;
            oldrect.origin.y +=Chageheight;
            subview.frame = oldrect;
        }
    }
}

- (void)viewDidLoad {//BOUND_HIGHT-50-64-41
    [super viewDidLoad];
    _scrollVH = 0;
    self.view .backgroundColor = [UIColor whiteColor];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOUND_WIDTH, BOUND_HIGHT-BOUND_WIDTH/320.0*38-64-44)];//BOUND_WIDTH/320.0*38+44
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    scrollView.delegate = self;

    
    
     //scrollView.contentSize = CGSizeMake(BOUND_WIDTH, BOUND_HIGHT);
    
   // NSLog(@"canpincnaSHuID:%@",_pid);
    [networking AFNRequest:[NSString stringWithFormat:@"%@/%@/ById",GETEXCELLENT,_pid] withparameters:nil success:^(NSMutableDictionary *dic) {
       // NSLog(@"canpincnaSHuVC---:%@",dic);
        //NSDictionary *lianjiuData = dic[@"lianjiuData"];
        NSDictionary *pDetailsDic = dic[@"lianjiuData"];
        
        
        
     
        //图文详情--------------------------------------------------------------
//        UIImage *subimgae = [UIImage imageNamed:@"jinpinxia"];
//        CGFloat subImageH = BOUND_HIGHT;
//        CGFloat subImgesY = 0;
//        NSArray *subUrl=[pDetailsDic[@"excellentSubPicture"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",;"]];
//        NSMutableArray *subPhotosUrl =[[NSMutableArray alloc] initWithArray:subUrl];
//        [subPhotosUrl removeObject:@""];
//        
//        for (int i=0; i<subPhotosUrl.count; i++) {
//            
//            UIImageView *subImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, subImgesY, BOUND_WIDTH, subImageH)];
//            [scrollView addSubview:subImage];
//            NSString *urlStr = [@"" stringByAppendingString:subPhotosUrl[i]?subPhotosUrl[i]:@""];
//            urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//            
//            WS(weakSelf);
//            [subImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:subimgae completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if (!error) {
//                    CGFloat imageH = image.size.height;
//                    CGFloat imageW = image.size.width;
//                    CGFloat newSubImageH = imageH/imageW*BOUND_WIDTH;
//                    if (cacheType==SDImageCacheTypeMemory) {
//                        CGRect oldRect = subImage.frame;
//                        oldRect.size.height = newSubImageH;
//                        
//                        subImage.frame = oldRect;
//                    } else if (cacheType==SDImageCacheTypeDisk||cacheType==SDImageCacheTypeNone) {
//                        
//                        CGFloat gapH = newSubImageH - subImageH;
//                        [weakSelf subImageView:subImage ChangeHeight:gapH];
//                    }
//                }
//            }];
//          
//            subImgesY+=subImage.frame.size.height;
//            _scrollVH +=subImage.frame.size.height;
//            subImage = nil;
//        }
//        _scrollVH += 5;
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //    尾部图文详情--------------------------------------------------------------
        UIView *tuwenXQView = [[UIView alloc] init];
        tuwenXQView.backgroundColor = [UIColor whiteColor];
        CGFloat tuwenXQViewH = 0;
       
        
        
        UIImage *subimgae = [UIImage imageNamed:@""];//jinpinxia
        CGFloat subImageH = 100;//subimgae.size.height*(BOUND_WIDTH/subimgae.size.width)
        
        
        CGFloat subImgesY = 0;
        NSArray *subUrl=[pDetailsDic[@"excellentSubPicture"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",;"]];
        NSMutableArray *subPhotosUrl =[[NSMutableArray alloc] initWithArray:subUrl];
        [subPhotosUrl removeObject:@""];
        
        
        for (int i=0; i<subPhotosUrl.count; i++) {
            
            UIImageView *subImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, subImgesY, BOUND_WIDTH, subImageH)];
            [tuwenXQView addSubview:subImage];
            NSString *urlStr = [@"" stringByAppendingString:subPhotosUrl[i]?subPhotosUrl[i]:@""];
            urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            
            WS(weakSelf);
            [subImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:subimgae completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    CGFloat imageH = image.size.height;
                    CGFloat imageW = image.size.width;
                    CGFloat newSubImageH = imageH/imageW*BOUND_WIDTH;
                    if (cacheType==SDImageCacheTypeMemory) {
                        CGRect oldRect = subImage.frame;
                        oldRect.size.height = newSubImageH;
                        
                        subImage.frame = oldRect;
                    } else if (cacheType==SDImageCacheTypeDisk||cacheType==SDImageCacheTypeNone) {
                        
                        CGFloat gapH = newSubImageH - subImageH;
                        [weakSelf subImageView:subImage ChangeHeight:gapH];
                    }
                }
            }];
            //        subImage.contentMode =UIViewContentModeScaleAspectFit;
            //subImage.userInteractionEnabled = YES;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImage:)];
//            [subImage addGestureRecognizer:tap];
            subImgesY+=subImage.frame.size.height;
            tuwenXQViewH +=subImage.frame.size.height;
            subImage = nil;
        }
        
        tuwenXQView.frame = CGRectMake(0, _scrollVH, BOUND_WIDTH, tuwenXQViewH);
        [scrollView addSubview:tuwenXQView];
        _scrollVH += tuwenXQViewH+10;
        
        
        
        
        
        
        
        
        
       scrollView.contentSize = CGSizeMake(BOUND_WIDTH, _scrollVH);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    } error:^(NSError *error) {
        scrollView.contentSize = CGSizeMake(BOUND_WIDTH, BOUND_HIGHT);
        
    } HUDAddView:self.view];
    
    
    
 
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
