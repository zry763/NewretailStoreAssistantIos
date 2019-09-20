//
//  StoreDetailTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/17.
//  Copyright © 2019 zry. All rights reserved.
//

#import "StoreDetailTableViewCell.h"

@implementation StoreDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark 数据填充

-(void)setUpWithModel:(id)model{
    
    
    
}
#pragma mark 统一设置内边距
- (void)setFrame:(CGRect)frame
{
    //修改cell的左右边距为10;
    //修改cell的Y值下移10;
    //修改cell的高度减少10;
    
    static CGFloat margin = 0;
    frame.origin.x = margin;
    frame.size.width -= 2 * frame.origin.x;
    //    frame.origin.y += margin;
    frame.size.height -= 0;
    
    [super setFrame:frame];
}

@end
