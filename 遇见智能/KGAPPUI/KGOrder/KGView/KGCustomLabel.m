//
//  KGCustomLabel.m
//  遇见智能
//
//  Created by KG on 2018/1/18.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGCustomLabel.h"

@implementation KGCustomLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        _wordSize = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _wordSize = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _wordSize)];
}

@end
