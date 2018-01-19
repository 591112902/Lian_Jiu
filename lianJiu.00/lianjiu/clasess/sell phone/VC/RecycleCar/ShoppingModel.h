//
//  ShoppingModel.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject


@property(assign,nonatomic) BOOL isExpress;//huihsoufangshi

@property(copy,nonatomic) NSString *orItemsId;//商品图片

@property(copy,nonatomic) NSString *orItemsPicture;//商品图片


@property(copy,nonatomic) NSString *orItemsName;//商品标题
//@property(copy,nonatomic) NSString *goodsType;//商品类型
@property(copy,nonatomic) NSString *orItemsPrice;//商品单价

@property(copy,nonatomic) NSString *orItemsProductId;//商品ID
@property(copy,nonatomic) NSString *orItemsParam;//商品json


@property(assign,nonatomic) BOOL selectState;//是否选中状态

@property(copy,nonatomic) NSString *orItemsNum;//商品个数





-(instancetype)initWithShopDict:(NSDictionary *)dict;




@end
