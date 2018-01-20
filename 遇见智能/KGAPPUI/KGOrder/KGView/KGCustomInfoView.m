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
        [self initWithTextFieldAndButton];
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
    
    UILabel *nameStr = [[UILabel alloc]initWithFrame:CGRectMake(20,_backView.frame.size.height/2 - 80, 80, 30)];
    nameStr.text = @"住户姓名:";
    nameStr.textColor = [UIColor grayColor];
    nameStr.font = KGFont(13);
    nameStr.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:nameStr];
    
    _username = [[UITextField alloc]initWithFrame:CGRectMake(100,_backView.frame.size.height/2 - 80, _backView.frame.size.width - 120, 30)];
    _username.placeholder = @"请输入住户姓名";
    _username.font = KGFont(13);
    _username.textColor = [UIColor grayColor];
    _username.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:_username];
    
    UILabel *topline = [[UILabel alloc]initWithFrame:CGRectMake(20,_backView.frame.size.height/2 - 50, _backView.frame.size.width - 40, 1)];
    topline.backgroundColor = [UIColor grayColor];
    [_backView addSubview:topline];
    
    UILabel *phoneStr = [[UILabel alloc]initWithFrame:CGRectMake(20,_backView.frame.size.height/2 - 30, 80, 30)];
    phoneStr.text = @"联系方式:";
    phoneStr.textColor = [UIColor grayColor];
    phoneStr.font = KGFont(13);
    phoneStr.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:phoneStr];
    
    _userPhone = [[UITextField alloc]initWithFrame:CGRectMake(100,_backView.frame.size.height/2 - 30, _backView.frame.size.width - 120, 30)];
    _userPhone.placeholder = @"请输入住户联系方式";
    _userPhone.font = KGFont(13);
    _userPhone.textColor = [UIColor grayColor];
    _userPhone.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:_userPhone];
    
    UILabel *centerline = [[UILabel alloc]initWithFrame:CGRectMake(20,_backView.frame.size.height/2, _backView.frame.size.width - 40, 1)];
    centerline.backgroundColor = [UIColor grayColor];
    [_backView addSubview:centerline];
    
    UIButton *shureBtu = [[UIButton alloc]initWithFrame:CGRectMake(0, _backView.frame.size.height - 30, _backView.frame.size.width/2, 30)];
    [shureBtu setTitle:@"确定" forState:UIControlStateNormal];
    shureBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [shureBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shureBtu addTarget:self action:@selector(shureBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:shureBtu];
    
    UIButton *cancelBtu = [[UIButton alloc]initWithFrame:CGRectMake(_backView.frame.size.width/2, _backView.frame.size.height - 30, _backView.frame.size.width/2, 30)];
    [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [cancelBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtu addTarget:self action:@selector(cancelBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:cancelBtu];
    
}

- (void)shureBtuClick:(UIButton *)sender{
    if (_username.text.length > 0 && _userPhone.text.length > 0) {
        if ([_myDelegate respondsToSelector:@selector(sendUsername:userPhone:)]) {
            [_myDelegate sendUsername:_username.text userPhone:_userPhone.text];
        }
        self.hidden = YES;
    }
}

- (void)cancelBtuClick:(UIButton *)sender{
    self.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_username resignFirstResponder];
    [_userPhone resignFirstResponder];
}

@end
