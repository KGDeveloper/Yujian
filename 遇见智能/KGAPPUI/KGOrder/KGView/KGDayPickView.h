//
//  KGDayPickView.h
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGDayPickViewDelegate <NSObject>

- (void)giveDayTime:(NSString *)dayTime;

@end

@interface KGDayPickView : UIView

@property (nonatomic,weak) id<KGDayPickViewDelegate>myDelegate;

@end
