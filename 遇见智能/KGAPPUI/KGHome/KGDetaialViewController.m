//
//  KGDetaialViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/21.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGDetaialViewController.h"
#import "KGDetaialTableViewCell.h"
#import "KGAddRomeViewController.h"

@interface KGDetaialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *listTableView;
@property (nonatomic,strong) UIButton *addHotell;

@end

@implementation KGDetaialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"房间信息";
    
    [self setUpRightNavButtonItmeTitle:@"编辑" icon:nil];

    if (KGDevice_Is_iPhoneX == YES) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, KGscreenWidth, KGscreenHeight - 88)];
    }else{
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KGscreenWidth, KGscreenHeight - 64)];
    }
    _listTableView.rowHeight = 110.0f;
    _listTableView.tableFooterView = [UIView new];
    _listTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    [self initAddHotellBut];
}

#pragma mark -添加酒店-
- (void)initAddHotellBut{
    _addHotell = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    _addHotell.center = CGPointMake(KGscreenWidth - 50, KGscreenHeight - 50);
    [_addHotell setImage:[UIImage imageNamed:@"Addto"] forState:UIControlStateNormal];
    [_addHotell addTarget:self action:@selector(addHotell:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_addHotell atIndex:99];
}

#pragma mark -导航栏右侧添加按钮-
- (void)addHotell:(UIButton *)sender{
    KGAddRomeViewController *addRoom = [[KGAddRomeViewController alloc]init];
    [[self navigationController] pushViewController:addRoom animated:YES];
}

//获取导航控制器
- (UINavigationController*)navigationController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}


- (void)rightBarItmeClick:(UIButton *)sender{
    if (_listTableView.editing == YES) {
        _listTableView.editing = NO;
    }else{
        _listTableView.editing = YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self alertViewControllerTitle:@"提示" message:@"是否删除该房间" name:@"删除" type:0 preferredStyle:1];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
