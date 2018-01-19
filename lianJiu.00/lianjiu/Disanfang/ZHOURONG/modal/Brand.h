//
//  Brand.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject

@property(nonatomic,copy)NSString    * categoryId;
@property(nonatomic,copy)NSNumber    * categoryParentId;

@property(nonatomic,copy)NSString    * categoryName;
@property(nonatomic,copy)NSString    * categoryImage;
@property(nonatomic,copy)NSNumber    * categoryRetrieveType;
@property(nonatomic,copy)NSNumber    * categoryStatus;
@property(nonatomic,copy)NSNumber    * categorySortOrder;
@property(nonatomic,copy)NSNumber    * categoryIsParent;
@property(nonatomic,copy)NSString    * categoryParamTemplateId;
@property(nonatomic,copy)NSString    * categoryCreated;
@property(nonatomic,copy)NSString    * categoryUpdated;

@end
