//
//  BaseTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/17.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //选中无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [TRCColor colorFromHexCode:@"#ffffff"];
    // Initialization code
}
-(void)setUpWithModel:(id)Model{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark 统一设置内边距
- (void)setFrame:(CGRect)frame
{
    //修改cell的左右边距为10;
    //修改cell的Y值下移10;
    //修改cell的高度减少10;
    
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * frame.origin.x;
    frame.origin.y += margin;
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

#pragma mark 生成一张由两张图片叠加而成的图片
- (UIImage *)getBackGroundImageWithimgae:(UIImage*) image forsize:(CGSize )size;
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:drawRect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
    
}
@end
