//
//  KGRoomView.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGRoomView.h"

@interface KGRoomView ()<UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) KGRoomTextField *room;

@end

@implementation KGRoomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setScrollView];
    }
    return self;
}

- (void)sendArrayToCreateTextField:(NSArray *)arr{
    _dataArr = [NSMutableArray arrayWithArray:arr];
    [self createTextField];
}

#pragma mark -创建底层-
- (void)setScrollView{
    _backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_backView];
}

#pragma mark -创建textField-
- (void)createTextField{
    [_backView removeFromSuperview];
    _backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _backView.contentSize = CGSizeMake(self.frame.size.width, 40 * _dataArr.count);
    [self addSubview:_backView];
    if (_dataArr.count > 0) {
        for (int i = 0; i < _dataArr.count; i++) {
            KGRoomTextField *room = [[KGRoomTextField alloc]initWithFrame:CGRectMake(0,40 * i, self.frame.size.width - 50, 30)];
            room.textColor = [UIColor grayColor];
            room.font = [UIFont systemFontOfSize:15.0f];
            room.delegate = self;
            room.text = _dataArr[i];
            UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
            [close setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
            close.tag = i;
            [close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
            room.rightView = close;
            room.tag = 101 + i;
            room.rightViewMode = UITextFieldViewModeAlways;
            room.layer.cornerRadius = 5.0f;
            room.layer.borderWidth = 1.0f;
            room.layer.borderColor = [UIColor grayColor].CGColor;
            room.layer.masksToBounds = YES;
            [_backView addSubview:room];
        }
    }
}

#pragma mark -关闭按钮-
- (void)closeClick:(UIButton *)sender{
    [_dataArr removeObjectAtIndex:sender.tag];
    [sender.superview removeFromSuperview];
    
    if ([_myDelegate respondsToSelector:@selector(deleteTextField:)]) {
        [_myDelegate deleteTextField:_dataArr];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITextField *tmp in _backView.subviews) {
        [tmp resignFirstResponder];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger number = textField.tag - 101;
    [_dataArr removeObjectAtIndex:number];
    [_dataArr addObject:textField.text];
    if ([_myDelegate respondsToSelector:@selector(deleteTextField:)]) {
        [_myDelegate deleteTextField:_dataArr];
    }
}

@end
