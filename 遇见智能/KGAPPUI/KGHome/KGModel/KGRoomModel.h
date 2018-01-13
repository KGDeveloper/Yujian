//
//  KGRoomModel.h
//  遇见智能
//
//  Created by KG on 2018/1/12.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGRoomModel : NSObject

/**
 附加信息
 */
@property (nonatomic,copy) NSString *additionalInformation;
/**
 床型
 */
@property (nonatomic,copy) NSString *bedType;
/**
 是否有早餐
 */
@property (nonatomic,copy) NSString *breakfast;
/**
 可住几人
 */
@property (nonatomic,copy) NSString *captaion;
/**
 上传房间照片数
 */
@property (nonatomic,copy) NSString *count;
/**
 默认房价
 */
@property (nonatomic,copy) NSString *defaultPrice;
/**
 房间押金
 */
@property (nonatomic,copy) NSString *deposit;
/**
 前台手机号
 */
@property (nonatomic,copy) NSString *frontPhoneNo;
/**
 小时房价
 */
@property (nonatomic,copy) NSString *hourPrice;
/**
 是否有冰箱
 */
@property (nonatomic,copy) NSString *refrigerator;
/**
 酒店房间详细地址
 */
@property (nonatomic,copy) NSString *roomDetailAddress;
/**
 房间id
 */
@property (nonatomic,copy) NSString *roomId;
/**
 房间名称
 */
@property (nonatomic,copy) NSString *roomName;
/**
 房间号
 */
@property (nonatomic,copy) NSString *roomNo;
/**
 房间图片
 */
@property (nonatomic,copy) NSString *roomPictureAddr;
/**
 独立卫浴
 */
@property (nonatomic,copy) NSString *toilet;
/**
 周末房价
 */
@property (nonatomic,copy) NSString *weekdaysPrice;
/**
 是否有wifi
 */
@property (nonatomic,copy) NSString *wifi;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
