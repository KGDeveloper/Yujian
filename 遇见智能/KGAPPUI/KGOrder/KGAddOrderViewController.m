//
//  KGAddOrderViewController.m
//  遇见智能
//
//  Created by KG on 2018/1/18.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGAddOrderViewController.h"
#import "KGHotel+RoomType.h"
#import "KGOrderHotellModel.h"
#import "KGRoomTypeModel.h"
#import "KGDayPickView.h"
#import "KGCustomInfoView.h"

@interface KGAddOrderViewController ()<KGHotel_RoomTypeDelegate,KGDayPickViewDelegate>{
    NSInteger navHight;
}

@property (nonatomic,strong) UILabel *hotelName;
@property (nonatomic,strong) UILabel *roomType;
@property (nonatomic,strong) UILabel *intoTime;
@property (nonatomic,strong) UILabel *outTime;
@property (nonatomic,strong) UILabel *waitTime;

@property (nonatomic,strong) UILabel *customName;
@property (nonatomic,strong) UILabel *customPhone;

@property (nonatomic,strong) KGHotel_RoomType *myPickView;
@property (nonatomic,strong) KGDayPickView *dayPickView;
@property (nonatomic,strong) KGCustomInfoView *customInfo;

@property (nonatomic,copy) NSString *hotelIdStr;
@property (nonatomic,copy) NSString *hotelNameStr;
@property (nonatomic,copy) NSString *roomTypeStr;
@property (nonatomic,strong) NSMutableArray *hotelArr;
@property (nonatomic,strong) NSMutableArray *roomArr;

@end

@implementation KGAddOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KGcolor(244, 246, 244, 1);
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];
    
    _hotelArr = [NSMutableArray array];
    _roomArr = [NSMutableArray array];
    
    if (KGDevice_Is_iPhoneX == YES) {
        navHight = 90;
    }else{
        navHight = 66;
    }
    
    [self initHotelLabel];
    [self initRoomTypeLabel];
    [self initTimeLabel];
    [self initUserLabel];
    [self initPickView];
    [self initCustomInfo];
    
}

- (void)setDataArr{
    
}

- (void)initPickView{
    _myPickView = [[KGHotel_RoomType alloc]initWithFrame:CGRectMake(0, KGscreenHeight - 300, KGscreenWidth, 300)];
    _myPickView.myDelegate = self;
    _myPickView.hidden = YES;
    [self.view addSubview:_myPickView];
    
    _dayPickView = [[KGDayPickView alloc]initWithFrame:CGRectMake(0, KGscreenHeight - 300, KGscreenWidth, 300)];
    _dayPickView.hidden = YES;
    _dayPickView.myDelegate = self;
    [self.view addSubview:_dayPickView];
}

- (void)sendHotelModelToView:(KGOrderHotellModel *)model{
    _hotelNameStr = model.hotelName;
}

- (void)sendRoomModelToView:(KGRoomTypeModel *)model{
    _roomTypeStr = model.roomType;
}

