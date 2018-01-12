//
//  KGWebsites.h
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#ifndef KGWebsites_h
#define KGWebsites_h


#define URL_ENTRY @"http://192.168.1.19:8080"
#define IMG_APPEND_PREFIX(url) [IMG_PREFIX stringByAppendingString:url]

#define KGLogin [URL_ENTRY stringByAppendingString:@"/login"]//登录
#define KGHomeName [URL_ENTRY stringByAppendingString:@"/index"]//首页
#define KGForget [URL_ENTRY stringByAppendingString:@"/update_psw"]//忘记密码
#define KGRegister [URL_ENTRY stringByAppendingString:@"/merchantRegist"]//注册
#define KGUpdatePassWord [URL_ENTRY stringByAppendingString:@"/updateHotelMessage"]//更改密码
#define KGUpdatePhone [URL_ENTRY stringByAppendingString:@"/updatePhoneNumber"]//更改手机号
#define KGAddHotel [URL_ENTRY stringByAppendingString:@"/addHotel"]//添加酒店

#endif /* KGWebsites_h */
