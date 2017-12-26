//
//  KGRequest.h
//  智能青旅
//
//  Created by KG on 2017/12/14.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

/**
 成功回调

 @param msg 成功标识
 @param data 得到请求成功的返回值
 */
typedef void (^KGRequestSucc)(NSString* msg, id data);
/**
 失败回调

 @param error 得到请求失败的返回值
 */
typedef void (^KGRequestFail)(NSString *error);

@interface KGRequest : NSObject

/**
 获取单例

 @return 获取该类的方法
 */
+ (KGRequest*) sharedInstance;

/**
 登录请求

 @param phone 用户手机号
 @param passWord 用户密码
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)loginWithPhone:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 忘记密码请求
 
 @param phone 用户手机号
 @param passWord 用户密码
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)forgetPassWord:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 注册请求

 @param userName 用户名
 @param phone 手机号
 @param passWord 密码
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)registerUserName:(NSString *)userName phone:(NSString *)phone passWord:(NSString *)passWord succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 绑定店名

 @param phone 店长手机号
 @param homeName 店名
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)lookingPhone:(NSString *)phone homeName:(NSString *)homeName succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
























@end
