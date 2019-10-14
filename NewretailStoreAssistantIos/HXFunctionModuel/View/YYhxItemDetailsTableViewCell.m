//
//  YYhxItemDetailsTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "YYhxItemDetailsTableViewCell.h"

@implementation YYhxItemDetailsTableViewCell

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
    
    [self.itemDetailTitle setText:detailInfoModel.userName];
    [self.itemDetailTime setText:detailInfoModel.activityName];
    [self.itemDetailImage sd_setImageWithURL:[NSURL URLWithString:detailInfoModel.activityImg]placeholderImage:[UIImage imageNamed:@"hxzw"]];


}
@end
