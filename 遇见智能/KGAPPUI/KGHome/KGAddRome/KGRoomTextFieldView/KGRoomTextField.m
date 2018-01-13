//
//  KGRoomTextField.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGRoomTextField.h"

@implementation KGRoomTextField

//指定矩形边距
- (CGRect)borderRectForBounds:(CGRect)bounds{
    return CGRectMake(20, 0, bounds.size.width - 40, bounds.size.height);
}
////文本显示的边距
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rect = CGRectMake(bounds.origin.x + 20, bounds.origin.y, bounds.size.width - 40 , bounds.size.height);
    return rect;
}
////预留字显示边距
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(20, 0, bounds.size.width - 40, bounds.size.height);
}
////编辑中文本的边距
- (CGRect)editingRectForBounds:(CGRect)bounds;
{
    return CGRectMake(20, 0, bounds.size.width - 40, bounds.size.height);
}
////指定显示清楚按钮的边距
//- (CGRect)clearButtonRectForBounds:(CGRect)bounds;
////指定左边附着视图的边距
//- (CGRect)leftViewRectForBounds:(CGRect)bounds;
////指定右边附着视图的边距
- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.size.width - 20, 10, 20, 20);
}
////这是字体显示复写方法
//- (void)drawTextInRect:(CGRect)rect;
////这是预留字显示复写方法
//- (void)drawPlaceholderInRect:(CGRect)rect;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
