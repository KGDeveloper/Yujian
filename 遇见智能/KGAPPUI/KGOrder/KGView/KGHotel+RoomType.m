//
//  KGHotel+RoomType.m
//  遇见智能
//
//  Created by KG on 2018/1/19.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGHotel+RoomType.h"

@interface KGHotel_RoomType()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,copy) NSString *hotelName;
@property (nonatomic,copy) NSString *hotelId;
@property (nonatomic,strong) NSMutableArray *allArr;
@property (nonatomic,copy) NSString *roomType;

@end

@implementation KGHotel_RoomType

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _hotelOrRoomType = YES;
        self.backgroundColor = [UIColor whiteColor];
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
    _mypick.hidden = NO;
    [self addSubview:_mypick];
}

#pragma mark -点击传值-
- (void)finishClick:(UIButton *)sender{
    
    if (_hotelOrRoomType == YES) {//判断是否是点击选择酒店进入这个页面
        if ([_myDelegate respondsToSelector:@selector(sendRoomModelToView:hotelId:)]) {
            if (_allArr.count > 0) {//为了防止数据为空的时候程序奔溃，在此添加一个判断，当数据为空的时候不走代理方法，不传值到controller中
                if (_hotelName == nil) {//判断是否选择了列表选择器中的值，如果没有选择，默认返回的是第一个值
                    KGOrderHotellModel * model = _allArr[0];
                    _hotelName = model.hotelName;
                    _hotelId = model.hotelId;
                    [_myDelegate sendRoomModelToView:_hotelName hotelId:_hotelId];
                }else{//判断是否选择了列表选择器中的值，如果选择了，默认返回的是选择的值
                    [_myDelegate sendRoomModelToView:_hotelName hotelId:_hotelId];
                }
            }
        }
    }else{//判断是否是点击选择房型进入这个页面
        if ([_myDelegate respondsToSelector:@selector(sendHotelModelToView:)]) {
            if (_allArr.count > 0) {//为了防止数据为空的时候程序奔溃，在此添加一个判断，当数据为空的时候不走代理方法，不传值到controller中
                if (_roomType == nil) {//判断是否选择了列表选择器中的值，如果没有选择，默认返回的是第一个值
                    KGRoomTypeModel *model = _allArr[0];
                    _roomType = model.roomType;
                    [_myDelegate sendHotelModelToView:_roomType];
                }else{//判断是否选择了列表选择器中的值，如果选择了，默认返回的是选择的值
                    [_myDelegate sendHotelModelToView:_roomType];
                }
            }
        }
    }
    self.hidden = YES;
}

- (void)sendArrayToView:(NSMutableArray *)arr{
    _allArr = [NSMutableArray array];
    _allArr = arr;
    if (arr.count > 0) {//判断从controller中穿过来的数组是否是空的，如果不是空的那么添加到可变数组中，更新pickView
        [_mypick reloadAllComponents];
    }else{//判断从controller中穿过来的数组是否是空的，如果是空的那么不做ui更新，只显示一个提示
        _mypick.hidden = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.label.text = @"暂无数据";
        hud.minShowTime = 2;
        [MBProgressHUD hideHUDForView:self animated:YES];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _allArr.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_hotelOrRoomType == YES) {//判断是否是点击选择酒店名称进入的，如果是，从酒店房间信息model中选择值显示
        KGOrderHotellModel *model = _allArr[row];
        return model.hotelName;
    }else{//判断是否是点击选择酒店名称进入的，如果不是，从房型model中选择值显示
        KGRoomTypeModel *model = _allArr[row];
        return model.roomType;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_hotelOrRoomType == YES) {//判断是否是点击选择酒店名称进入的，如果是，从酒店房间信息model中选择值显示
        KGOrderHotellModel * model = _allArr[row];
        _hotelName = model.hotelName;
        _hotelId = model.hotelId;
    }else{//判断是否是点击选择酒店名称进入的，如果不是，从房型model中选择值显示
        KGRoomTypeModel *model = _allArr[row];
        _roomType = model.roomType;
    }
}

@end
