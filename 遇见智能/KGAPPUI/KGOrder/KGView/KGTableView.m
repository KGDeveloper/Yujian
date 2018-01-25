//
//  KGTableView.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGTableView.h"
#import "KGOrderDetaialTableViewCell.h"
#import "KGOrderInfoModel.h"

@interface KGTableView ()<UITableViewDataSource,UITableViewDelegate,KGOrderDetaialTableViewCellDelegate>

@end

@implementation KGTableView

- (instancetype )initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self setListView]];
    }
    return self;
}

#pragma mark -创建显示酒店名称的列表-
- (UITableView *)setListView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = [UIView new];
    _listView.rowHeight = 160;
    _listView.backgroundColor = KGcolor(244, 246, 244, 1);
    
    return _listView;
}

#pragma mark -遵守tableView协议-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGOrderDetaialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGOrderDetaialTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (_titleArr.count > 0) {
        KGOrderInfoModel *model = _titleArr[indexPath.row];
        cell.roomType.text = model.hotelName;
        cell.timeLabel.text = model.roomName;
        cell.priceLabel.text = [NSString stringWithFormat:@"下单时间:%@",model.orderTime];;
        cell.nameLabel.text = [NSString stringWithFormat:@"联系人:%@(%@)",model.customName,model.customPhoneNo];
        cell.orderLabel.text = model.orderNo;
        cell.orderId = model.orderId;
        if ([model.hotelConfirmStatus isEqualToString:@"0"]) {
            
        }else if ([model.hotelConfirmStatus isEqualToString:@"1"]){
            [cell.shureBtu setTitle:@"已同意" forState:UIControlStateNormal];
            cell.shureBtu.backgroundColor = [UIColor grayColor];
            cell.shureBtu.enabled = NO;
            cell.cancelBtu.backgroundColor = [UIColor grayColor];
            cell.cancelBtu.enabled = NO;
        }else{
            [cell.cancelBtu setTitle:@"已拒绝" forState:UIControlStateNormal];
            cell.shureBtu.backgroundColor = [UIColor grayColor];
            cell.shureBtu.enabled = NO;
            cell.cancelBtu.backgroundColor = [UIColor grayColor];
            cell.cancelBtu.enabled = NO;
        }
    }
    cell.Mydelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGOrderInfoModel *model = _titleArr[indexPath.row];
    if ([_Mydelegate respondsToSelector:@selector(pushToDetaialController:)]) {
        [_Mydelegate pushToDetaialController:model.orderId];
    }
}

- (void)sendOrderIdToViewController:(NSString *)orderId type:(NSString *)type{
    NSString *orderType = @"";
    if ([type isEqualToString:@"refuse"]) {
        //拒绝
        orderType = @"拒绝";
    }else{
        //同意
        orderType = @"同意";
    }
    [[KGRequest sharedInstance] changeOrderStatushotelCheckStatus:orderType orderId:orderId succ:^(NSString *msg, id data) {
        [_titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KGOrderInfoModel *model = obj;
            if ([model.orderId isEqualToString:orderId]) {
                *stop = YES;
                if (*stop == YES) {
                    [_titleArr removeObject:model];
                    [_listView reloadData];
                }
            }
        }];
    } fail:^(NSString *error) {
        
    }];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
