//
//  NSString+Verification.h
//  TaiHeToolKit
//
//  Created by 陆佳峰 on 13-10-14.
//  Copyright (c) 2013年 Seaway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verification)


/**
 *  判断字符串内容是否为整形
 *
 *  判断结果
 */
- (BOOL)isPureInt;


/**
 *  判断字符串内容是否为浮点形
 *
 *  判断结果
 */
- (BOOL)isPureFloat;


@end
