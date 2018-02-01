//
//  KGRoomTypeList.h
//  遇见智能
//
//  Created by KG on 2018/2/1.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGRoomTypeListDelegate <NSObject>

- (void)sendArrayToController:(NSArray *)arr;

@end

@interface KGRoomTypeList : UIView

@property (nonatomic,weak) id<KGRoomTypeListDelegate>myDelegate;

@end
