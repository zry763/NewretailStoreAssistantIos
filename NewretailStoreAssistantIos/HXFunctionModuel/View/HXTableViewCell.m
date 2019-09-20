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

@end
