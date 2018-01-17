//
//  KGUserInfoModel.h
//  遇见智能
//
//  Created by KG on 2018/1/16.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGUserInfoModel : NSObject

@property (nonatomic,copy) NSString *checkInTime;
@property (nonatomic,copy) NSString *checkOutTime;
@property (nonatomic,copy) NSString *customBirthDay;
@property (nonatomic,copy) NSString *customHomeAddr;
@property (nonatomic,copy) NSString *customId;
@property (nonatomic,copy) NSString *customIdCard;
@property (nonatomic,copy) NSString *customName;
@property (nonatomic,copy) NSString *customNational;
@property (nonatomic,copy) NSString *customPhone;
@property (nonatomic,copy) NSString *customPictureLink;
@property (nonatomic,copy) NSString *customSex;
@property (nonatomic,copy) NSString *orderId;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
