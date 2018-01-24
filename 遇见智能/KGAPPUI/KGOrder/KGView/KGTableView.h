//
//  KGTableView.h
//  遇见智能
//
//  Created by KG on 2017/12/19.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGtableviewDelegate <NSObject>

- (void)pushToDetaialController:(NSString *)order;
//- (void)reloadTableViewData;

@end

@interface KGTableView : UIView

@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,assign) id<KGtableviewDelegate>Mydelegate;

@end
