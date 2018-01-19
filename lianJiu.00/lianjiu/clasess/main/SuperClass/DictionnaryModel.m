//
//  DictionnaryModel.m
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "DictionnaryModel.h"

@implementation DictionnaryModel
+(instancetype)ModelWithDictionnary:(NSDictionary *)dic
{
   DictionnaryModel *model = [[self alloc] init];
    model.title = dic.allKeys.firstObject;
    model.value = dic.allValues.firstObject;
    model.keyboardType = UIKeyboardTypeDefault;
    
  
    
    return model;
}
@end