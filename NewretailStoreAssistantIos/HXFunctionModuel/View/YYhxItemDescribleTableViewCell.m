//
//  YYhxItemDescribleTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "YYhxItemDescribleTableViewCell.h"

@implementation YYhxItemDescribleTableViewCell

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
    GoodslistModel *goodModel =[detailInfoModel.goodsList objectAtIndex:0];
    if (goodModel) {
        
        [self.itemDescribleLable setText:goodModel.goodsName];
        [self.itemCount setText:[NSString stringWithFormat:@"x%ld",(long)goodModel.number]];
        
    }


}
@end
