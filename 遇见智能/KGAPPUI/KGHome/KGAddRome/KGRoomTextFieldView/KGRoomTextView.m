//
//  KGRoomTextView.m
//  遇见智能
//
//  Created by KG on 2018/1/15.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGRoomTextView.h"

@interface KGRoomTextView ()<UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UITextView *additionalInformation;
@property (nonatomic,strong) UITextField *bedType;
@property (nonatomic,strong) UIPickerView *captaion;
@property (nonatomic,strong) UILabel *plachHodel;
@property (nonatomic,copy) NSString *captaionStr;
@property (nonatomic,strong) UIButton *shureBtu;

@end

@implementation KGRoomTextView

- (instancetype )initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KGcolor(210, 226, 226, 0.5);
        [self initBackView];
        [self setView];
    }
    return self;
}

- (void)initBackView{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth - 100, 400)];
    _backView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 10;
    _backView.layer.masksToBounds = YES;
    [self addSubview:_backView];
    
    UILabel *msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _backView.frame.size.width, 30)];
    msgLabel.text = @"请输入所需信息";
    msgLabel.font = KGFont(13);
    msgLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:msgLabel];
    
    _shureBtu = [[UIButton alloc]initWithFrame:CGRectMake(0, _backView.frame.size.height - 40, _backView.frame.size.width/2, 40)];
    [_shureBtu setTitle:@"确认" forState:UIControlStateNormal];
    _shureBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [_shureBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shureBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_shureBtu];
    
    UIButton *cancelBtu = [[UIButton alloc]initWithFrame:CGRectMake(_backView.frame.size.width/2, _backView.frame.size.height - 40, _backView.frame.size.width/2, 40)];
    [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [cancelBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:cancelBtu];
    
}

- (void)setView{
    _additionalInformation = [[UITextView alloc]initWithFrame:CGRectMake(0, 40, _backView.frame.size.width,310)];
    _additionalInformation.textColor = [UIColor blackColor];
    _additionalInformation.delegate = self;
    _additionalInformation.hidden = NO;
    [_backView addSubview:_additionalInformation];
    
    _plachHodel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _additionalInformation.frame.size.width - 20, 30)];
    _plachHodel.text = @"请输入附加信息";
    _plachHodel.textColor = [UIColor grayColor];
    [_additionalInformation addSubview:_plachHodel];
    
    _bedType = [[UITextField alloc]initWithFrame:CGRectMake(0, 40, _backView.frame.size.width,310)];
    _bedType.textColor = [UIColor blackColor];
    _bedType.placeholder = @"请输入房型：如:1.2m*1.8m";
    _bedType.delegate = self;
    [_backView addSubview:_bedType];
    
    _captaion = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, _backView.frame.size.width,310)];
    _captaion.delegate = self;
    _captaion.dataSource = self;
    [_backView addSubview:_captaion];
}

- (void)buttonClick:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:@"确认"]) {
        if (sender.tag == 300) {
            if (_additionalInformation.text.length > 0) {
                if ([_Mydelegate respondsToSelector:@selector(sendAdditionalInformation:)]) {
                    [_Mydelegate sendAdditionalInformation:_additionalInformation.text];
                }
            }
        }else if (sender.tag == 400){
            if (_bedType.text.length > 0){
                if ([_Mydelegate respondsToSelector:@selector(sendBedType:)]) {
                    [_Mydelegate sendBedType:_bedType.text];
                }
            }
        }else{
            if ([_Mydelegate respondsToSelector:@selector(sendCaptaion:)]) {
                [_Mydelegate sendCaptaion:_captaionStr];
            }
        }
    }
    self.hidden = YES;
}

- (void)showTextViewtype:(NSInteger)type{
    _shureBtu.tag = type;
    _bedType.hidden = YES;
    _captaion.hidden = YES;
    _additionalInformation.hidden = NO;
    _plachHodel.hidden = NO;
}

- (void)showTextFieldtype:(NSInteger)type{
    _shureBtu.tag = type;
    _additionalInformation.hidden = YES;
    _captaion.hidden = YES;
    _plachHodel.hidden = YES;
    _bedType.hidden = NO;
}

- (void)showPickViewtype:(NSInteger)type{
    _shureBtu.tag = type;
    _additionalInformation.hidden = YES;
    _bedType.hidden = YES;
    _plachHodel.hidden = YES;
    _captaion.hidden = NO;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%ld",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _captaionStr = [NSString stringWithFormat:@"%ld",row];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (_plachHodel.hidden == NO) {
        _plachHodel.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_additionalInformation resignFirstResponder];
    [_bedType resignFirstResponder];
}

@end
