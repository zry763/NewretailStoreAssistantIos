//
//  BorringProcessView.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringProcessView.h"
#import "StepModel.h"

@implementation BorringProcessView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setupViewWithModel:(id)model{
    
    StepModel *currentModel = (StepModel *)model;
    
    self.firstStep.text = currentModel.firstSteptTitle;
    self.secondStep.text = currentModel.secondSteptTitle;
    self.thirdStep.text = currentModel.thirdSteptTitle;
    
    switch (currentModel.currentStep) {
        case 1:
            [self.firstStep setTextColor:[TRCColor colorFromHexCode:@"#FC2D2D"]];
            break;
        case 2:
            [self.secondStep setTextColor:[TRCColor colorFromHexCode:@"#FC2D2D"]];

            break;
        case 3:
            [self.thirdStep setTextColor:[TRCColor colorFromHexCode:@"#FC2D2D"]];

            break;
        default:
            break;
    }

}
- (void)awakeFromNib {
    
    [super awakeFromNib];

    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
}


@end
