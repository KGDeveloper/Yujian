//
//  KGorderDetaialModel.h
//  遇见智能
//
//  Created by KG on 2018/1/24.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGorderDetaialModel : NSObject

@property (nonatomic,copy) NSString *bedType;
@property (nonatomic,copy) NSString *breakfast;
@property (nonatomic,copy) NSString *captaion;
@property (nonatomic,copy) NSString *checkInName;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *customBirthDay;
@property (nonatomic,copy) NSString *customHomeAddr;
@property (nonatomic,copy) NSString *customId;
@property (nonatomic,copy) NSString *customIdCard;
@property (nonatomic,copy) NSString *customName;
@property (nonatomic,copy) NSString *customNational;
@property (nonatomic,copy) NSString *customPhoneNo;
@property (nonatomic,copy) NSString *customSex;
@property (nonatomic,copy) NSString *deposit;
@property (nonatomic,copy) NSString *hotelCheckStatus;
@property (nonatomic,copy) NSString *hotelDetailAddress;
@property (nonatomic,copy) NSString *hotelId;
@property (nonatomic,copy) NSString *hotelName;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,copy) NSString *orderPrice;
@property (nonatomic,copy) NSString *orderStatus;
@property (nonatomic,copy) NSString *orderTime;
@property (nonatomic,copy) NSString *refrigerator;
@property (nonatomic,copy) NSString *roomName;
@property (nonatomic,copy) NSString *toilet;
@property (nonatomic,copy) NSString *wifi;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
