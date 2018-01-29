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
        if ([self userPhoneIsTrueOrFail:_userPhone.text] == YES) {
            if ([_myDelegate respondsToSelector:@selector(sendUsername:userPhone:)]) {
                [_myDelegate sendUsername:_username.text userPhone:_userPhone.text];
            }
            self.hidden = YES;
        }else{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"请输入正确手机号";
            hud.minShowTime = 2;
        }
        
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入用户信息";
        hud.minShowTime = 2;
    }
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (BOOL)userPhoneIsTrueOrFail:(NSString *)msg{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //   NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:msg] == YES)
        || ([regextestcm evaluateWithObject:msg] == YES)
        || ([regextestct evaluateWithObject:msg] == YES)
        || ([regextestcu evaluateWithObject:msg] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
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
