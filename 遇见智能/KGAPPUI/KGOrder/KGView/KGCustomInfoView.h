//
//  KGCustomInfoView.h
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGCustomInfoViewDelegate <NSObject>

- (void)sendUsername:(NSString *)userName userPhone:(NSString *)userPhone;

@end

@interface KGCustomInfoView : UIView

@property (nonatomic,weak) id<KGCustomInfoViewDelegate>myDelegate;

@end
