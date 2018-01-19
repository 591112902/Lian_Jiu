//
//  PhotoMultModel.m
//  zaiShang
//
//  Created by cnmobi on 15/12/19.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "PhotoMultModel.h"

@implementation PhotoMultModel
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.photoNumber =9;
        self.isaddPhoto = YES;
        self.photoDataSouc = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)setPhotoDataSouc:(NSMutableArray *)photoDataSouc
{
    _photoDataSouc = photoDataSouc;
    if (photoDataSouc.count > self.photoNumber) {
        self.isaddPhoto = NO;
        self.photoNumber = photoDataSouc.count;
    }
}
@end
