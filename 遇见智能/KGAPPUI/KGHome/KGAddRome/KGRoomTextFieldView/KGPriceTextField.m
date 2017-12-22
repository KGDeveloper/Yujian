//
//  KGPriceTextField.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGPriceTextField.h"

@implementation KGPriceTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 5, 20, 20);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.size.width - 30, 5, 20, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
