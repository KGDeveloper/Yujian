//
//  KGRoomTypeTableViewCell.h
//  遇见智能
//
//  Created by KG on 2018/1/13.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGRoomTypeTableViewCellDelegate <NSObject>
@required

- (void)deleteArray:(NSString *)roomName;

@end

@interface KGRoomTypeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UIView *deleBtu;

@property (nonatomic,weak) id<KGRoomTypeTableViewCellDelegate>Mydelegate;

@end