- (void)initHotelLabel{
    
    KGCustomLabel *hotelInfo = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight , 100, 50)];
    hotelInfo.text = @"入住信息";
    hotelInfo.textAlignment = NSTextAlignmentLeft;
    hotelInfo.textColor = [UIColor blackColor];
    hotelInfo.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:hotelInfo];
    
    KGCustomLabel *hotelLab = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 50, 100, 60)];
    hotelLab.text = @"选择酒店";
    hotelLab.backgroundColor = [UIColor whiteColor];
    hotelLab.textAlignment = NSTextAlignmentLeft;
    hotelLab.textColor = [UIColor blackColor];
    hotelLab.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:hotelLab];
    
    _hotelName = [[UILabel alloc]initWithFrame:CGRectMake(100,navHight + 50,KGscreenWidth - 100, 60)];
    _hotelName.text = @"天龙大酒店";
    _hotelName.backgroundColor = [UIColor whiteColor];
    _hotelName.textAlignment = NSTextAlignmentLeft;
    _hotelName.textColor = KGcolor(231, 99, 40, 1);
    [self.view addSubview:_hotelName];
    
    UIButton *hotelClick = [[UIButton alloc]initWithFrame:CGRectMake(0, navHight + 50, KGscreenWidth, 60)];
    [hotelClick setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [hotelClick setImageEdgeInsets:UIEdgeInsetsMake(20, hotelClick.frame.size.width - 40, 20, 20)];
    [hotelClick addTarget:self action:@selector(hotelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hotelClick];
    
}

- (void)hotelClick:(UIButton *)sender{
    _myPickView.hidden = NO;
}

- (void)initRoomTypeLabel{
    
    KGCustomLabel *roomLab = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight +112, 100, 60)];
    roomLab.text = @"选择房型";
    roomLab.backgroundColor = [UIColor whiteColor];
    roomLab.textAlignment = NSTextAlignmentLeft;
    roomLab.textColor = [UIColor blackColor];
    roomLab.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:roomLab];
    
    _roomType = [[UILabel alloc]initWithFrame:CGRectMake(100,navHight +112,KGscreenWidth - 100, 60)];
    _roomType.text = @"大床房";
    _roomType.backgroundColor = [UIColor whiteColor];
    _roomType.textAlignment = NSTextAlignmentLeft;
    _roomType.textColor = KGcolor(231, 99, 40, 1);
    [self.view addSubview:_roomType];
    
    UIButton *roomClick = [[UIButton alloc]initWithFrame:CGRectMake(0, navHight +112, KGscreenWidth, 60)];
    [roomClick setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [roomClick setImageEdgeInsets:UIEdgeInsetsMake(20, roomClick.frame.size.width - 40, 20, 20)];
    [roomClick addTarget:self action:@selector(roomClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:roomClick];
    
}

- (void)roomClick:(UIButton *)sender{
    _myPickView.hidden = NO;
}

- (void)initTimeLabel{
    
    KGCustomLabel *timeLabl = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight  + 172, 100, 50)];
    timeLabl.text = @"入离时间";
    timeLabl.textAlignment = NSTextAlignmentLeft;
    timeLabl.textColor = [UIColor blackColor];
    timeLabl.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:timeLabl];
    
    KGCustomLabel *joinTime = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 222, 100, 60)];
    joinTime.text = @"入住时间";
    joinTime.backgroundColor = [UIColor whiteColor];
    joinTime.textAlignment = NSTextAlignmentLeft;
    joinTime.textColor = [UIColor blackColor];
    joinTime.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:joinTime];
    
    _intoTime = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 222, KGscreenWidth - 100, 60)];
    _intoTime.backgroundColor = [UIColor whiteColor];
    _intoTime.textColor = [UIColor blackColor];
    _intoTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_intoTime];
    
    UIButton *intoTimeBut = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 222, KGscreenWidth - 100, 60)];
    [intoTimeBut setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [intoTimeBut setImageEdgeInsets:UIEdgeInsetsMake(20, intoTimeBut.frame.size.width - 40, 20, 20)];
    [intoTimeBut addTarget:self action:@selector(intoTimeBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:intoTimeBut];
    
    KGCustomLabel *joinOut = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 284, 100, 60)];
    joinOut.text = @"退房时间";
    joinOut.backgroundColor = [UIColor whiteColor];
    joinOut.textAlignment = NSTextAlignmentLeft;
    joinOut.textColor = [UIColor blackColor];
    joinOut.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:joinOut];
    
    _outTime = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 284, KGscreenWidth - 100, 60)];
    _outTime.backgroundColor = [UIColor whiteColor];
    _outTime.textColor = [UIColor blackColor];
    _outTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_outTime];
    
    UIButton *outTimeBtu = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 284, KGscreenWidth - 100, 60)];
    [outTimeBtu setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [outTimeBtu setImageEdgeInsets:UIEdgeInsetsMake(20, outTimeBtu.frame.size.width - 40, 20, 20)];
    [outTimeBtu addTarget:self action:@selector(outTimeBtu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outTimeBtu];
    
    KGCustomLabel *waitDay = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 346, 100, 60)];
    waitDay.text = @"住房时间";
    waitDay.backgroundColor = [UIColor whiteColor];
    waitDay.textAlignment = NSTextAlignmentLeft;
    waitDay.textColor = [UIColor blackColor];
    waitDay.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:waitDay];
    
    _waitTime = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 346, KGscreenWidth - 100, 60)];
    _waitTime.backgroundColor = [UIColor whiteColor];
    _waitTime.textColor = [UIColor blackColor];
    _waitTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_waitTime];
    
    UIButton *waitBtu = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 346, KGscreenWidth - 100, 60)];
    [waitBtu setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [waitBtu setImageEdgeInsets:UIEdgeInsetsMake(20, waitBtu.frame.size.width - 40, 20, 20)];
    [waitBtu addTarget:self action:@selector(waitBtu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:waitBtu];
    
}

- (void)intoTimeBut:(UIButton *)sender{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    [MOFSPickerManager shareManger].datePicker.toolBar.cancelBarTintColor = [UIColor redColor];
    [MOFSPickerManager shareManger].datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
        _intoTime.text = [df stringFromDate:date];
    } cancelBlock:^{
        
    }];
}

