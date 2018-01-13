//
//  KGRoomView.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGRoomView.h"
#import "KGAddRoomTableViewCell.h"

@interface KGRoomView ()<UITableViewDelegate,UITableViewDataSource,KGAddRoomTableViewCellDelegate>

@end

@implementation KGRoomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableView];
    }
    return self;
}

- (void)initTableView{
    _roomView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _roomView.delegate = self;
    _roomView.dataSource = self;
    _roomView.rowHeight = 50;
    _roomView.backgroundColor = [UIColor clearColor];
    [self addSubview:_roomView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGAddRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGAddRoomTableViewCell" owner:self options:nil] lastObject];
    }
    cell.Mydelegate = self;
    if (_dataArr.count > 0) {
        cell.roomNumber.text = _dataArr[indexPath.row];
    }
    return cell;
}

- (void)deleteArray:(NSString *)roomName{
    [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:roomName]) {
            *stop = YES;
            if (*stop == YES) {
                [_dataArr removeObject:roomName];
                [_roomView reloadData];
            }
        }
    }];
}

@end
