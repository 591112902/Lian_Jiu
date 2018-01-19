//
//  GWLPhotoGroupDetailController.m
//  GWLPhotoSelector
//
//  Created by GaoWanli on 15/7/23.
//  Copyright (c) 2015年 GWL. All rights reserved.
//

#import "GWLPhotoGroupDetailController.h"

@interface GWLPhotoCell : UICollectionViewCell

@property(nonatomic, strong) GWLPhotoALAssets *photoALAsset;

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UIView *selectedView;
@property(nonatomic, weak) UIButton *selectedBtn;

@end

@implementation GWLPhotoCell

- (void)setPhotoALAsset:(GWLPhotoALAssets *)photoALAsset {
    _photoALAsset = photoALAsset;
    if (GWLPhotoSelector_Above_iOS8) {
        [self imageWithAsset:photoALAsset.photoAsset completion:^(UIImage *image) {
            self.iconView.image = image;
        }];
    }else {
        ALAsset *alasset = photoALAsset.photoALAsset;
        if ([[alasset valueForProperty:@"ALAssetPropertyType"] isEqualToString:ALAssetTypePhoto]) {
            self.iconView.image = [UIImage imageWithCGImage:alasset.thumbnail];
        }
    }
    
    self.selectedView.hidden = !photoALAsset.isSelected;
    self.selectedBtn.hidden = !photoALAsset.isSelected;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:self.bounds];
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.clipsToBounds = YES;
        [self.contentView addSubview:iconView];
        _iconView = iconView;
    }
    return _iconView;
}

- (UIView *)selectedView {
    if (!_selectedView) {
        UIView *selectedView = [[UIView alloc]initWithFrame:self.bounds];
        selectedView.backgroundColor = [UIColor whiteColor];
        selectedView.alpha = 0.2f;
        [self.iconView addSubview:selectedView];
        _selectedView = selectedView;
    }
    return _selectedView;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        UIButton *selectedBtn = [[UIButton alloc]init];
        selectedBtn.userInteractionEnabled = NO;
//        NSString *imageFile = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"GWLPhotoSelector.bundle/sel@2x.png"];
        [selectedBtn setImage:[UIImage imageNamed:@"sel"] forState:UIControlStateNormal];
        CGFloat margin = 5;
        selectedBtn.frame = CGRectMake(0, 0, selectedBtn.currentImage.size.width, selectedBtn.currentImage.size.height);
        CGFloat selectedBtnX = CGRectGetWidth(_iconView.frame) - CGRectGetWidth(selectedBtn.frame) - margin;
        CGFloat selectedBtnY = CGRectGetHeight(_iconView.frame) - CGRectGetHeight(selectedBtn.frame) - margin;
        selectedBtn.frame = CGRectMake(selectedBtnX, selectedBtnY, selectedBtn.currentImage.size.width, selectedBtn.currentImage.size.height);
        [self.iconView addSubview:selectedBtn];
        _selectedBtn = selectedBtn;
    }
    return _selectedBtn;
}

- (void)imageWithAsset:(PHAsset *)asset completion:(kGWLPhotoSelector_imageBlock)completion {
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(self.bounds.size.width * 2, self.bounds.size.height * 2) contentMode:PHImageContentModeAspectFill options:imageOptions resultHandler:^(UIImage *result, NSDictionary *info) {
        completion(result);
    }];
}

@end

@interface GWLPhotoGroupDetailController ()

@property(nonatomic, strong) NSMutableArray *selectedPhotos;
@property(nonatomic, assign) NSInteger photosCount;
@property(nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation GWLPhotoGroupDetailController

static NSString * const reuseIdentifier = @"gwlPhotoCell";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - GWLPhotoSelector_RowPhotoCount * 2) / GWLPhotoSelector_RowPhotoCount;
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnClick:)];
    [self.collectionView registerClass:[GWLPhotoCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTitle];
}

