//
//  TuiMulPhotoCollectionViewController.m
//  lianjiu
//
//  Created by LIHONG on 2017/11/17.
//  Copyright © 2017年 CNMOBI. All rights reserved.
//

#import "TuiMulPhotoCollectionViewController.h"


#import "PhotoCollectionViewCell.h"
#import "GWLPhotoLibrayController.h"
#import "PhonwRecoveryCollectionReusableView.h"
#import "UIImageView+WebCache.h"
#define CELLWIDTH  (BOUND_WIDTH-85)/3

@interface TuiMulPhotoCollectionViewController ()<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation TuiMulPhotoCollectionViewController
{
    
    UIImage *lastImage;
    NSString *headReuseIdentifier;
    NSIndexPath *currPaht;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
  //  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    lastImage = [UIImage imageNamed:@"phone_default"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FileCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FileCollectionViewCell"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    headReuseIdentifier = @"PhonwRecoveryCollectionReusableView";
    [self.collectionView registerClass:[PhonwRecoveryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseIdentifier];
    [self.collectionView registerClass:[PhonwRecoveryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headReuseIdentifier];

    
    
    
    
    
    
    // Do any additional setup after loading the view.
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutViewFram];
}
- (void)dealloc
{
    HZLog(@"%@------dealloc",[self class]);
}

#pragma mark - 添加图片
- (void)addPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"添加照片"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从相册获取", @"拍照",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view.superview];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addPhotoWithPhotoLibrary];
    }else if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker = nil;
    }
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    image = [image fixOrientation];
    [self displayImages:@[image]];
    image = nil;
}
- (void)addPhotoWithPhotoLibrary {
    //    __weak typeof (self)weakSelf = self;
    WS(weakSelf);
    GWLPhotoLibrayController *photoSelector = [GWLPhotoLibrayController photoLibrayControllerWithBlock:^(NSArray *images) {
        [weakSelf displayImages:images];
    }];
    PhotoMultModel *model = self.dataSource[currPaht.section];
    photoSelector.maxCount = model.photoNumber-model.photoDataSouc.count;
    photoSelector.multiAlbumSelect = YES;
    [self presentViewController:photoSelector animated:YES completion:nil];
}

- (void)displayImages:(NSArray *)images {
    
    PhotoMultModel *model = self.dataSource[currPaht.section];
    [model.photoDataSouc addObjectsFromArray:images];
    
    if (model.photoDataSouc.count>=model.photoNumber) {
        model.isaddPhoto = NO;
        NSRange range = NSMakeRange(model.photoNumber, model.photoDataSouc.count-model.photoNumber);
        [model.photoDataSouc removeObjectsInRange:range];
    }
    [self layoutViewFram];
    [self.collectionView reloadData];
    images = nil;
}
-(void)addFile
{
}
#pragma mark - ColletionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    PhotoMultModel *model = self.dataSource[section];
    return model.isaddPhoto?model.photoDataSouc.count+1:model.photoDataSouc.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoMultModel *model = self.dataSource[indexPath.section];
    if (indexPath.section<self.dataSource.count) {
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
        if (!model.isaddPhoto||model.photoDataSouc.count!=indexPath.row) {
            if ([model.photoDataSouc[indexPath.row]  isKindOfClass:[UIImage class]]) {
                cell.photoImage.image = model.photoDataSouc[indexPath.row];
            }else{
                cell.photoImage.userInteractionEnabled = NO;
                NSString *url = [@"" stringByAppendingString:model.photoDataSouc[indexPath.row]];
                [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"180x180"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    //                    [model.photoDataSouc replaceObjectAtIndex:indexPath.row withObject:image];
                    cell.photoImage.userInteractionEnabled = YES;
                }];
            }
            
        }else{
            cell.photoImage.image = [UIImage imageNamed:@"Add-to"];
            
            //            if (indexPath.section == 0) {
            //
            //
            //                 cell.photoImage.image = [UIImage imageNamed:@"zhutuAPP"];
            //            }else if (indexPath.section == 1){
            //                cell.photoImage.image = [UIImage imageNamed:@"xiangqingAPP"];
            //            }
            
        }
        return cell;
    }else{
        
        return nil;
    }
    
    
}
#pragma mark-定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //(self.view.frame.size.width-140)/3-0.01
    return CGSizeMake(CELLWIDTH, CELLWIDTH);
}
#pragma mark-设置单元格间的横向间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    currPaht = indexPath;
    PhotoMultModel *model = self.dataSource[indexPath.section];
    if (indexPath.section<self.dataSource.count) {
        if (model.isaddPhoto&&indexPath.row==model.photoDataSouc.count) {
            [self addPhoto];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除图片" message:@"是否删除该图片" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            [alertView show];
        }
    }else{
        if (model.isaddPhoto&&indexPath.row==model.photoDataSouc.count) {
            [self addFile];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除文件" message:@"是否删除该文件" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            [alertView show];
        }
    }
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    PhotoMultModel *model = self.dataSource[indexPath.section];
    if (model.headTitle||model.footTitle) {
        UICollectionReusableView *reusableview = nil;
        PhonwRecoveryCollectionReusableView *view = [collectionView
                                                     dequeueReusableSupplementaryViewOfKind:kind
                                                     withReuseIdentifier:headReuseIdentifier
                                                     forIndexPath:indexPath];
        
        if (kind == UICollectionElementKindSectionHeader) {
            view.label.text = model.headTitle;
            view.label.numberOfLines = 2;
            view.label.font = [UIFont systemFontOfSize:15];
            view.label.textColor = [UIColor grayColor];
            reusableview = view;
        }else if(kind==UICollectionElementKindSectionFooter)
        {
            view.label.text = model.footTitle;
            view.label.font = [UIFont systemFontOfSize:15];
            view.label.textColor = [UIColor grayColor];
            reusableview = view;
        }
        return reusableview;
    }
    
    return nil;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        PhotoMultModel *model = self.dataSource[currPaht.section];
        [model.photoDataSouc removeObjectAtIndex:currPaht.row];
        if (!model.isaddPhoto) {
            model.isaddPhoto = YES;
        }else{
            [self layoutViewFram];
        }
        [self.collectionView reloadData];
    }
}


- (void)layoutViewFram
{
    //self.view.frame.size.width/5.0
    //ceil (3/3.0) *(self.view.frame.size.width-40)/3+(ceil (3/3.0)+1)*10+40
    CGRect rect = self.view.frame;
    CGFloat collectionViewH = 0;
    for (PhotoMultModel *model in self.dataSource) {
        //NSInteger photoNum = model.isaddPhoto?model.photoDataSouc.count+1:model.photoDataSouc.count;
        collectionViewH +=CELLWIDTH+25 ;
        // UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        if (model.headTitle) {
            collectionViewH +=0;
        }
        if (model.footTitle) {
            collectionViewH +=0;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:ChangeHeight:)]) {
        //[self.delegate collectionView:self.view ChangeHeight:collectionViewH-rect.size.height];
    }
    
    
    rect.size.height = collectionViewH;
    self.view.frame = rect;
}

@end
