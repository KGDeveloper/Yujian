//
//  KGDetaialViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/21.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGDetaialViewController.h"
#import "KGDetaialTableViewCell.h"

@interface KGDetaialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) UITableView *listTableView;

@end

@implementation KGDetaialViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"门店信息";
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, KGscreenWidth * 4 / 5)];
    _headerImage.image = [UIImage imageNamed:@"listImage"];
    
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 64)];
    _listTableView.rowHeight = 140.0f;
    _listTableView.tableHeaderView = _headerImage;
    _listTableView.tableFooterView = [UIView new];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGDetaialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGDetaialTableViewCell" owner:self options:nil] lastObject];
    }
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
