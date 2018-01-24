//
//  KGOrderInfoModel.h
//  遇见智能
//
//  Created by KG on 2018/1/24.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGOrderInfoModel : NSObject

@property (nonatomic,copy) NSString *checkInName;
@property (nonatomic,copy) NSString *customId;
@property (nonatomic,copy) NSString *customName;
@property (nonatomic,copy) NSString *customPhoneNo;
@property (nonatomic,copy) NSString *hotelConfirmStatus;
@property (nonatomic,copy) NSString *hotelName;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *orderStatus;
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,copy) NSString *roomName;
@property (nonatomic,copy) NSString *orderTime;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
