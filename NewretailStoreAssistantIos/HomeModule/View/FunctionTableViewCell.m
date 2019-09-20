//
//  FunctionTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "FunctionTableViewCell.h"

@implementation FunctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark 数据填充

-(void)setUpWithModel:(id)model{
 
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectFunctionModuel:(id)sender {
    UIButton *destBt = (UIButton *)sender;
    if (self.functionIndex) {
        self.functionIndex(destBt.tag);
    }
}

@end
