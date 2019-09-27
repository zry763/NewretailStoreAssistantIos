//
//  ReturnResultInfoView.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "ReturnResultInfoView.h"

@implementation ReturnResultInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setupViewWithModel:(id)model{
    
    
    
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self.continueReturnBT setTitleEdgeInsets:UIEdgeInsetsMake(0, -
                                             self.continueReturnBT.imageView.frame.size.width, 0, self.continueReturnBT.imageView.frame.size.width)];
    [self.continueReturnBT setImageEdgeInsets:UIEdgeInsetsMake(0, self.continueReturnBT.titleLabel.bounds.size.width, 0, - self.continueReturnBT.titleLabel.bounds.size.width)];
    
}
- (IBAction)contiuneReturnMyself:(id)sender {
    if (self.ContinueReturnBlock) {
        self.ContinueReturnBlock();
    }
}
@end
