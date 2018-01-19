//
//  PhotoCollectionViewController.m
//  zaiShang
//
//  Created by cnmobi on 15/12/8.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "GWLPhotoLibrayController.h"
#import "PhonwRecoveryCollectionReusableView.h"
@interface PhotoCollectionViewController ()<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PhotoCollectionViewController
{
    BOOL isaddPhoto;
    UIImage *lastImage;
    NSString *headReuseIdentifier;
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = BGColor;
    if (self.photoDataSouc.count > self.photoNumber) {
        isaddPhoto = NO;
    }else{
        isaddPhoto = YES;
    }
    lastImage = [UIImage imageNamed:@"phone_default"];

    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    headReuseIdentifier = @"PhonwRecoveryCollectionReusableView";
    [self.collectionView registerClass:[PhonwRecoveryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseIdentifier];
}
- (NSMutableArray *)photoDataSouc
{
    if (!_photoDataSouc) {
        _photoDataSouc = [[NSMutableArray alloc] init];
    }
    return _photoDataSouc;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.view.frame =self.view.frame;
}
//- (void)willMoveToParentViewController:(UIViewController *)parent
//{
//    self.view.frame = self.rect;
//}


- (void)addPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:CustomLocalizedString(@"添加照片", nil)
                                  delegate:self
                                  cancelButtonTitle:CustomLocalizedString(@"取消", nil)
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:CustomLocalizedString(@"从相册获取", nil), CustomLocalizedString(@"拍照", nil),nil];
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
    CGFloat photoW = image.size.width>540?540:image.size.width;
    CGFloat photoH = image.size.height>960?960:image.size.height;
    image = [image imageCompressForSize:CGSizeMake(photoW, photoH)];
    [self displayImages:@[image]];
    image = nil;
}
- (void)addPhotoWithPhotoLibrary {
//    __weak typeof (self)weakSelf = self;
    WS(weakSelf);
    GWLPhotoLibrayController *photoSelector = [GWLPhotoLibrayController photoLibrayControllerWithBlock:^(NSArray *images) {
        [weakSelf displayImages:images];
    }];
    photoSelector.maxCount = self.photoNumber-self.photoDataSouc.count;
    photoSelector.multiAlbumSelect = YES;
    [self presentViewController:photoSelector animated:YES completion:nil];
}

- (void)displayImages:(NSArray *)images {
    
    [self.photoDataSouc addObjectsFromArray:images];
    
    if (self.photoDataSouc.count>=self.photoNumber) {
        isaddPhoto = NO;
        NSRange range = NSMakeRange(self.photoNumber, self.photoDataSouc.count-self.photoNumber);
        [self.photoDataSouc removeObjectsInRange:range];
    }
    [self layoutViewFram];
    [self.collectionView reloadData];
    images = nil;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return isaddPhoto?self.photoDataSouc.count+1:self.photoDataSouc.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    if (!isaddPhoto||self.photoDataSouc.count!=indexPath.row) {
        cell.photoImage.image = self.photoDataSouc[indexPath.row];
    }else{
        cell.photoImage.image = lastImage;
    }
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.view.frame.size.width-40)/3-0.01, (self.view.frame.size.width-40)/3);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (isaddPhoto&&indexPath.row==self.photoDataSouc.count) {
        [self addPhoto];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:CustomLocalizedString(@"删除图片", nil) message:CustomLocalizedString(@"是否删除该图片", nil) delegate:self cancelButtonTitle:CustomLocalizedString(@"是", nil) otherButtonTitles:CustomLocalizedString(@"否", nil), nil];
        alertView.tag= indexPath.row;
        [alertView show];
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.headTitle) {
        UICollectionReusableView *reusableview = nil;
        PhonwRecoveryCollectionReusableView *view = [collectionView
                                                     dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                     withReuseIdentifier:headReuseIdentifier
                                                     forIndexPath:indexPath];
        
        if (kind == UICollectionElementKindSectionHeader) {
            view.label.text = self.headTitle;
            view.label.font = PFR15Font;
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
        [self.photoDataSouc removeObjectAtIndex:alertView.tag];
        if (!isaddPhoto) {
            isaddPhoto = YES;
        }else{
            [self layoutViewFram];
        }
        [self.collectionView reloadData];
    }
}

- (void)layoutViewFram
{
    CGRect rect = self.view.frame;
    NSInteger photoNum = isaddPhoto?self.photoDataSouc.count+1:self.photoDataSouc.count;
    rect.size.height = ceil (photoNum/3.0) *(self.view.frame.size.width-40)/3+(ceil (photoNum/3.0)+1)*10;
    if (self.headTitle) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        rect.size.height+=layout.headerReferenceSize.height;
    }
        if ([self.delegate respondsToSelector:@selector(collectionView:ChangeHeight:)]) {
            [self.delegate collectionView:self.view ChangeHeight:rect.size.height-self.view.frame.size.height];
        }
        self.view.frame = rect;
}


- (void)dealloc
{
    HZLog(@"%@------dealloc",[self class]);
}
@end
