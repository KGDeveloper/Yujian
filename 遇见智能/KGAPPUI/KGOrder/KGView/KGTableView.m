//
//  KGTableView.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGTableView.h"
#import "KGOrderDetaialTableViewCell.h"

@interface KGTableView ()<UITableViewDataSource,UITableViewDelegate>

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
    _listView.rowHeight = 140;
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
    return cell;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
