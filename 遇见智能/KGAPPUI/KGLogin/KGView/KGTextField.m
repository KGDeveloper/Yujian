//
//  KGTextField.m
//  FaceRecognition
//
//  Created by KG on 2017/12/13.
//  Copyright © 2017年 付正. All rights reserved.
//

#import "KGTextField.h"

@implementation KGTextField

//指定矩形边距
- (CGRect)borderRectForBounds:(CGRect)bounds{
    return CGRectMake(50, 0, self.frame.size.width - 100, 30);
}
//文本显示的边距
//- (CGRect)textRectForBounds:(CGRect)bounds{
//
//}
//- (CGRect)placeholderRectForBounds:(CGRect)bounds;//预留字显示边距
//- (CGRect)editingRectForBounds:(CGRect)bounds;//编辑中文本的边距
//- (CGRect)clearButtonRectForBounds:(CGRect)bounds;//指定显示清楚按钮的边距
//指定左边附着视图的边距
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 5, 20, 20);
}
//指定右边附着视图的边距
- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return CGRectMake(self.frame.size.width - 40, 5, 20, 20);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //返回一个BOOL值，指定是否循序文本字段开始编辑
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
    //这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
    return NO;
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //当用户使用自动更正功能，把输入的文字修改为推荐的文字时，就会调用这个方法。
    //这对于想要加入撤销选项的应用程序特别有用
    //可以跟踪字段内所做的最后一次修改，也可以对所有编辑做日志记录,用作审计用途。
    //要防止文字被改变可以返回NO
    //这个方法的参数中有一个NSRange对象，指明了被改变文字的位置，建议修改的文本也在其中
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder];//查一下resign这个单词的意思就明白这个方法了
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
