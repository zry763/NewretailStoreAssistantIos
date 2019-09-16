//
//  NSString+Size.h
//  TaiHeToolKit
//
//  Created by 朱封毅 on 05/07/16.
//  Copyright © 2016年 TaiHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 *  根据字体的给定宽度和字体大小，计算字符串的高度
 *
 *  width 字体最大宽度
 *  font  字体大小
 *
 *  计算结果
 */
- (float)calculateStrWithWidth:(float)width font:(UIFont *)font;

@end
