//
//  YYhxItemTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "YYhxItemTableViewCell.h"

@implementation YYhxItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUpWithModel:(id)model
{
    hxStateDetailInfoModel *detailInfoModel = (hxStateDetailInfoModel *)model;
    
    [self.itemTitle setText:detailInfoModel.userName];
    [self.itemName setText:detailInfoModel.activityName];
    [self.itemTime setText:detailInfoModel.activityTime];
    if (detailInfoModel.orderStatus == 301) {
        [self.itemState  setImage:[UIImage imageNamed:@"yihx"]];

    }else
    {
        [self.itemState  setImage:[UIImage imageNamed:@"daihx"]];

    }
}

@end
