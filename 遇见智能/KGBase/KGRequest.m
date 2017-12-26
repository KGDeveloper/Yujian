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

#pragma mark -登录请求-
- (void)loginWithPhone:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"tel"];
    [dic setObject:passWord forKey:@"password"];
    [KGManager POST:KGLogin parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"data"] isEqualToString:@"登录成功"]) {
            succ(@"登录成功",responseObject);
        }else{
            fail(@"账号或密码错误");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail)
        {
            fail(@"登录服务器失败");
        }
    }];
}

#pragma mark -绑定店名-
- (void)lookingPhone:(NSString *)phone homeName:(NSString *)homeName succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"tel"];
    [dic setObject:homeName forKey:@"hotelName"];
    [KGManager POST:KGHomeName parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"data"] isEqualToString:@"验证成功"]) {
            succ(@"验证成功",responseObject);
        }else{
            fail(@"该店不存在，请重新输入！");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail)
        {
            fail(@"登录服务器失败");
        }
    }];
}

#pragma mark -忘记密码请求-
- (void)forgetPassWord:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"tel"];
    [dic setObject:passWord forKey:@"newPsw"];
    KGManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [KGManager POST:KGForget parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"data"] isEqualToString:@"修改成功"]) {
            succ(@"修改成功",responseObject);
        }else{
            fail(@"修改失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail)
        {
            fail(@"登录服务器失败");
        }
    }];
}

#pragma mark -注册请求-
- (void)registerUserName:(NSString *)userName phone:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userName forKey:@""];
    [dic setObject:phone forKey:@""];
    [dic setObject:passWord forKey:@""];
    [KGManager POST:KGRegister parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail)
        {
            fail(@"登录服务器失败");
        }
    }];
}

@end
