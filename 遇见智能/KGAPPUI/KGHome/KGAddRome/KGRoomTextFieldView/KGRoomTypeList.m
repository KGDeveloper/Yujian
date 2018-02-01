//
//  KGRoomTypeList.m
//  遇见智能
//
//  Created by KG on 2018/2/1.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import "KGRoomTypeList.h"
#import "KGRoomTextField.h"
#import "KGRoomTypeTableViewCell.h"

@interface KGRoomTypeList ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,KGRoomTypeTableViewCellDelegate>

@property (nonatomic,strong) UITableView *roomType;
@property (nonatomic,strong) NSMutableArray *roomArr;
@property (nonatomic,strong) KGRoomTextField *addRoom;

@end

@implementation KGRoomTypeList

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _roomArr = [NSMutableArray array];
        [self initTableView];
    }
    return self;
}

- (void)initTableView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, 110)];
    headerView.backgroundColor = [UIColor whiteColor];
    _addRoom = [[KGRoomTextField alloc]initWithFrame:CGRectMake(0,0, KGscreenWidth - 20, 50)];
    _addRoom.textColor = [UIColor grayColor];
    _addRoom.placeholder = @"请输入房型，然后点击右侧添加按钮添加房型";
    _addRoom.font = [UIFont systemFontOfSize:15.0f];
    _addRoom.clearsOnBeginEditing = YES;
    _addRoom.delegate = self;
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    [close setImage:[UIImage imageNamed:@"添加-3"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    _addRoom.rightView = close;
    _addRoom.rightViewMode = UITextFieldViewModeAlways;
    [headerView addSubview:_addRoom];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, KGscreenWidth - 40, 20)];
    topLabel.text = @"*请在输入框内输入房型，点击右侧添加按钮添加！";
    topLabel.textColor = KGCellDont;
    topLabel.font = KGFont(12);
    [headerView addSubview:topLabel];
    
    UILabel *centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, KGscreenWidth - 40, 20)];
    centerLabel.text = @"*请不要输入除汉字以外的特殊字符!";
    centerLabel.textColor = KGCellDont;
    centerLabel.font = KGFont(12);
    [headerView addSubview:centerLabel];
    
    UILabel *buttomLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, KGscreenWidth - 40, 20)];
    buttomLabel.text = @"*您可以最多创建12个房型！";
    buttomLabel.textColor = KGCellDont;
    buttomLabel.font = KGFont(12);
    [headerView addSubview:buttomLabel];
    
    if (KGDevice_Is_iPhoneX == YES) {
        _roomType = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, KGscreenWidth, KGscreenHeight - 88 - 200)];
    }else{
        _roomType = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 64 - 200)];
    }
    _roomType.delegate = self;
    _roomType.dataSource = self;
    _roomType.tableHeaderView = headerView;
    _roomType.tableFooterView = [UIView new];
    _roomType.rowHeight = 50;
    _roomType.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self addSubview:_roomType];
    
    UIButton *cancelBtu = [[UIButton alloc]initWithFrame:CGRectMake(50,KGscreenHeight - 100,KGscreenWidth - 100, 30)];
    [cancelBtu setTitle:@"确定" forState:UIControlStateNormal];
    cancelBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [cancelBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtu.layer.cornerRadius = 5;
    cancelBtu.layer.masksToBounds = YES;
    [cancelBtu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtu];
}

- (void)buttonClick:(UIButton *)sender{
    
    if (_roomArr.count < 1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.label.text = @"请先添加房型";
        hud.minShowTime = 1;
        [MBProgressHUD hideHUDForView:self animated:YES];
    }else{
        self.hidden = YES;
        if ([_myDelegate respondsToSelector:@selector(sendArrayToController:)]) {
            [_myDelegate sendArrayToController:_roomArr];
        }
    }
}

- (void)closeClick:(UIButton *)sender{
    [_addRoom resignFirstResponder];
    if ([self isChineseStr:_addRoom.text] == YES) {
        if (_roomArr.count > 12) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.label.text = @"您已达输入上限，最多您只能创建12个房型";
            hud.minShowTime = 1;
            [MBProgressHUD hideHUDForView:self animated:YES];
        }else{
            [_roomArr addObject:_addRoom.text];
            [_roomType reloadData];
        }
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.label.text = @"您输入汉字以外的文字，请修改！";
        hud.minShowTime = 1;
        [MBProgressHUD hideHUDForView:self animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _roomArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGRoomTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGRoomTypeTableViewCell" owner:self options:nil] lastObject];
    }
    cell.Mydelegate = self;
    if (_roomArr.count > 0 ) {
        cell.namelabel.text = _roomArr[indexPath.row];
    }
    return cell;
}

- (void)deleteArray:(NSString *)roomName{
    
    [_roomArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:roomName]) {
            *stop = YES;
            if (*stop == YES) {
                [_roomArr removeObject:roomName];
                [_roomType reloadData];
            }
        }
    }];
}


- (BOOL)isChineseStr:(NSString *)str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
