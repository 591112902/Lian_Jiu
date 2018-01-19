

#import "networking.h"
#import "NSString+MD5.h"
@implementation networking

//加了MbprogrssHUD
+ (void)AFNRequest:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    //开发后面增加参数------------
    parameters = [self addNewParameter:parameters];
    // -------------
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            case -2:
                [self loginAgain];
                break;
            default:
                
                [MBProgressHUD showNotPhotoError:dict[@"msg"] toView:superView];
                break;
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        if (errorBack) {
            errorBack(error);
        }else{
            [MBProgressHUD showError:@"网络不给力" toView:superView];
            
        }

    }];

}
#pragma mark-没有判断返回值
//没有判断返回值
+ (void)AFNRequestNotCode:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    //开发后面增加参数------------
    parameters = [self addNewParameter:parameters];
    // -------------
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideAllHUDsForView:superView animated:NO];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (callBack) {
            callBack(dict);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:view?view:superView animated:NO];
        if (errorBack) {
            errorBack(error);
        }else{
            
            [MBProgressHUD showError:@"获取数据失败或网络不给力" toView:superView];
        }

    }];

}
+ (void)AFNPOST:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    //开发后面增加参数------------
    parameters = [self addNewParameter:parameters];
    // -------------
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;

    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            case -2:
                [self loginAgain];
                break;
            default://请完善个人信息
                [MBProgressHUD showSuccess:dict[@"msg"] toView:superView];
                break;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        if (errorBack) {
            errorBack(error);
        }else{
            [MBProgressHUD showError:@"网络不给力" toView:superView];
        }

    }];

}

+ (void)AFNPOSTNotCode:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    //开发后面增加参数------------
    parameters = [self addNewParameter:parameters];
    // -------------
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //UIView *superView =[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (callBack) {
            
            
            callBack(dict);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        if (errorBack) {
            errorBack(error);
        }else{
            [MBProgressHUD showError:@"网络不给力" toView:view];
        }

    }];

    
}
//上传1图片
+ (void)AFNPOSTfile:(NSString *)url withparameters:(NSDictionary *)parameters data:(NSData *)data dataName:(NSString *)dataName success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *fileName = [self fileNameWithLastname:@".jpg"];

    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
   
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:dataName fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            default:
                [MBProgressHUD showError:dict[@"msg"] toView:superView];
                break;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        if (errorBack) {
            errorBack(error);
        }else{
            [MBProgressHUD showError:@"获取数据失败或网络不给力" toView:superView];
        }

    }];
    
}
// 上传多张图片 不同参数名
+ (void)AFNPOSTMutableDicfile:(NSString *)url withparameters:(NSDictionary *)parameters dataSource:(NSDictionary *)datadic success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
   
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *dataName in datadic.allKeys) {
            NSString *fileName = [self fileNameWithLastname:[NSString stringWithFormat:@"%@.jpg",dataName ]];
            [formData appendPartWithFileData:datadic[dataName] name:dataName fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            default:
                [MBProgressHUD showError:dict[@"msg"] toView:superView];
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        if (errorBack) {
            errorBack(error);
        }else{
            [MBProgressHUD showError:@"获取数据失败或网络不给力" toView:superView];
        }
    }];
}
//带进度的上传多张图片 同一个参数名---wll
+ (void)AFNPOSTMutableArrfile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName dataSource:(NSArray *)datadic success:(callBack )callBack progress:(progressBack )progressBack  error:(errorBack)errorBack HUDAddView:(UIView*)view{
    if (datadic.count==0) {
        if (callBack) {
            callBack([NSMutableDictionary dictionaryWithDictionary:@{@"response":@""}]);
        }
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSData *data in datadic) {
            NSString *fileName = [self fileNameWithLastname:[NSString stringWithFormat:@"%@.jpg",dataName ]];
            [formData appendPartWithFileData:data name:dataName fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
        if (progressBack) {
            progressBack(uploadProgress);
        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            default:
                [MBProgressHUD showSuccess:dict[@"msg"] toView:superView];
                
                break;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD hideAllHUDsForView:view?view:superView animated:NO];
        
        [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"提交上传失败", nil) toView:superView];
        
        if (errorBack) {
            errorBack(error);
        }
    }];
    
}


