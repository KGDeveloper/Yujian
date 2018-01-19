//
//  KGDayPickView.m
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGDayPickView.h"

@interface KGDayPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIPickerView *mypick;
@property (nonatomic,strong) NSMutableArray *allArr;
@property (nonatomic,copy) NSString *dayTime;

@end

@implementation KGDayPickView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _dayTime = @"1晚";
        [self setData];
        [self initPickView];
    }
    return self;
}

- (void)setData{
    _allArr = [NSMutableArray array];
    for (int i = 1; i < 100; i++) {
        [_allArr addObject:[NSString stringWithFormat:@"%d晚",i]];
    }
    [_mypick reloadAllComponents];
    
}

- (void)initPickView{
    
    UIButton *finishBtu = [[UIButton alloc]initWithFrame:CGRectMake(KGscreenWidth - 80, 5, 50,30)];
    [finishBtu setTitle:@"确定" forState:UIControlStateNormal];
    [finishBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    finishBtu.titleLabel.font = KGFont(13);
    finishBtu.layer.cornerRadius = 5;
    finishBtu.layer.masksToBounds = YES;
    [finishBtu addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:finishBtu];
    
    _mypick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 35, KGscreenWidth, self.frame.size.height - 40)];
    _mypick.delegate = self;
    _mypick.dataSource = self;
    [self addSubview:_mypick];
}

#pragma mark -点击传值-
- (void)finishClick:(UIButton *)sender{
    self.hidden = YES;
    if ([_myDelegate respondsToSelector:@selector(giveDayTime:)]) {
        [_myDelegate giveDayTime:_dayTime];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _allArr.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _allArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _dayTime = _allArr[row];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}

@end
