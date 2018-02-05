//
//  KGRoomTypePickView.h
//  遇见智能
//
//  Created by KG on 2018/2/5.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGRoomTypePickViewDelegate <NSObject>

- (void)sendRoomTypeToController:(NSString *)roomType;

@end

@interface KGRoomTypePickView : UIView

@property (nonatomic,weak) id<KGRoomTypePickViewDelegate>myDelegate;
@property (nonatomic,strong) UIPickerView *pickerView;//自定义pickerview

- (void)sendArr:(NSArray *)arr;

@end
