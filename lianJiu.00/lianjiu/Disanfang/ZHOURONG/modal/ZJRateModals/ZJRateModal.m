//
//  ZJRateModal.m
//  Lianjiuwang
//
//  Created by Fadada-Zhou on 2017/10/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ZJRateModal.h"

@implementation ZJRateModal


-(instancetype)initWithString:(NSString *)paramString{
    self = [super init];
    if(self)
    {
        NSData *data = [paramString?paramString:@"" dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableArray *headers = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in jsonArray) {
            
            ZJRateHeader *header = [[ZJRateHeader alloc] init];
            header.rows          = [[NSMutableArray alloc] init];
            header.headerName    = [dic objectForKey:@"major"];
            
            NSArray *rows = [dic objectForKey:@"children"];
            for (NSDictionary *rowDic in rows) {
                ZJRateRow *row  = [[ZJRateRow alloc] init];
                row.rowName     = [rowDic objectForKey:@"major"];
                row.values      = [[NSMutableArray alloc] init];
                NSArray *values = [rowDic objectForKey:@"children"];
                
                for (NSDictionary *valueDic in values) {
                    ZJRateValue *value = [[ZJRateValue alloc] init];
                    value.value  = [valueDic objectForKey:@"major"];
                    
                    [row.values addObject:value];
                }
                [header.rows addObject:row];
            }
            
            [headers addObject:header];
        }
        
        self.headers = headers;
    }
    return self;
}

@end
