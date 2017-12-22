//
//  KGHomeViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGHomeViewController.h"
#import "KGHomeListTableViewCell.h"
#import "KGAddHomeViewController.h"
#import "KGDetaialViewController.h"

@interface KGHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation KGHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    [self setUpRightNavButtonItmeTitle:nil icon:@"添加"];
    
    [self.view addSubview:[self setListView]];
}

#pragma mark -导航栏右侧添加按钮-
- (void)rightBarItmeClick:(UIButton *)sender{
    KGAddHomeViewController *home = [[KGAddHomeViewController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}

#pragma mark -创建显示酒店名称的列表-
- (UITableView *)setListView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 49 - 64)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = [UIView new];
    _listView.rowHeight = 400;
    return _listView;
}

#pragma mark -遵守tableView协议-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGHomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGHomeListTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGDetaialViewController *controller = [[KGDetaialViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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
