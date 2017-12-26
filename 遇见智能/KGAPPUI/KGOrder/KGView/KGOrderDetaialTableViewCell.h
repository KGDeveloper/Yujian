//
//  KGDetaialTableViewCell.h
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGOrderDetaialTableViewCell : UITableViewCell
/**
 房间图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/**
 房间名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 房间床位号
 */
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
/**
 是否入住状态
 */
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
/**
 入住用户姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
/**
 入住时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