- (void)outTimeBtu:(UIButton *)sender{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    [MOFSPickerManager shareManger].datePicker.toolBar.cancelBarTintColor = [UIColor redColor];
    [MOFSPickerManager shareManger].datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
        _outTime.text = [df stringFromDate:date];
    } cancelBlock:^{
        
    }];
}

- (void)waitBtu:(UIButton *)sender{
    _dayPickView.hidden = NO;
}

- (void)giveDayTime:(NSString *)dayTime{
    _waitTime.text = dayTime;
}

- (void)initUserLabel{
    
    KGCustomLabel *userInfo = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight  + 406, 100, 50)];
    userInfo.text = @"住户信息";
    userInfo.textAlignment = NSTextAlignmentLeft;
    userInfo.textColor = [UIColor blackColor];
    userInfo.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:userInfo];
    
    KGCustomLabel *userName = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 456, 100, 60)];
    userName.text = @"住户姓名";
    userName.backgroundColor = [UIColor whiteColor];
    userName.textAlignment = NSTextAlignmentLeft;
    userName.textColor = [UIColor blackColor];
    userName.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:userName];
    
    _customName = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 456, KGscreenWidth - 100, 60)];
    _customName.backgroundColor = [UIColor whiteColor];
    _customName.textColor = [UIColor blackColor];
    _customName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_customName];
    
    UIButton *customNameBtu = [[UIButton alloc]initWithFrame:CGRectMake(100, navHight + 456, KGscreenWidth - 100, 60)];
    [customNameBtu setImage:KGImage(@"下一个") forState:UIControlStateNormal];
    [customNameBtu setImageEdgeInsets:UIEdgeInsetsMake(20, customNameBtu.frame.size.width - 40, 20, 20)];
    [customNameBtu addTarget:self action:@selector(customNameBtu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customNameBtu];
    
    KGCustomLabel *userPhone = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0,navHight + 518, 100, 60)];
    userPhone.text = @"联系方式";
    userPhone.backgroundColor = [UIColor whiteColor];
    userPhone.textAlignment = NSTextAlignmentLeft;
    userPhone.textColor = [UIColor blackColor];
    userPhone.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:userPhone];
    
    _customPhone = [[UILabel alloc]initWithFrame:CGRectMake(100, navHight + 518, KGscreenWidth - 100, 60)];
    _customPhone.backgroundColor = [UIColor whiteColor];
    _customPhone.textColor = [UIColor blackColor];
    _customPhone.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_customPhone];
    
}

- (void)initCustomInfo{
    _customInfo = [[KGCustomInfoView alloc]initWithFrame:self.view.frame];
    _customInfo.hidden = YES;
    [self.view addSubview:_customInfo];
}

- (void)customNameBtu:(UIButton *)sender{
    _customInfo.hidden = NO;
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
