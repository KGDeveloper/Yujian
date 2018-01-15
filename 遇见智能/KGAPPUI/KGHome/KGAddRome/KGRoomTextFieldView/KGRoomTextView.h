//
//  KGRoomTextView.h
//  遇见智能
//
//  Created by KG on 2018/1/15.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGRoomTextViewDelegate <NSObject>

- (void)sendAdditionalInformation:(NSString *)additionalInformation;
- (void)sendBedType:(NSString *)bedType;
- (void)sendCaptaion:(NSString *)captaion;


@end

@interface KGRoomTextView : UIView

@property (nonatomic,weak) id<KGRoomTextViewDelegate>Mydelegate;

- (void)showTextViewtype:(NSInteger)type;
- (void)showTextFieldtype:(NSInteger)type;
- (void)showPickViewtype:(NSInteger)type;

- (instancetype)initWithFrame:(CGRect)frame;

@end
