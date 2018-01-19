//
//  AccountModel.m
//  zaiShang
//
//  Created by cnmobi on 15/12/7.
//  Copyright © 2015年 CNMOBI. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
+(instancetype)ModelWith:(NSDictionary *)dic
{
    AccountModel *model =[[self alloc] init];
    
    model.userAsset =dic[@"userAsset"];
    model.accumulatedAmount =dic[@"accumulatedAmount"];
    model.grade =dic[@"grade"];
    model.userphoto =dic[@"userphoto"];
    model.username =dic[@"username"];
    model.integral =dic[@"integral"];
    model.isPwd =dic[@"isPwd"];
    model.userPhone =dic[@"userPhone"];
    model.nickName =dic[@"nickName"];
    
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.userAsset forKey:@"userAsset"];
    [aCoder encodeObject:self.accumulatedAmount forKey:@"accumulatedAmount"];
    [aCoder encodeObject:self.grade forKey:@"grade"];
    [aCoder encodeObject:self.userphoto forKey:@"userphoto"];
    [aCoder encodeObject:self.username forKey:@"username"];
    
    [aCoder encodeObject:self.integral forKey:@"integral"];
//    [aCoder encodeObject:self.line_credit forKey:@"line_credit"];
//    [aCoder encodeObject:self.logindate forKey:@"logindate"];
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeObject:self.payment forKey:@"payment"];
//    [aCoder encodeObject:self.phone forKey:@"phone"];
//    [aCoder encodeObject:self.photo forKey:@"photo"];
////    [aCoder encodeObject:self.pwd forKey:@"pwd"];
//    [aCoder encodeObject:self.referrer_vip forKey:@"referrer_vip"];
//    [aCoder encodeObject:self.register_time forKey:@"register_time"];
//    [aCoder encodeObject:self.sex forKey:@"sex"];
//    [aCoder encodeObject:self.usr_status forKey:@"usr_status"];
//    [aCoder encodeObject:self.vip forKey:@"vip"];
//    [aCoder encodeObject:self.vip_member forKey:@"vip_member"];
//    [aCoder encodeObject:self.tb_chit forKey:@"tb_chit"];
//    
//    //vipState
//    
//    
//    [aCoder encodeObject:self.vipState forKey:@"vipState"];
//    [aCoder encodeObject:self.v_type forKey:@"v_type"];
//    [aCoder encodeObject:self.v_time forKey:@"v_time"];
//    [aCoder encodeObject:self.v_kdate forKey:@"v_kdate"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        
        self.userAsset = [aDecoder decodeObjectForKey:@"userAsset"];
        self.accumulatedAmount = [aDecoder decodeObjectForKey:@"accumulatedAmount"];
        self.grade = [aDecoder decodeObjectForKey:@"grade"];
        self.userphoto = [aDecoder decodeObjectForKey:@"userphoto"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        //
        
        self.integral = [aDecoder decodeObjectForKey:@"integral"];
//        self.line_credit = [aDecoder decodeObjectForKey:@"line_credit"];
//        self.logindate = [aDecoder decodeObjectForKey:@"logindate"];
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.payment = [aDecoder decodeObjectForKey:@"payment"];
//        self.phone = [aDecoder decodeObjectForKey:@"phone"];
//        self.photo = [aDecoder decodeObjectForKey:@"photo"];
////        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
//        self.referrer_vip = [aDecoder decodeObjectForKey:@"referrer_vip"];
//        self.register_time = [aDecoder decodeObjectForKey:@"register_time"];
//        self.sex = [aDecoder decodeObjectForKey:@"sex"];
//        self.usr_status = [aDecoder decodeObjectForKey:@"usr_status"];
//        self.vip = [aDecoder decodeObjectForKey:@"vip"];
//        self.vip_member = [aDecoder decodeObjectForKey:@"vip_member"];
//        self.tb_chit = [aDecoder decodeObjectForKey:@"tb_chit"];
//        
//        
//        
//        //vipState
//        self.vipState = [aDecoder decodeObjectForKey:@"vipState"];
//        self.v_type = [aDecoder decodeObjectForKey:@"v_type"];
//        self.v_time = [aDecoder decodeObjectForKey:@"v_time"];
//        self.v_kdate = [aDecoder decodeObjectForKey:@"v_kdate"];
        
        
    }
    return self;
}

@end
