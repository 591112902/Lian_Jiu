


#import "HelpCenterVC.h"

#import "HelpCenterCollectionViewCell.h"
#import "ScrapListViewController.h"
#import "ScrapModel.h"

@interface HelpCenterVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@end
@implementation HelpCenterVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGColor;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    flowLayout.itemSize = CGSizeMake((BOUND_WIDTH-15)/2-0.001, 132);
    flowLayout.sectionInset =UIEdgeInsetsMake(0, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3, 5, (BOUND_WIDTH-flowLayout.itemSize.width*2)/3);//上左下右
    flowLayout.minimumLineSpacing = 5;
    flowLayout. minimumInteritemSpacing = 5;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, BOUND_WIDTH, BOUND_HIGHT-10) collectionViewLayout:flowLayout];
    
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"HelpCenterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HelpCenterCollectionViewCell"];
    _collectionView.backgroundColor = BGColor;
    [self.view addSubview:_collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;//
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HelpCenterCollectionViewCell*  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HelpCenterCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.headImage.image = [UIImage imageNamed:@"kuaidididi"];
        cell.title.text = @"快递回收";
        cell.detailTitle.text = @"(卖手机回收)";
    }else if (indexPath.row==1) {
        cell.headImage.image = [UIImage imageNamed:@"sahngmenmenemen"];
        cell.title.text = @"上门回收";
        cell.detailTitle.text = @"(卖家电,卖废品回收)";
    }else if (indexPath.row==2) {
        cell.headImage.image = [UIImage imageNamed:@"kxiuixuxiuxixu"];
        cell.title.text = @"手机快修";
        cell.detailTitle.hidden = YES;
    }else if (indexPath.row==3) {
        cell.headImage.image = [UIImage imageNamed:@"qianqinqianqina"];
        cell.title.text = @"链旧钱包";
        cell.detailTitle.hidden = YES;
    }
   
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HDdetailViewController *hdvc = [[HDdetailViewController alloc] init];
    hdvc.index = indexPath.row;
    
    if (indexPath.row==0) {
       
        hdvc.title = @"快递回收";
       
    }else if (indexPath.row==1) {
      hdvc.title = @"上门回收";
      
    }else if (indexPath.row==2) {
       hdvc.title = @"手机快修";
      
    }else if (indexPath.row==3) {
        hdvc.title = @"链旧钱包";
       
    }

    
    
    
    [self.navigationController pushViewController:hdvc animated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
