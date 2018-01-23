//
//  KGHotel+RoomType.h
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGRoomTypeModel.h"
#import "KGOrderHotellModel.h"

@protocol KGHotel_RoomTypeDelegate <NSObject>

- (void)sendRoomModelToView:(NSString *)hotelName hotelId:(NSString *)hotelId;
- (void)sendHotelModelToView:(NSString *)roomType;

@end

@interface KGHotel_RoomType : UIView

@property (nonatomic,assign) BOOL hotelOrRoomType;
@property (nonatomic,strong) UIPickerView *mypick;
@property (nonatomic,weak) id<KGHotel_RoomTypeDelegate>myDelegate;

- (void)sendArrayToView:(NSMutableArray *)arr;

@end
