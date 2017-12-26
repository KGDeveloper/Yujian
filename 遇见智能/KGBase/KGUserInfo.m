//
//  KGUserInfo.m
//  智能青旅
//
//  Created by KG on 2017/12/15.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGUserInfo.h"

@implementation KGUserInfo

+ (NSString *)userPhone{

    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
}

+ (NSString *)homeNumber{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"homeNumber"];
}

@end
