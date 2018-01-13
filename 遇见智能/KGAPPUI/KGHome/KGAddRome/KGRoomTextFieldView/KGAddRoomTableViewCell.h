//
//  KGAddRoomTableViewCell.h
//  遇见智能
//
//  Created by KG on 2018/1/13.
//  Copyright © 2018年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGAddRoomTableViewCellDelegate <NSObject>
@required

- (void)deleteArray:(NSString *)roomName;

@end

@interface KGAddRoomTableViewCell : UITableViewCell

@property (weak, nonatomic) id<KGAddRoomTableViewCellDelegate>Mydelegate;
@property (weak, nonatomic) IBOutlet UILabel *roomNumber;

@end