- (void)doneBtnClick:(UIBarButtonItem *)doneBarButtonItem {
    doneBarButtonItem.enabled = NO;
    __weak typeof (self) selfVc = self;
    [[[NSOperationQueue alloc]init] addOperationWithBlock:^{
        for (GWLPhotoALAssets *photoALAsset in self.selectedPhotos) {
            if (GWLPhotoSelector_Above_iOS8) {
                [selfVc imageWithAsset:photoALAsset.photoAsset completion:^(UIImage *image) {
                    [selfVc.imageArray addObject:image];
                }];
            }else {
                ALAsset *sset = photoALAsset.photoALAsset;
                UIImage *originalImage = [self thumbnailForAsset:sset maxPixelSize:200];
                
//                ALAssetRepresentation *assetRepresentation = [sset defaultRepresentation];
//                CGFloat imageScale = [assetRepresentation scale];
//                UIImageOrientation imageOrientation = (UIImageOrientation)[assetRepresentation orientation];
//                UIImage *originalImage = [UIImage imageWithCGImage:sset.defaultRepresentation.fullScreenImage scale:imageScale orientation:imageOrientation];
                [selfVc.imageArray addObject:originalImage];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (selfVc.block) {
                [selfVc dismissViewControllerAnimated:YES completion:^{
                    selfVc.block(selfVc.imageArray);
                    selfVc.selectedPhotos = nil;
                    selfVc.imageArray = nil;
                }];
            }else {
                selfVc.selectedPhotos = nil;
                selfVc.imageArray = nil;
            }
        });
    }];
}

- (void)imageWithAsset:(PHAsset *)asset completion:(kGWLPhotoSelector_imageBlock)completion {
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.synchronous = YES;
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    CGFloat photoW = asset.pixelWidth>540?540:asset.pixelWidth;
    CGFloat photoH = asset.pixelHeight>960?960:asset.pixelHeight;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(photoW, photoH) contentMode:PHImageContentModeAspectFit options:imageOptions resultHandler:^(UIImage *result, NSDictionary *info) {
        completion(result);
    }];
}

- (void)setPhotoALAssets:(NSArray *)photoALAssets {
    _photoALAssets = photoALAssets;
    if (photoALAssets.count > 0)
        self.photosCount = photoALAssets.count - 1;
    [self.collectionView reloadData];
}

- (NSMutableArray *)selectedPhotos {
    if (!_selectedPhotos)
        _selectedPhotos = [NSMutableArray array];
    return _selectedPhotos;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoALAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GWLPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    GWLPhotoALAssets *photoALAssets = self.photoALAssets[self.photosCount - indexPath.row];
    cell.photoALAsset = photoALAssets;
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GWLPhotoALAssets *photoALAsset = self.photoALAssets[self.photosCount - indexPath.row];
    photoALAsset.selected = !photoALAsset.isSelected;
    
    if (photoALAsset.isSelected) {
        [self.selectedPhotos addObject:photoALAsset];
        if (self.selectedPhotos.count > self.maxCount) {
            [self.selectedPhotos removeLastObject];
            photoALAsset.selected = NO;
        }
    }
    else {
        [self.selectedPhotos removeObject:photoALAsset];
    }
    [self setupTitle];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)setupTitle {
    self.title = [NSString stringWithFormat:@"%zd / %zd", self.selectedPhotos.count, self.maxCount];
}

#pragma mark - getter && setter
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

#pragma mark - 压缩
static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ALAssetRepresentation *rep = (__bridge id)info;
    
    NSError *error = nil;
    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    
    if (countRead == 0 && error) {
        // We have no way of passing this info back to the caller, so we log it, at least.
        HZLog(@"thumbnailForAsset:maxPixelSize: got an error reading an asset: %@", error);
    }
    
    return countRead;
}

static void releaseAssetCallback(void *info) {
    // The info here is an ALAssetRepresentation which we CFRetain in thumbnailForAsset:maxPixelSize:.
    // This release balances that retain.
    CFRelease(info);
}

// Returns a UIImage for the given asset, with size length at most the passed size.
// The resulting UIImage will be already rotated to UIImageOrientationUp, so its CGImageRef
// can be used directly without additional rotation handling.
// This is done synchronously, so you should call this method on a background queue/thread.
- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size {
    NSParameterAssert(asset != nil);
    NSParameterAssert(size > 0);
    
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    
    CGDataProviderDirectCallbacks callbacks = {
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = releaseAssetCallback,
    };
    
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)CFBridgingRetain(rep), [rep size], &callbacks);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithInt:(int)size],
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                                                      });
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    
    return toReturn;
}

@end
