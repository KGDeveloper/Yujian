//
//  KGCustomInfoView.m
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGCustomInfoView.h"

@interface KGCustomInfoView ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UITextField *username;
@property (nonatomic,strong) UITextField *userPhone;

@end

@implementation KGCustomInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KGcolor(210, 226, 226, 0.5);
    }
    return self;
}

- (void)initWithTextFieldAndButton{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 500)];
    _backView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = YES;
    [self addSubview:_backView];
    
    _username = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, _backView.frame.size.width, 30)];
    _username.placeholder = @"请输入住户姓名";
    _username.textAlignment = NSTextAlignmentLeft;
    
    
}

@end
