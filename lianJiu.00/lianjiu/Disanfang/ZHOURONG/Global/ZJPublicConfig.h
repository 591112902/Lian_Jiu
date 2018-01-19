//
//  ZJPublicConfig.h
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#ifndef ZJPublicConfig_h
#define ZJPublicConfig_h

#import "Brand.h"
#import "Product.h"
#import "LianjiuData.h"
#import "LianjiuDataP.h"
#import "AdElectronic.h"
#import "MainModal.h"
#import "ModalProduct.h"

//颜色
#define ZJColor_main [UIColor colorWithRed:4/255.0 green:209/255.0 blue:2/255.0 alpha:1.0]

//系统字体定义
#define FONT(F) [UIScreen mainScreen].bounds.size.width > 320.?[UIFont systemFontOfSize:(F+1)]:[UIFont systemFontOfSize:F]

//适配比例
#define ZJ_SCREEN_WIDTH_SCALE ([UIScreen mainScreen].bounds.size.width/375.)
#define ZJ_SCREEN_HEIGHT_SCALE ([UIScreen mainScreen].bounds.size.height/667.)

//侧边Tableview宽度
#define ZJ_LEFTTABLEVIEW_WIDTH 100*ZJ_SCREEN_WIDTH_SCALE
//广告栏高度
#define ZJ_ADIMAGEVIEW_HEIGHT (65)*ZJ_SCREEN_HEIGHT_SCALE
//tableviewcell 高度
#define ZJ_TATBLEVIWCELL_HEIGHT  65*ZJ_SCREEN_WIDTH_SCALE
//分页最大数
#define ZJ_MAXNUMPER_PAGE  100
//估价选择按钮 高度
#define ZJ_RATEBUTTON_HEIGHT 70*ZJ_SCREEN_HEIGHT_SCALE
#endif /* ZJPublicConfig_h */
