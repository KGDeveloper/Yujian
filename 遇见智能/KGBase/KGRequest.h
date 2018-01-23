//
//  KGRequest.h
//  智能青旅
//
//  Created by KG on 2017/12/14.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 修改密码

 @param newPassWord 新密码
 @param userId 用户id
 @param succ 成功返回值
 @param fail 失败返回值
 */
- (void)updateHotelMessageWithnewPassWord:(NSString *)newPassWord userId:(NSString *)userId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 添加酒店信息

 @param dci 酒店信息
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)addHotellMessageWithDictionary:(NSDictionary *)dci succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 首页接口

 @param phoneNo 用户电话
 @param page 页数
 @param pageSize 行数
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)homeUserPhone:(NSString *)phoneNo page:(NSString *)page pageSize:(NSString *)pageSize succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 酒店房间接口

 @param hotelId 酒店id
 @param page 页数
 @param pageSize 行数
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)roomHotellId:(NSString *)hotelId page:(NSString *)page pageSize:(NSString *)pageSize succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 添加房间信息

 @param dic 房间信息
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)addRoomWithDictionary:(NSDictionary *)dic succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 房态

 @param hotelId 酒店id
 @param page 页数
 @param pageSize 行数
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)roomStareHotellId:(NSString *)hotelId page:(NSString *)page pageSize:(NSString *)pageSize succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 删除酒店

 @param hotellId 酒店id
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)deleteHotell:(NSString *)hotellId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 删除房间

 @param roomId 房间id
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)deleteRoom:(NSString *)roomId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 修改酒店信息

 @param dic 酒店信息
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)changeHotelWithDictionary:(NSDictionary *)dic succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 修改房间信息

 @param dic 房间信息
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)changeHotelRoomWithDictionary:(NSMutableDictionary *)dic succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 查询所有酒店接口

 @param userId 商家id
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)allHodel:(NSString *)userId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 查询酒店所有房型

 @param hotelId 酒店id
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)hotelAllRoomType:(NSString *)hotelId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 添加订单接口

 @param parametes 订单信息
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)addOrderWithDictionary:(NSDictionary *)parametes succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 确认订单

 @param hotelCheckStatus 状态
 @param orderId 订单号
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)changeOrderStatushotelCheckStatus:(NSString *)hotelCheckStatus orderId:(NSString *)orderId succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;
/**
 查询所有订单接口

 @param userId 商家id
 @param queryType 订单类型（退房|订房）
 @param succ 成功返回
 @param fail 失败返回
 */
- (void)hotelAllOrder:(NSString *)userId queryType:(NSString *)queryType succ:(KGRequestSucc)succ fail:(KGRequestFail)fail;


@end
