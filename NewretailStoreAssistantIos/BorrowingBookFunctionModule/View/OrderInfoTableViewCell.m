//
//  OrderInfoTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "OrderInfoTableViewCell.h"

@implementation OrderInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setUpWithModel:(id)model
{
    
    recordList *orderinfo = (recordList*)model;
    [self.bookName setText:orderinfo.goodSnName];
    [self.bookCount setText:[NSString stringWithFormat:@"x%ld",(long)orderinfo.lendingCount]];
    [self.bookNumber setText:orderinfo.goodsSn];
    

    
    
    
}
@end
