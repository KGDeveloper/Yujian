//
//  KGOrderViewController.m
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGOrderViewController.h"
#import "KGOrderListViewController.h"
#import "KGWaitViewController.h"

@interface KGOrderViewController (){
    NSMutableDictionary *listDic;
}

@property (nonatomic,strong) UISegmentedControl *finishOrWait;
/**
 订房系统
 */
@property (nonatomic,strong) KGOrderListViewController *finishVC;
/**
 退房系统
 */
@property (nonatomic,strong) KGWaitViewController *waitVC;

@end

@implementation KGOrderViewController

#pragma mark --

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    
    self.navigationItem.titleView = [self setFinishOrWait];
    [self.view addSubview:self.finishVC.view];
}

- (KGOrderListViewController *)finishVC{
    if (_finishVC == nil) {
        _finishVC = [[KGOrderListViewController alloc]init];
    }
    return _finishVC;
}

- (KGWaitViewController *)waitVC{
    if (_waitVC == nil) {
        _waitVC = [[KGWaitViewController alloc]init];
    }
    return _waitVC;
}

#pragma mark -导航栏订房退房标签-
- (UISegmentedControl *)setFinishOrWait{
    NSArray *titleArr = @[@"订房",@"退房"];
    _finishOrWait = [[UISegmentedControl alloc]initWithItems:titleArr];
    _finishOrWait.selectedSegmentIndex = 0;
    _finishOrWait.tintColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _finishOrWait.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KGcolor(231, 99, 40, 1),
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:17],
                         NSFontAttributeName,nil];
    
    [_finishOrWait setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:KGCellDont,
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:17],
                          NSFontAttributeName,nil];
    
    [_finishOrWait setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [_finishOrWait addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _finishOrWait;
}

#pragma mark -分类按钮点击事件-
- (void)segmentValueChanged:(UISegmentedControl *)sender{
    NSUInteger segIndex = [sender selectedSegmentIndex];
    UIViewController *controller = [self controllerForSegIndex:segIndex];
    NSArray *array2 = [self.view subviews];
    //将当旧VC的view移除，然后在添加新VC的view
    if (array2.count != 0) {
        if (segIndex == 0) {
            [_finishVC.view removeFromSuperview];
        }else{
            [_waitVC.view removeFromSuperview];
        }
    }
    [self.view addSubview:controller.view];
    
}

//根据字典中是否存在相关页面对应的key，没有的话存储
- (UIViewController *)controllerForSegIndex:(NSUInteger)segIndex {
    NSString *keyName = [NSString stringWithFormat:@"VC_%ld",segIndex];
    
    UIViewController *controller = (UIViewController *)[listDic objectForKey:keyName];
    
    if (!controller) {
        if (segIndex == 0) {//订房
            controller = self.finishVC;
            
        }else{//退房
            controller = self.waitVC;
        }
        [listDic setObject:controller forKey:keyName];
    }
    
    return controller;
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
