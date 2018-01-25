//
//  KGDetaialTableViewCell.m
//  遇见智能
//
//  Created by KG on 2017/12/20.
//  Copyright © 2017年 KG祁增奎. All rights reserved.
//

#import "KGOrderDetaialTableViewCell.h"

@implementation KGOrderDetaialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (IBAction)shureClick:(UIButton *)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_orderId forKey:@"orderId"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMassage" object:self userInfo:dic];
    if ([_Mydelegate respondsToSelector:@selector(sendOrderIdToViewController:type:)]) {
        [_Mydelegate sendOrderIdToViewController:self.orderId type:@"agree"];
    }
}

- (IBAction)cancelClick:(UIButton *)sender {
    if ([_Mydelegate respondsToSelector:@selector(sendOrderIdToViewController:type:)]) {
        [_Mydelegate sendOrderIdToViewController:self.orderId type:@"refuse"];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
