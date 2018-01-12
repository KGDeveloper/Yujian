//
//  KGForgetViewController.m
//  FaceRecognition
//
//  Created by KG on 2017/12/13.
//  Copyright © 2017年 付正. All rights reserved.
//

#import "KGForgetViewController.h"
#import "KGTextField.h"

@interface KGForgetViewController ()<UITextFieldDelegate>

/**
 填写手机号
 */
@property (nonatomic,strong) KGTextField *phoneNumber;
/**
 填写验证码
 */
@property (nonatomic,strong) KGTextField *verify;
/**
 填写密码
 */
@property (nonatomic,strong) KGTextField *passWord;
/**
 确认密码
 */
@property (nonatomic,strong) KGTextField *surePassWord;
/**
 发送验证码
 */
@property (nonatomic,strong) UIButton *verifyBtu;
/**
 倒计时
 */
@property (nonatomic,assign) NSInteger timeNumber;
/**
 定时器
 */
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL tureOrfail;
@property (nonatomic,strong) UIButton *verityShure;



@end

@implementation KGForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor grayColor];
    _timeNumber = 60;
    _tureOrfail = NO;
    
    [self setPhoneNumber];
    [self setVerify];
    [self setVerifyButton];
    [self setVerifyBtuAndSMS];
    [self setPassWord];
    [self setSurePassWord];
    [self setRegisterButton];
}

#pragma mark -创建账号输入框-
- (void)setPhoneNumber{
    
    _phoneNumber = [[KGTextField alloc]initWithFrame:CGRectMake(50, 170, KGscreenWidth - 100, 30)];
    _phoneNumber.backgroundColor = [UIColor whiteColor];
    _phoneNumber.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:[self dictionaryWithFont:13 andColor:KGcolor(192, 193, 198, 1)]];
    _phoneNumber.font = KGFont(13);
    _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumber.delegate = self;
    _phoneNumber.tag = 101;
    _phoneNumber.clearButtonMode = UITextFieldViewModeAlways;
    _phoneNumber.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"账号"]];
    _phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_phoneNumber];
}

#pragma mark -创建验证码输入框-
- (void)setVerify{
    
    _verify = [[KGTextField alloc]initWithFrame:CGRectMake(50, 210,KGscreenWidth/2 - 30, 30)];
    _verify.backgroundColor = [UIColor whiteColor];
    _verify.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"验证码" attributes:[self dictionaryWithFont:13 andColor:KGcolor(192, 193, 198, 1)]];
    _verify.font = KGFont(13);
    _verify.borderStyle = UITextBorderStyleRoundedRect;
    _verify.delegate = self;
    _verify.clearButtonMode = UITextFieldViewModeAlways;
    _verify.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证码"]];
    _verify.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_verify];
}

