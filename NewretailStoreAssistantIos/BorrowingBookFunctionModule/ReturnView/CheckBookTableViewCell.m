//
//  CheckBookTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "CheckBookTableViewCell.h"

@implementation CheckBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpWithModel:(id)model{
    
    ReturnBookRecordInfo *bookInfo = (ReturnBookRecordInfo *)model;
    
    [self.bookName setText:bookInfo.productName];
    [self.borringCount setText:[NSString stringWithFormat:@"x%@",[NSNumber numberWithInteger:bookInfo.lendingCount]]];
    
    
}
@end
