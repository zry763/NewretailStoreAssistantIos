//
//  YYListTableViewCell.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "YYListTableViewCell.h"

@implementation YYListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubView];
    // Initialization code
}
-(void)setupSubView{
    
    [self.goHxButton.layer addSublayer:[self drawRectCornRadius]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)getYYlistForProjectIndex:(id)sender {
    
    if (self.yylistProject) {
        self.yylistProject(1);
    }
    
}
- (IBAction)goHxForProjectIndex:(id)sender {
    if (self.yyHXProject) {
        self.yyHXProject(1);
    }
}

//输入框圆角效果
-(CAShapeLayer *)drawRectCornRadius
{
    CGFloat radius = 15; // 圆角大小
    UIRectCorner corner = UIRectCornerAllCorners; // 圆角位置，全部位置
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.goHxButton.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.goHxButton.bounds;
    maskLayer.path = path.CGPath;
    maskLayer.strokeColor = [TRCColor colorFromHexCode:@"#ffffff"].CGColor;
    maskLayer.fillColor = [UIColor clearColor].CGColor;

    return maskLayer;
}
-(void)setUpWithModel:(id)model{
    
    ProjectItemModel *itemMode = (ProjectItemModel *)model;
    if ([itemMode.typeId integerValue] == 1) {
        //便当
        [self.backgroundImageView  setImage:[UIImage imageNamed:@"Bento"]];
    }
    if ([itemMode.typeId integerValue] == 2) {
        //班车
        [self.backgroundImageView  setImage:[UIImage imageNamed:@"Bento"]];
    }
    if ([itemMode.typeId integerValue] == 3) {
        //场地
        [self.backgroundImageView  setImage:[UIImage imageNamed:@"Bento"]];
    }
    NSInteger sumCount = [itemMode.completedNum integerValue] + [itemMode.incompleteNum integerValue];
    self.yyProjectTitle.text = itemMode.typeName;
    self.yySummuryCount.text = [NSString stringWithFormat:@"%ld",(long)sumCount];
    self.dhxCount.text = itemMode.incompleteNum;
    self.yhxCount.text = itemMode.completedNum;

    
    
}
@end
