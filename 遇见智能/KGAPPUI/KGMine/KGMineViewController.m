//
//  KGMineViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGMineViewController.h"
#import "KGMineTableViewCell.h"
#import "KGPhoneViewController.h"
#import "KGPassWordViewController.h"
#import "KGIdeaViewController.h"
#import "KGCustomerViewController.h"
#import "KGAboutViewController.h"
#import "KGLoginViewController.h"

@interface KGMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mineTableView;
@property (nonatomic,strong) NSMutableArray *headerImageArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NSMutableArray *controllerArr;

@end

@implementation KGMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerImageArr = [NSMutableArray arrayWithObjects:@"手机",@"密码",@"意见",@"客服",@"关于", nil];
    _titleArr = [NSMutableArray arrayWithObjects:@"修改手机号",@"修改密码",@"投诉建议",@"客服电话",@"关于我们", nil];
    
    KGAboutViewController *about = [[KGAboutViewController alloc]init];
    KGPassWordViewController *passWord = [[KGPassWordViewController alloc]init];
    KGCustomerViewController *customer = [[KGCustomerViewController alloc]init];
    KGIdeaViewController *idea = [[KGIdeaViewController alloc]init];
    KGPhoneViewController *phone = [[KGPhoneViewController alloc]init];
    
    _controllerArr = [NSMutableArray arrayWithObjects:phone,passWord,idea,customer,about, nil];
    
    [self setMineUI];
}

#pragma mark -个人中心-
- (void)setMineUI{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, 300)];
    backView.backgroundColor = KGcolor(231, 99, 40, 1);
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    headImage.center = CGPointMake(backView.frame.size.width/2, backView.frame.size.height/2);
    headImage.image = [UIImage imageNamed:@"KG"];
    headImage.layer.cornerRadius = 50.0f;
    headImage.layer.masksToBounds = YES;
    [backView addSubview:headImage];
    
    if (KGDevice_Is_iPhoneX == YES) {
        _mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -44, KGscreenWidth, KGscreenHeight - 40)];
    }else{
        _mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-20, KGscreenWidth, KGscreenHeight - 29)];
    }
    _mineTableView.delegate = self;
    _mineTableView.dataSource = self;
    _mineTableView.tableHeaderView = backView;
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth, _mineTableView.frame.size.height - 550)];
    UIButton *jionOutBtu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KGscreenWidth - 100, 30)];
    jionOutBtu.center = CGPointMake(KGscreenWidth/2, footView.frame.size.height/2);
    [jionOutBtu setTitle:@"退出登录" forState:UIControlStateNormal];
    jionOutBtu.backgroundColor = KGcolor(231, 99, 40, 1);
    [jionOutBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jionOutBtu addTarget:self action:@selector(jionOutClick:) forControlEvents:UIControlEventTouchUpInside];
    jionOutBtu.layer.cornerRadius = 5;
    jionOutBtu.layer.masksToBounds = YES;
    [footView addSubview:jionOutBtu];
    _mineTableView.tableFooterView = footView;
    _mineTableView.scrollEnabled = NO;
    _mineTableView.rowHeight = 50;
    [self.view addSubview:_mineTableView];
}

- (void)jionOutClick:(UIButton *)sender{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    KGLoginViewController *login = [[KGLoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGMineTableViewCell" owner:self options:nil] lastObject];
    }

    cell.headerImage.image = [UIImage imageNamed:_headerImageArr[indexPath.row]];
    cell.titleLabel.text = _titleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:_controllerArr[indexPath.row] animated:YES];
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
