//
//  KGResigetViewController.m
//  FaceRecognition
//
//  Created by KG on 2017/12/13.
//  Copyright © 2017年 付正. All rights reserved.
//

#import "KGResigetViewController.h"
#import "KGTextField.h"

@interface KGResigetViewController ()<UITextFieldDelegate>

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
 用户名
 */
@property (nonatomic,strong) KGTextField *userName;
/**
 发送验证码
 */
@property (nonatomic,strong) UIButton *verifyBtu;
/**
 发送验证码按钮上的倒计时显示时间
 */
@property (nonatomic,assign) NSInteger timeNumber;
/**
 定时器，用来控制验证码发送按钮的开关以及提示信息
 */
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation KGResigetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"注册账号";
    self.view.backgroundColor = [UIColor grayColor];
    _timeNumber = 60;
    /*
     *加载用户名输入框
     */
    [self setUserName];
    /*
     *加载手机号输入框
     */
    [self setPhoneNumber];
    /*
     *加载验证码输入框
     */
    [self setVerify];
    /*
     *加载验证码发送按钮
     */
    [self setVerifyButton];
    /*
     *加载密码输入框
     */
    [self setPassWord];
    /*
     *加载确认密码输入框
     */
    [self setSurePassWord];
    /*
     *加载注册按钮
     */
    [self setRegisterButton];

}

#pragma mark -创建用户名输入框-
- (void)setUserName{
    _userName = [[KGTextField alloc]initWithFrame:CGRectMake(50, 200, KGscreenWidth - 100, 50)];
    _userName.backgroundColor = [UIColor whiteColor];
    _userName.placeholder = @"请输入用户名";
    _userName.borderStyle = UITextBorderStyleRoundedRect;
    _userName.keyboardType = UIKeyboardTypeDefault;
    _userName.delegate = self;
    _userName.clearButtonMode = UITextFieldViewModeAlways;
    _userName.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"账号"]];
    _userName.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_userName];
}

#pragma mark -创建账号输入框-
- (void)setPhoneNumber{
    
    _phoneNumber = [[KGTextField alloc]initWithFrame:CGRectMake(50, 270, KGscreenWidth - 100, 50)];
    _phoneNumber.backgroundColor = [UIColor whiteColor];
    _phoneNumber.placeholder = @"请输入手机号";
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
    
    _verify = [[KGTextField alloc]initWithFrame:CGRectMake(50, 340,KGscreenWidth/2, 50)];
    _verify.backgroundColor = [UIColor whiteColor];
    _verify.placeholder = @"请输入验证码";
    _verify.borderStyle = UITextBorderStyleRoundedRect;
    _verify.delegate = self;
    _verify.clearButtonMode = UITextFieldViewModeAlways;
    _verify.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证码"]];
    _verify.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_verify];
}

