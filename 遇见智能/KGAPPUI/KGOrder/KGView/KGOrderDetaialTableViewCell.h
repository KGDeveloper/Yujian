//
//  KGDetaialTableViewCell.h
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGOrderDetaialTableViewCellDelegate <NSObject>

- (void)sendOrderIdToViewController:(NSString *)orderId type:(NSString *)type;

@end

@interface KGOrderDetaialTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *roomType;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@property (nonatomic,assign) id<KGOrderDetaialTableViewCellDelegate>Mydelegate;


@end
