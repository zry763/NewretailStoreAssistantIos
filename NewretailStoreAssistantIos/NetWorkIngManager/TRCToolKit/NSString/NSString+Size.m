//
//  NSString+Size.m
//  TaiHeToolKit
//
//  Created by 朱封毅 on 05/07/16.
//  Copyright © 2016年 TaiHe. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (float)calculateStrWithWidth:(float)width font:(UIFont *)font
{
    return  [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil].size.height;
    
}

@end
