//
//  KGHomeModel.h
//  遇见智能
//
//  Created by KG on 2018/1/12.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGHomeModel : NSObject

/**
 所属城市
 */
@property (nonatomic,copy) NSString *city;
/**
 客服电话
 */
@property (nonatomic,copy) NSString *customeServicePhoneNo;
/**
 房价
 */
@property (nonatomic,copy) NSString *defaultPrice;
/**
 街道地址
 */
@property (nonatomic,copy) NSString *detailAddress;
/**
 酒店id
 */
@property (nonatomic,copy) NSString *hotelId;
/**
 酒店照片
 */
@property (nonatomic,copy) NSString *hotelPicture;
/**
 所属省份
 */
@property (nonatomic,copy) NSString *province;
/**
 酒店名称
 */
@property (nonatomic,copy) NSString *hotelName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