//*)*)&)&)带进度的上传多张图片 同一个参数名---wll&*&(&(&(&
+ (void)GAFNPOSTMutableArrfile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName dataSource:(NSArray *)datadic success:(callBack )callBack progress:(progressBack )progressBack  error:(errorBack)errorBack HUDAddView:(UIView*)view{
    if (datadic.count==0) {
        if (callBack) {
            callBack([NSMutableDictionary dictionaryWithDictionary:@{@"response":@""}]);
        }
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSData *data in datadic) {
            NSString *fileName = [self fileNameWithLastname:[NSString stringWithFormat:@"%@.jpg",dataName ]];
            [formData appendPartWithFileData:data name:dataName fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
        if (progressBack) {
            progressBack(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"code"];
        int c = [code intValue];
        switch (c) {
            case 0:
                if (callBack) {
                    callBack(dict);
                }
                break;
            default:
                [MBProgressHUD showSuccess:dict[@"msg"] toView:superView];
                
                break;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD hideAllHUDsForView:view?view:superView animated:NO];
        
        [MBProgressHUD showNotPhotoError:@"图片上传失败" toView:superView];
        
        if (errorBack) {
            errorBack(error);
        }
    }];
    
}




#pragma mark-上传多张图片 同一个参数名---没改没改没改没改没改没改---前..
//上传多张图片 同一个参数名---没改没改没改没改没改没改---前..
+ (void)AFNPOSTMutableArrfile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName dataSource:(NSArray *)datadic success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    if (datadic.count==0) {
        if (callBack) {
            callBack([NSMutableDictionary dictionaryWithDictionary:@{@"response":@""}]);
        }
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSData *data in datadic) {
            NSString *fileName = [self fileNameWithLastname:[NSString stringWithFormat:@"%@.jpg",dataName ]];
            [formData appendPartWithFileData:data name:dataName fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            default:
                [MBProgressHUD showSuccess:dict[@"msg"] toView:superView];
                
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        [MBProgressHUD showNotPhotoError:@"图片上传失败" toView:superView];
    }];
    
}








//上传多个本地文件 同一个参数名 pahts:urls
+ (void)AFNPOSTMutableArrUrlFile:(NSString *)url withparameters:(NSDictionary *)parameters dataName:(NSString *)dataName pahts:(NSArray *)paths success:(callBack )callBack error:(errorBack)errorBack HUDAddView:(UIView*)view{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIView *superView = view?view:[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *url in paths) {
            NSData *data = [NSData dataWithContentsOfFile:url];
            NSString *fileName = [url lastPathComponent];
            [formData appendPartWithFileData:data name:dataName fileName:fileName mimeType:@"application/octet-stream"];
            data = nil;
            
            //            NSString *fileName = [self fileNameWithLastname:[NSString stringWithFormat:@"%@.jpg",dataName ]];
            //            [formData appendPartWithFileURL:[NSURL URLWithString:url] name:dataName error:nil];
            //            [formData appendPartWithFileURL:[NSURL URLWithString:url] name:dataName fileName:fileName mimeType:@"application/octet-stream" error:nil];
        }

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            default:
                [MBProgressHUD showError:dict[@"msg"] toView:superView];
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:superView animated:NO];
        if (errorBack) {
            errorBack(error);
        }else{
            [MBProgressHUD showError:@"获取数据失败或网络不给力" toView:superView];
        }
    }];
}
+ (void)AFNRequestNotHUD:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack{
    //开发后面增加参数------------
    parameters = [self addNewParameter:parameters];
    // -------------
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            case -2:
                [self loginAgain];
                break;
            default:
                [MBProgressHUD showError:dict[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBack) {
            errorBack(error);
        }else{
            [MBProgressHUD showError:@"获取数据失败或网络不给力" toView:[UIApplication sharedApplication].keyWindow];
        }
    }];
}
+ (void)AFNPOSTNotHUD:(NSString *)url withparameters:(NSDictionary *)parameters success:(callBack )callBack error:(errorBack)errorBack{
    //开发后面增加参数------------
    parameters = [self addNewParameter:parameters];
    // -------------
   
   
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber *code=dict[@"status"];
        
        if ([dict[@"msg"] isEqualToString:@"用户未绑定链旧账号"]){
            if (callBack) {
                callBack(dict);
            }
            
        }
        
        int c = [code intValue];
        switch (c) {
            case 200:
                if (callBack) {
                    callBack(dict);
                }
                break;
            case -2:
                [self loginAgain];
                break;
            default:
                //[MBProgressHUD showError:dict[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (errorBack) {
            errorBack(error);
        }else{
            //[MBProgressHUD showError:CustomLocalizedString(@"网络不给力", nil) toView:[UIApplication sharedApplication].keyWindow];
        }
    }];
}
+ (NSString *)fileNameWithLastname:(NSString *)lastName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@%@", str,lastName];
    return fileName;
}
//开发后面增加参数------------
+(NSDictionary *)addNewParameter:(NSDictionary *)parameters
{
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *sessionid = [def objectForKey:@"sessionid"];
    if (sessionid) {
        [para setObject:sessionid forKey:@"sessionid"];
    }
    return para;
}
+(void)loginAgain
{
    [MBProgressHUD showNotPhotoError:CustomLocalizedString(@"请重新登录", nil) toView:[UIApplication sharedApplication].keyWindow];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"vip"];
//    [defaults removeObjectForKey:@"sessionid"];
    [defaults setObject:@"" forKey:@"vip"];
    [defaults setBool:NO forKey:@"islogin"];
    [defaults setBool:NO forKey:@"isRealName"];
    [defaults synchronize];
    //    删除归档模型
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:ACCOUNTPATH]) {
        [defaultManager removeItemAtPath:ACCOUNTPATH error:nil];
    }
}
@end
