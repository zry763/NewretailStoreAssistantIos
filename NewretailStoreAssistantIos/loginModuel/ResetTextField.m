//
//  ResetTextField.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/11.
//  Copyright © 2019 zry. All rights reserved.
//

#import "ResetTextField.h"

@implementation ResetTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}*/
// 控制placeHolder的位置，左右缩20，但是光标位置不变
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
 return inset;
 }
// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}
// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}
@end
