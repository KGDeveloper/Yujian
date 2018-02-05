//
//  KGRoomTypePickView.m
//  遇见智能
//
//  Created by KG on 2018/2/5.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGRoomTypePickView.h"

@interface KGRoomTypePickView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,copy) NSString *roomType;
@property (nonatomic,strong) NSMutableArray *arr;

@end

@implementation KGRoomTypePickView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPickView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)sendArr:(NSArray *)arr{
    _arr = [NSMutableArray arrayWithArray:arr];
    [_pickerView reloadAllComponents];
}

#pragma mark -设置房型pickview-
- (void)initPickView{
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,30, self.bounds.size.width, 170)];
    [self insertSubview:_pickerView atIndex:99];
    
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 70, 10, 50, 30)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = KGcolor(231, 99, 40, 1);
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self addSubview:button];
}

- (void)clickButton:(UIButton *)sender{
    if ([_myDelegate respondsToSelector:@selector(sendRoomTypeToController:)]) {
        if (_roomType == nil) {
            [_myDelegate sendRoomTypeToController:_arr[0]];
        }else{
            [_myDelegate sendRoomTypeToController:_roomType];
        }
    }
    self.hidden = YES;
}

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _arr.count;
}

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _arr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _roomType = _arr[row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
