//
//  KGUserInfo.h
//  智能青旅
//
//  Created by KG on 2017/12/15.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGUserInfo : NSObject

/**
 商家电话号码

 @return 返回手机号
 */
+ (NSString *)userPhone;
/**
 商家绑定的房间号

 @return 返回一个青旅房间号
 */
+ (NSString *)homeNumber;

@end
