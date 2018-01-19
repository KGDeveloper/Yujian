//
//  KGHotel+RoomType.m
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGHotel+RoomType.h"

@interface KGHotel_RoomType()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIPickerView *mypick;
@property (nonatomic,copy) NSString *hotellName;
@property (nonatomic,copy) NSString *hotelId;
@property (nonatomic,strong) NSMutableArray *allArr;
@property (nonatomic,strong) KGRoomTypeModel *roomType;
@property (nonatomic,strong) KGOrderHotellModel *hotelModel;

@end

@implementation KGHotel_RoomType

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _hotelOrRoomType = YES;
        [self initPickView];
    }
    return self;
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
    if (_hotelOrRoomType == YES) {
        if ([_myDelegate respondsToSelector:@selector(sendHotelModelToView:)]) {
            [_myDelegate sendHotelModelToView:_hotelModel];
        }
    }else{
        if ([_myDelegate respondsToSelector:@selector(sendRoomModelToView:)]) {
            [_myDelegate sendRoomModelToView:_roomType];
        }
    }
    self.hidden = YES;
}

- (void)sendArrayToView:(NSMutableArray *)arr{
    _allArr = [NSMutableArray arrayWithArray:arr];
    [_mypick reloadAllComponents];
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
    if (_hotelOrRoomType == YES) {
        _hotelModel = _allArr[row];
    }else{
        _roomType = _allArr[row];
    }
}

@end
