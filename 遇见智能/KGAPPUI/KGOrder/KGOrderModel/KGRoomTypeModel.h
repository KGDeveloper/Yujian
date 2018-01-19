//
//  KGRoomTypeModel.h
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGRoomTypeModel : NSObject

@property (nonatomic,copy) NSString *roomType;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
