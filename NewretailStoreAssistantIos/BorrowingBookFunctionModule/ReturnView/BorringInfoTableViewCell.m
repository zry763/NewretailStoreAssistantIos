//
//  BorringInfoTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringInfoTableViewCell.h"
#import "VipReturnInfoModel.h"

@implementation BorringInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpWithModel:(id)model{
    ReturnRecords *recordMode = (ReturnRecords *)model;
    
    [self.borringTime setText:recordMode.lendingTime];
    [self.returnTime setText:recordMode.shouldReturnTime];
    [self.borringCount setText:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:recordMode.lendingCount]]];

    
}

- (IBAction)bookReturn:(id)sender {
    //图书归还按钮

    if (self.bookreturn) {
        self.bookreturn();
    }
}
@end
