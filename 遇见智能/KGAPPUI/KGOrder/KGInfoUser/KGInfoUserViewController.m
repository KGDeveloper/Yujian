//
//  KGInfoUserViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/22.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGInfoUserViewController.h"

@interface KGInfoUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UITableView *listView;

@end

@implementation KGInfoUserViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"住户信息";
    
    [self.view addSubview:[self listView]];
}

- (UIView *)headerView{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, KGscreenWidth * 3 / 4)];
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(KGscreenWidth - 90, 20, 70, 100)];
    headerImage.image = [UIImage imageNamed:@"luxun"];
    [_headerView addSubview:headerImage];
    
    UIImageView *back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenfenzheng"]];
    back.frame = CGRectMake(0, 0, KGscreenWidth, KGscreenWidth * 3 / 4);
    [_headerView insertSubview:back atIndex:0];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 200, 30)];
    nameLabel.text = @"姓        名:鲁迅";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = KGFont(15);
    [_headerView addSubview:nameLabel];
    
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 70, 200, 30)];
    sexLabel.text = @"性        别:男";
    sexLabel.textColor = [UIColor blackColor];
    sexLabel.font = KGFont(15);
    [_headerView addSubview:sexLabel];
    
    UILabel *nationLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 200, 30)];
    nationLabel.text = @"民        族:汉族";
    nationLabel.textColor = [UIColor blackColor];
    nationLabel.font = KGFont(15);
    [_headerView addSubview:nationLabel];
    
    UILabel *birtLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 200, 30)];
    birtLabel.text = @"出生年月:2017年12月20日";
    birtLabel.textColor = [UIColor blackColor];
    birtLabel.font = KGFont(15);
    [_headerView addSubview:birtLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 160, 200, 30)];
    phoneLabel.text = @"联系方式:17188696645";
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = KGFont(15);
    [_headerView addSubview:phoneLabel];
    
    UILabel *IDLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 190, KGscreenWidth - 80, 30)];
    IDLabel.text = @"身份证号:171886966451233211";
    IDLabel.textColor = [UIColor blackColor];
    IDLabel.font = KGFont(15);
    [_headerView addSubview:IDLabel];
    
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 220, KGscreenWidth - 80, 30)];
    starLabel.text = @"入住时间:2017年12月11日入住";
    starLabel.textColor = [UIColor blackColor];
    starLabel.font = KGFont(15);
    [_headerView addSubview:starLabel];
    
    UILabel *adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 250, KGscreenWidth - 80, 30)];
    adressLabel.text = @"入住地址:海淀区碧兴园2208男生房3号床";
    adressLabel.textColor = [UIColor blackColor];
    adressLabel.font = KGFont(15);
    [_headerView addSubview:adressLabel];
    
    return _headerView;
}

- (UITableView *)listView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 64)];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.tableHeaderView = [self headerView];
    _listView.tableFooterView = [UIView new];
    return _listView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"进入";
    cell.textLabel.textColor = KGOrangeColor;
    cell.detailTextLabel.text = @"2017/12/12 14:26:30";
    cell.detailTextLabel.textColor = [UIColor redColor];
    return cell;
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
