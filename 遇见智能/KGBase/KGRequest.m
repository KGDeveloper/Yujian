//
//  KGRequest.m
//  智能青旅
//
//  Created by KG on 2017/12/14.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGRequest.h"

@implementation KGRequest

static KGRequest *sharedObj = nil;
+ (KGRequest*) sharedInstance
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

- (AFHTTPSessionManager *)manger{
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"zhu" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:securityPolicy];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json", @"text/html", nil]];
    return  manager;
}

#pragma mark -登录请求-
- (void)loginWithPhone:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"phoneNo"];
    [dic setObject:passWord forKey:@"passWord"];
    [dic setObject:@"iphone" forKey:@"type"];
    
    [[self manger] POST:KGLogin parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"登录成功"]) {
            succ(@"登录成功",responseObject[@"data"]);
        }else{
            succ(@"登录失败",responseObject[@"data"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fail(@"登录失败");
    }];
}

#pragma mark -忘记密码请求-
- (void)forgetPassWord:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"phoneNo"];
    [dic setObject:passWord forKey:@"newPassWord"];

    [[self manger] POST:KGForget parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            succ(@"修改成功",responseObject);
        }else{
            fail(@"修改失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (fail)
        {
            fail(@"登录服务器失败");
        }
    }];
}

#pragma mark -注册请求-
- (void)registerUserName:(NSString *)userName phone:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userName forKey:@"userName"];
    [dic setObject:phone forKey:@"phoneNo"];
    [dic setObject:passWord forKey:@"passWord"];
    [[self manger] POST:KGRegister parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"注册成功"]) {
            succ(@"注册成功",responseObject[@"data"]);
        }else{
            succ(@"注册失败",responseObject[@"data"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fail(@"注册失败");
    }];
}

#pragma mark -商家修改手机号或者修改密码-
- (void)updateHotelMessageWithnewPassWord:(NSString *)newPassWord userId:(NSString *)userId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:newPassWord forKey:@"newPassWord"];
    [dic setObject:userId forKey:@"userId"];
    
    [[self manger] POST:KGRegister parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"注册成功"]) {
            succ(@"注册成功",responseObject[@"data"]);
        }else{
            succ(@"注册失败",responseObject[@"data"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        fail(@"注册失败");
    }];
}

#pragma mark -添加酒店-
- (void)addHotellMessageWithDictionary:(NSDictionary *)dci succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    [[self manger] POST:KGAddHotel parameters:dci success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"添加成功",responseObject[@"data"]);
        }else{
            succ(@"添加失败",responseObject[@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"网络出错");
    }];
}

#pragma mark -酒店首页-
- (void)homeUserPhone:(NSString *)phoneNo page:(NSString *)page pageSize:(NSString *)pageSize succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNo forKey:@"userId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    [dic setObject:@"iphone" forKey:@"type"];
    
    [[self manger] POST:KGHomeName parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject[@"data"]);
        }else{
            fail(@"请求失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"访问失败");
    }];
}

#pragma mark -酒店房间-
- (void)roomHotellId:(NSString *)hotelId page:(NSString *)page pageSize:(NSString *)pageSize succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:hotelId forKey:@"hotelId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    
    [[self manger] POST:KGHotelQueryRooms parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject[@"data"]);
        }else{
            fail(@"请求失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"网络出错");
    }];
    
}

#pragma mark -添加房间-
- (void)addRoomWithDictionary:(NSMutableDictionary *)dic succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    [[self manger] POST:KGAddHotelRoom parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"添加房间成功"]) {
            succ(@"添加成功",responseObject[@"data"]);
        }else{
            fail(@"添加失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"访问服务器失败");
    }];
}

#pragma mark -房态-
- (void)roomStareHotellId:(NSString *)hotelId page:(NSString *)page pageSize:(NSString *)pageSize succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:hotelId forKey:@"hotelId"];
    [dic setObject:page forKey:@"page"];
    [dic setObject:pageSize forKey:@"pageSize"];
    
    [[self manger] POST:KGRoomStare parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject[@"data"]);
        }else{
            fail(@"查询失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -删除酒店-
- (void)deleteHotell:(NSString *)hotellId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:hotellId forKey:@"hotelId"];
    
    [[self manger] POST:KGDeleteHotel parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject);
        }else{
            fail(@"失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -删除房间-
- (void)deleteRoom:(NSString *)roomId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:roomId forKey:@"roomId"];
    
    [[self manger] POST:KGDeleteHotelRoom parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject);
        }else{
            fail(@"删除失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -修改酒店信息-
- (void)changeHotelWithDictionary:(NSDictionary *)dic succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    [[self manger] POST:KGChangeHotelDetail parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"修改酒店信息成功"]) {
            succ(@"修改酒店信息成功",responseObject);
        }else{
            fail(@"修改酒店信息失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -修改酒店房间信息-
- (void)changeHotelRoomWithDictionary:(NSMutableDictionary *)dic succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    
    [[self manger] POST:KGUpdateHotelRoom parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"修改房间成功"]) {
            succ(@"修改房间信息成功",responseObject);
        }else{
            fail(@"修改房间信息信息失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -查询所有酒店名称和id-
- (void)allHodel:(NSString *)userId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    [[self manger] POST:KGAllHotel parameters:@{@"userId":userId} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject[@"data"]);
        }else{
            fail(@"查询失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -查询酒店所有房型-
- (void)hotelAllRoomType:(NSString *)hotelId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    
    [[self manger] POST:KGHotelAllRoomType parameters:@{@"hotelId":hotelId} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject[@"data"]);
        }else{
            fail(@"失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -添加订单-
- (void)addOrderWithDictionary:(NSDictionary *)parametes succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    [[self manger] POST:KGAddOrder parameters:parametes progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject);
        }else if ([responseObject[@"msg"] isEqualToString:@"该类型没有空房"]){
            fail(@"该类型没有房间");
        }else{
            fail(@"添加失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -确认订单-
- (void)changeOrderStatushotelCheckStatus:(NSString *)hotelCheckStatus orderId:(NSString *)orderId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:orderId forKey:@"orderId"];
    [dic setObject:hotelCheckStatus forKey:@"hotelCheckStatus"];
    
    [[self manger] POST:KGHotelOperateOrder parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject);
        }else{
            fail(@"失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -查询所有订单接口-
- (void)hotelAllOrder:(NSString *)userId queryType:(NSString *)queryType succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:queryType forKey:@"queryType"];
    
    [[self manger] POST:KGHotelQueryOrder parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject[@"data"]);
        }else{
            fail(@"失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"访问服务器失败");
        }
    }];
}

#pragma mark -查询订单详情接口-
- (void)orderDetaial:(NSString *)orderId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:orderId forKey:@"orderId"];
    
    [[self manger] POST:KGHotelQueryOrderDetail parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            succ(@"成功",responseObject[@"data"]);
        }else{
            fail(@"查询失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            fail(@"网络出错");
        }
    }];
}








@end
