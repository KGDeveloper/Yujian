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
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES;
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];
    
    //AFSSLPinningModeNone 这个模式表示不做 SSL pinning，只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。若证书是信任机构签发的就会通过，若是自己服务器生成的证书，这里是不会通过的。
    //AFSSLPinningModeCertificate 这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端返回的是否一致。
    //AFSSLPinningModePublicKey 这个模式同样是用证书绑定方式验证，客户端要有服务端的证书拷贝，只是验证时只验证证书里的公钥，不验证证书的有效期等信息。只要公钥是正确的，就能保证通信不会被窃听，因为中间人没有私钥，无法解开通过公钥加密的数据。
    
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

















@end