#pragma mark -发送验证码按钮-
- (void)setVerifyButton{
    _verifyBtu = [[UIButton alloc]initWithFrame:CGRectMake(KGscreenWidth/2 + 80, 340,KGscreenWidth/2 - 130, 50)];
    [_verifyBtu setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_verifyBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _verifyBtu.backgroundColor = [UIColor lightGrayColor];
    _verifyBtu.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _verifyBtu.layer.cornerRadius = 10.0f;
    _verifyBtu.layer.borderColor = [UIColor whiteColor].CGColor;
    _verifyBtu.layer.borderWidth = 1.0f;
    _verifyBtu.layer.masksToBounds = YES;
    _verifyBtu.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [_verifyBtu addTarget:self action:@selector(verifyBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verifyBtu];
}

#pragma mark -创建密码输入框-
- (void)setPassWord{
    
    _passWord = [[KGTextField alloc]initWithFrame:CGRectMake(50, 410,KGscreenWidth - 100, 50)];
    _passWord.backgroundColor = [UIColor whiteColor];
    _passWord.placeholder = @"请输入密码";
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
    
    _surePassWord = [[KGTextField alloc]initWithFrame:CGRectMake(50, 480,KGscreenWidth - 100, 50)];
    _surePassWord.backgroundColor = [UIColor whiteColor];
    _surePassWord.placeholder = @"请确认密码";
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
    /*
     *用来控制密码是否显示为文字还是密文
     */
    UIButton *lookBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    lookBtu.frame = CGRectMake(0, 0, 30, 30);
    [lookBtu setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
    [lookBtu addTarget:self action:@selector(lookBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    return lookBtu;
}

#pragma mark -查看密码按钮点击事件-
- (void)lookBtuClick:(UIButton *)sender{
    /*
     *用来控制密码是否显示
     */
    if (_passWord.secureTextEntry == NO) {
        _passWord.secureTextEntry = YES;
    }else{
        _passWord.secureTextEntry = NO;
    }
}

#pragma mark -注册按钮-
- (void)setRegisterButton{
    UIButton *registerBtu = [[UIButton alloc]initWithFrame:CGRectMake(50, KGscreenHeight - 200,KGscreenWidth - 100, 50)];
    [registerBtu setTitle:@"提交" forState:UIControlStateNormal];
    [registerBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtu.backgroundColor = [UIColor blueColor];
    registerBtu.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    registerBtu.layer.cornerRadius = 10.0f;
    registerBtu.layer.borderColor = [UIColor whiteColor].CGColor;
    registerBtu.layer.borderWidth = 1.0f;
    registerBtu.layer.masksToBounds = YES;
    registerBtu.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [registerBtu addTarget:self action:@selector(registerBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtu];
}

#pragma mark -注册按钮点击事件-
- (void)registerBtuClick:(UIButton *)sender{
    /*
     *在此判断用户是否按照订单填写
     *如果没有按信息填写，给出一个提示框
     *如果填写完整，开始进行手机号验证
     *验证是否是本人手机号
     */
    if ([_phoneNumber.text isEqualToString:@"请输入用户名"] & [_passWord.text isEqualToString:@"请输入密码"] & [_verify.text isEqualToString:@"请输入验证码"] & [_surePassWord.text isEqualToString:@"请确认密码"]) {
        [self alertViewTitle:@"提示" message:@"请认真填写注册信息"];
    }else{
        if ([_passWord.text isEqualToString:_surePassWord.text]) {
            [SMSSDK commitVerificationCode:_verify.text phoneNumber:_phoneNumber.text zone:@"86" result:^(NSError *error) {
                if (!error)
                {
                    /*
                     * 验证成功
                     *在这里处理一些事情
                     *跳转页面，验证成功
                     */
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    // error
                    [self alertViewTitle:@"提示" message:@"验证码有误"];
                }
            }];
        }else{
            [self alertViewTitle:@"提示" message:@"两次输入的密码不一样，请重新输入"];
        }
    }
}

#pragma mark -发送验证码按钮点击事件-
- (void)verifyBtuClick:(UIButton *)sender{
    /*
     *在这里发送验证码
     *首先需要判断手机号是否正确，没有进行进一步的确认，只是判断是否是11位，满足11位就开始请求发送验证码
     *如果需要特别精细，在此处需要添加判断手机号开头的代码
     *如果判断成功开始请求发送验证码
     *有一个回调可以用来判断验证码是否发送成功
     */
    if (_phoneNumber.text.length == 11) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumber.text zone:@"86" result:^(NSError *error) {
            if (!error)
            {
                // 验证成功
                [self alertViewTitle:@"提示" message:@"验证码已发送请注意接收"];
            }
            else
            {
                [self alertViewTitle:@"提示" message:@"验证码发送失败，请查看手机号"];
            }
        }];
        /*
         *点击发送短信验证码后开启定时器
         *发送短信按钮关闭交互，开始倒计时60秒
         */
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
    /*
     *点击发送短信验证码后开启定时器
     *发送短信按钮关闭交互，开始倒计时60秒
     *发送短信验证码按钮上开始显示倒计时
     */
    _verifyBtu.backgroundColor = [UIColor lightGrayColor];
    [_verifyBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_verifyBtu setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",(long)_timeNumber] forState:UIControlStateNormal];
    /*
     *倒计时为0的时候，废弃定时器
     *打开发送验证码按钮的交互
     *倒计时重置为60秒
     */
    if (_timeNumber == 0) {
        //废弃定时器
        [_timer invalidate];
        
        _timer = nil;
        _verifyBtu.enabled = YES;
        _timeNumber = 60;
    }
}

#pragma mark -UITextFieldDelegate-
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    /*
     *在此用来判断以及限制用户输入，当长度达到11位数，也就是正确手机号，此输入框禁止输入
     *当用户输入正确手机号的时候发送短信验证码按钮变亮，打开交互，即提醒用户可以点击
     */
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
    [_userName resignFirstResponder];
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
