//
//  KGOrderDetaialViewController.m
//  遇见智能
//
//  Created by KG on 2018/1/16.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGOrderDetaialViewController.h"

@interface KGOrderDetaialViewController (){
    NSInteger navHight;
    KGCustomLabel *toplabel;
    KGCustomLabel *centerLabel;
    KGCustomLabel *bottomLabel;
}

@property (nonatomic,strong) UILabel *orderId;
@property (nonatomic,strong) UILabel *orderStar;

@property (nonatomic,strong) UILabel *hotelName;
@property (nonatomic,strong) UILabel *roomType;
@property (nonatomic,strong) UILabel *roomNo;
@property (nonatomic,strong) UILabel *intoTime;
@property (nonatomic,strong) UILabel *customIntoTime;
@property (nonatomic,strong) UILabel *orderPath;

@property (nonatomic,strong) UILabel *roomPirace;

@end

@implementation KGOrderDetaialViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KGcolor(244, 246, 244, 1);
    [self setUpLeftNavButtonItmeTitle:@"" icon:@"Return"];
    
    if (KGDevice_Is_iPhoneX == YES) {
        navHight = 100;
    }else{
        navHight = 76;
    }
    
    [self setTopLabelUI];
    [self setCenterLabel];
    [self setButotmLabel];
}

- (void)setTopLabelUI{
    
    NSArray *topArr = @[@"订单号",@"订单状态"];
    //topLabel
    for (int i = 0; i < 2; i++) {
        toplabel = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0, navHight + 62 * i, 120, 60)];
        toplabel.text = topArr[i];
        toplabel.textColor = [UIColor blackColor];
        toplabel.backgroundColor = [UIColor whiteColor];
        toplabel.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
        toplabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:toplabel];
    }
    
    UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(20, toplabel.frame.origin.y + toplabel.frame.size.height  + 2, 120, 46)];
    topLab.text = @"预定信息";
    topLab.textColor = [UIColor blackColor];
    topLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:topLab];
    
    _orderId = [[UILabel alloc]initWithFrame:CGRectMake(120,navHight, KGscreenWidth - 120, 60)];
    _orderId.textColor = KGcolor(231, 99, 40, 1);
    _orderId.text = @"20180118175020";
    _orderId.backgroundColor = [UIColor whiteColor];
    _orderId.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_orderId];
    
    _orderStar = [[UILabel alloc]initWithFrame:CGRectMake(120,navHight + 62, KGscreenWidth - 120, 60)];
    _orderStar.text = @"已入住";
    _orderStar.textColor = [UIColor blackColor];
    _orderStar.backgroundColor = [UIColor whiteColor];
    _orderStar.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_orderStar];
}

- (void)setCenterLabel{
    NSArray *centerArr = @[@"酒店名称",@"房型名称",@"房间号",@"入离时间",@"进店时间",@"订单渠道"];
    
    for (int i = 0; i < centerArr.count ; i++) {
        centerLabel = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0, toplabel.frame.origin.y + toplabel.frame.size.height + 50 + 62 * i, 120, 60)];
        centerLabel.text = centerArr[i];
        centerLabel.textColor = [UIColor blackColor];
        centerLabel.backgroundColor = [UIColor whiteColor];
        centerLabel.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
        centerLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:centerLabel];
    }
    
    UILabel *centerLab = [[UILabel alloc]initWithFrame:CGRectMake(20, centerLabel.frame.origin.y + centerLabel.frame.size.height  + 2, 120, 46)];
    centerLab.text = @"财务信息";
    centerLab.textColor = [UIColor blackColor];
    centerLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:centerLab];
    
    _hotelName = [[UILabel alloc]initWithFrame:CGRectMake(120, toplabel.frame.origin.y + toplabel.frame.size.height + 50 , KGscreenWidth - 120, 60)];
    _hotelName.text = @"遇见青年旅社";
    _hotelName.textColor = [UIColor blackColor];
    _hotelName.backgroundColor = [UIColor whiteColor];
    _hotelName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_hotelName];
    
    _roomType = [[UILabel alloc]initWithFrame:CGRectMake(120, _hotelName.frame.origin.y + _hotelName.frame.size.height + 2 , KGscreenWidth - 120, 60)];
    _roomType.text = @"女生六人床位";
    _roomType.textColor = [UIColor blackColor];
    _roomType.backgroundColor = [UIColor whiteColor];
    _roomType.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_roomType];
    
    _roomNo = [[UILabel alloc]initWithFrame:CGRectMake(120, _roomType.frame.origin.y + _roomType.frame.size.height + 2 , KGscreenWidth - 120, 60)];
    _roomNo.text = @"2002房间";
    _roomNo.textColor = [UIColor blackColor];
    _roomNo.backgroundColor = [UIColor whiteColor];
    _roomNo.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_roomNo];
    
    _intoTime = [[UILabel alloc]initWithFrame:CGRectMake(120, _roomNo.frame.origin.y + _roomNo.frame.size.height + 2 , KGscreenWidth - 120, 60)];
    _intoTime.text = @"01-08至01-09,1晚";
    _intoTime.textColor = [UIColor blackColor];
    _intoTime.backgroundColor = [UIColor whiteColor];
    _intoTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_intoTime];
    
    _customIntoTime = [[UILabel alloc]initWithFrame:CGRectMake(120, _intoTime.frame.origin.y + _intoTime.frame.size.height + 2 , KGscreenWidth - 120, 60)];
    _customIntoTime.text = @"2017/01/08/13:35:24";
    _customIntoTime.textColor = [UIColor blackColor];
    _customIntoTime.backgroundColor = [UIColor whiteColor];
    _customIntoTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_customIntoTime];
    
    _orderPath = [[UILabel alloc]initWithFrame:CGRectMake(120, _customIntoTime.frame.origin.y + _customIntoTime.frame.size.height + 2 , KGscreenWidth - 120, 60)];
    _orderPath.text = @"美团网";
    _orderPath.textColor = [UIColor blackColor];
    _orderPath.backgroundColor = [UIColor whiteColor];
    _orderPath.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_orderPath];
    
}

- (void)setButotmLabel{
    bottomLabel = [[KGCustomLabel alloc]initWithFrame:CGRectMake(0, centerLabel.frame.origin.y + centerLabel.frame.size.height + 50, 120, 60)];
    bottomLabel.text = @"房价总额";
    bottomLabel.textColor = [UIColor blackColor];
    bottomLabel.backgroundColor = [UIColor whiteColor];
    bottomLabel.wordSize = UIEdgeInsetsMake(0, 20, 0, 0);
    bottomLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:bottomLabel];
    
    _roomPirace = [[UILabel alloc]initWithFrame:CGRectMake(120, centerLabel.frame.origin.y + centerLabel.frame.size.height + 50,KGscreenWidth - 120, 60)];
    _roomPirace.text = @"¥156.00  预付";
    _roomPirace.textColor = KGcolor(231, 99, 40, 1);
    _roomPirace.backgroundColor = [UIColor whiteColor];
    _roomPirace.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_roomPirace];
    
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