#pragma mark -发送验证码按钮-
- (void)setVerifyButton{
    _verifyBtu = [[UIButton alloc]initWithFrame:CGRectMake(KGscreenWidth/2 + 30, 210,KGscreenWidth/2 - 80, 30)];
    [_verifyBtu setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_verifyBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _verifyBtu.backgroundColor = [UIColor lightGrayColor];
    _verifyBtu.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _verifyBtu.layer.cornerRadius = 5.0f;
    _verifyBtu.layer.borderColor = [UIColor whiteColor].CGColor;
    _verifyBtu.layer.borderWidth = 1.0f;
    _verifyBtu.layer.masksToBounds = YES;
    [_verifyBtu addTarget:self action:@selector(verifyBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verifyBtu];
}

#pragma mark -注册按钮-
- (void)setVerifyBtuAndSMS{
    _verityShure = [[UIButton alloc]initWithFrame:CGRectMake(50, 250,KGscreenWidth - 100, 30)];
    [_verityShure setTitle:@"验证" forState:UIControlStateNormal];
    [_verityShure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _verityShure.backgroundColor = [UIColor blueColor];
    _verityShure.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _verityShure.layer.cornerRadius = 5.0f;
    _verityShure.layer.borderColor = [UIColor whiteColor].CGColor;
    _verityShure.layer.borderWidth = 1.0f;
    _verityShure.layer.masksToBounds = YES;
    [_verityShure addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verityShure];
}

- (void)buttonClick:(UIButton *)sender{
    [SMSSDK commitVerificationCode:_verify.text phoneNumber:_phoneNumber.text zone:@"86" result:^(NSError *error) {
        if (!error)
        {
            _tureOrfail = YES;
            [self alertViewTitle:@"提示" message:@"验证码填写正确，请继续"];
            [_verityShure setTitle:@"验证成功" forState:UIControlStateNormal];
            _verityShure.backgroundColor = [UIColor lightGrayColor];
            [_verityShure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else
        {
            // error
            [self alertViewTitle:@"提示" message:@"验证码有误"];
        }
    }];
}

#pragma mark -创建密码输入框-
- (void)setPassWord{
    
    _passWord = [[KGTextField alloc]initWithFrame:CGRectMake(50, 290,KGscreenWidth - 100, 30)];
    _passWord.backgroundColor = [UIColor whiteColor];
    _passWord.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"新密码" attributes:[self dictionaryWithFont:13 andColor:KGcolor(192, 193, 198, 1)]];
    _passWord.font = KGFont(13);
    _passWord.borderStyle = UITextBorderStyleRoundedRect;
    _passWord.delegate = self;
    _passWord.secureTextEntry = YES;
    _passWord.rightView = [self setLookButton];
    _passWord.rightViewMode = UITextFieldViewModeAlways;
    _passWord.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码-3"]];
    _passWord.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_passWord];
}

#pragma mark -创建密码确认输入框-
- (void)setSurePassWord{
    
    _surePassWord = [[KGTextField alloc]initWithFrame:CGRectMake(50, 330,KGscreenWidth - 100, 30)];
    _surePassWord.backgroundColor = [UIColor whiteColor];
    _surePassWord.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"确认新密码" attributes:[self dictionaryWithFont:13 andColor:KGcolor(192, 193, 198, 1)]];
    _surePassWord.font = KGFont(13);
    _surePassWord.borderStyle = UITextBorderStyleRoundedRect;
    _surePassWord.delegate = self;
    _surePassWord.secureTextEntry = YES;
    _surePassWord.clearButtonMode = UITextFieldViewModeAlways;
    _surePassWord.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码-3"]];
    _surePassWord.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_surePassWord];
}

#pragma mark -创建点击查看密码按钮-
- (UIButton *)setLookButton{
    UIButton *lookBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    lookBtu.frame = CGRectMake(0, 0, 30, 30);
    [lookBtu setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
    [lookBtu addTarget:self action:@selector(lookBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    return lookBtu;
}

#pragma mark -查看密码按钮点击事件-
- (void)lookBtuClick:(UIButton *)sender{
    if (_passWord.secureTextEntry == NO) {
        _passWord.secureTextEntry = YES;
    }else{
        _passWord.secureTextEntry = NO;
    }
}

#pragma mark -修改按钮-
- (void)setRegisterButton{
    UIButton *registerBtu = [[UIButton alloc]initWithFrame:CGRectMake(50, KGscreenHeight - 200,KGscreenWidth - 100, 30)];
    [registerBtu setTitle:@"提交" forState:UIControlStateNormal];
    [registerBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtu.backgroundColor = [UIColor blueColor];
    registerBtu.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    registerBtu.layer.cornerRadius = 5.0f;
    registerBtu.layer.borderColor = [UIColor whiteColor].CGColor;
    registerBtu.layer.borderWidth = 1.0f;
    registerBtu.layer.masksToBounds = YES;
    [registerBtu addTarget:self action:@selector(registerBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtu];
}

#pragma mark -修改按钮点击事件-
- (void)registerBtuClick:(UIButton *)sender{
    if ([_phoneNumber.text isEqualToString:@""] & [_passWord.text isEqualToString:@""] & [_verify.text isEqualToString:@""] & [_surePassWord.text isEqualToString:@""]) {
        [self alertViewTitle:@"提示" message:@"请认真填写注册信息"];
    }else{
        if ([_passWord.text isEqualToString:_surePassWord.text]) {
            if (_tureOrfail == YES) {
                [[KGRequest sharedInstance] forgetPassWord:_phoneNumber.text passWord:_passWord.text succ:^(NSString *msg, id data) {
                    if ([msg isEqualToString:@"修改成功"]) {
                        [self alertViewTitle:@"提示" message:@"修改成功,请返回登录页面,使用新密码登录"];
//                        // 验证成功
//                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [self alertViewTitle:@"提示" message:@"修改失败"];
                    }
                    
                } fail:^(NSString *error) {
                    [self alertViewTitle:@"提示" message:@"访问服务器失败"];
                }];
            }
        }else{
            [self alertViewTitle:@"提示" message:@"两次输入的密码不一样，请重新输入"];
        }
    }
}

#pragma mark -发送验证码按钮点击事件-
- (void)verifyBtuClick:(UIButton *)sender{
    if (_phoneNumber.text.length == 11) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumber.text zone:@"86" result:^(NSError *error) {
            if (!error)
            {
                // 验证成功
                [self alertViewTitle:@"提示" message:@"验证码已发送请注意接收"];
            }
            else
            {
                // error
            }
        }];
        [self setTimer];
        _verifyBtu.enabled = NO;
    }else{
        [self alertViewTitle:@"提示" message:@"请输入正确的手机号"];
    }
    
}

#pragma mark -开始定时器，按钮开始计时-
- (void)setTimer{
    //定时器(第一中创建方法)
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUser) userInfo:nil repeats:YES];
    
    //把定时器加到运行循环里面()
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark -定时器方法-
- (void)timerUser{
    _timeNumber -- ;
    
    _verifyBtu.backgroundColor = [UIColor lightGrayColor];
    [_verifyBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_verifyBtu setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",(long)_timeNumber] forState:UIControlStateNormal];
    
    if (_timeNumber == 0) {
        //废弃定时器
        [_timer invalidate];
        
        _timer = nil;
        
        _verifyBtu.backgroundColor = [UIColor blueColor];
        [_verifyBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_verifyBtu setTitle:@"发送验证码" forState:UIControlStateNormal];
        
        _verifyBtu.enabled = YES;
        _timeNumber = 60;
    }
}

#pragma mark -UITextFieldDelegate-
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _phoneNumber) {
        if (_phoneNumber.text.length >= 11) {
            return NO;
        }else if (_phoneNumber.text.length == 10){
            _verifyBtu.backgroundColor = [UIColor blueColor];
            [_verifyBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            return YES;
        }else{
            _verifyBtu.backgroundColor = [UIColor lightGrayColor];
            [_verifyBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            return YES;
        }
    }else{
        return YES;
    }
}

#pragma mark -创建公共警告框-
- (void)alertViewTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okBtu = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okBtu];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -收件盘-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumber resignFirstResponder];
    [_passWord resignFirstResponder];
    [_surePassWord resignFirstResponder];
    [_verify resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
