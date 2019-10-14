//
//  HXTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXTableViewCell.h"

@implementation HXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [TRCColor colorFromHexCode:@"#FAFAFA"];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpWithModel:(id)model{
    
    ProjectItemListModel *listModel = (ProjectItemListModel*)model;
    [self.hxItemName setText:[NSString stringWithFormat:@"%@（%@）",listModel.userName,listModel.mobile]];
    [self.hxItemTime setText:listModel.addTime];
    [self.hxItemdes setText:listModel.activityName];
    [self.hxItemImage sd_setImageWithURL:[NSURL URLWithString:listModel.activityImg] placeholderImage:[UIImage imageNamed:@"hxzw"]];


    
}
@end
