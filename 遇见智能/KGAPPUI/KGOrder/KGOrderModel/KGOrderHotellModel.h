//
//  KGOrderHotellModel.h
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGOrderHotellModel : NSObject

@property (nonatomic,copy) NSString *hotelId;
@property (nonatomic,copy) NSString *hotelName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
