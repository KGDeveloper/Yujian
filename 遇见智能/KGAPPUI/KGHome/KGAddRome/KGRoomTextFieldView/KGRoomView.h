//
//  KGRoomView.h
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGRoomViewDelegate <NSObject>
@required

- (void)deleteTextField:(NSArray *)arr;

@end

@interface KGRoomView : UIView

- (void)sendArrayToCreateTextField:(NSArray *)arr;

@property (nonatomic, strong) id<KGRoomViewDelegate> myDelegate;
@property (nonatomic,strong) UIScrollView *backView;

@end
