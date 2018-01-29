//
//  KGWebsites.h
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#ifndef KGWebsites_h
#define KGWebsites_h

//正式地址
//#define URL_ENTRY @"https://www.aiwisdoms.com:8443/"
#define URL_ENTRY @"https://119.23.211.22:8443/"
//测试地址
//#define URL_ENTRY @"https://192.168.1.19:8080/"
//测试地址
//#define URL_ENTRY @"https://192.168.1.210:8080/"
#define IMG_APPEND_PREFIX(url) [IMG_PREFIX stringByAppendingString:url]

#define KGLogin [URL_ENTRY stringByAppendingString:@"/login"]//登录
#define KGHomeName [URL_ENTRY stringByAppendingString:@"/index"]//首页
#define KGForget [URL_ENTRY stringByAppendingString:@"/update_psw"]//忘记密码
#define KGRegister [URL_ENTRY stringByAppendingString:@"/merchantRegist"]//注册
#define KGUpdatePassWord [URL_ENTRY stringByAppendingString:@"/updateHotelMessage"]//更改密码
#define KGUpdatePhone [URL_ENTRY stringByAppendingString:@"/updatePhoneNumber"]//更改手机号
#define KGAddHotel [URL_ENTRY stringByAppendingString:@"/addHotel"]//添加酒店
#define KGHotelQueryRooms [URL_ENTRY stringByAppendingString:@"/hotelQueryRooms"]//查看酒店所有房间
#define KGAddHotelRoom [URL_ENTRY stringByAppendingString:@"/addHotelRoom"]//添加酒店房间信息
#define KGRoomStare [URL_ENTRY stringByAppendingString:@"/hotelDetail"]//房态
#define KGDeleteHotel [URL_ENTRY stringByAppendingString:@"/deleteHotel"]//删除酒店
#define KGDeleteHotelRoom [URL_ENTRY stringByAppendingString:@"/deleteHotelRoom"]//删除房间
#define KGChangeHotelDetail [URL_ENTRY stringByAppendingString:@"/changeHotelDetail"]//修改酒店信息
#define KGUpdateHotelRoom [URL_ENTRY stringByAppendingString:@"/updateHotelRoom"]//修改酒店房间信息
#define KGAllHotel [URL_ENTRY stringByAppendingString:@"/allHotel"]//查询酒店所有房间名称和id
#define KGHotelAllRoomType [URL_ENTRY stringByAppendingString:@"/hotelAllRoomType"]//查询酒店所有房型
#define KGAddOrder [URL_ENTRY stringByAppendingString:@"/addOrder"]//添加订单
#define KGHotelOperateOrder [URL_ENTRY stringByAppendingString:@"/hotelOperateOrder"]//修改订单状态
#define KGHotelQueryOrder [URL_ENTRY stringByAppendingString:@"/hotelQueryOrder"]//所有订单
#define KGHotelQueryOrderDetail [URL_ENTRY stringByAppendingString:@"/hotelQueryOrderDetail"]//查看订单详情

#endif /* KGWebsites_h */
