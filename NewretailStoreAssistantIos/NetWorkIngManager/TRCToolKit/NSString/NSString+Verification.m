//
//  NSString+Verification.m
//  TaiHeToolKit
//
//  Created by 陆佳峰 on 13-10-14.
//  Copyright (c) 2013年 Seaway. All rights reserved.
//

#import "NSString+Verification.h"

@implementation NSString (Verification)

#pragma mark -
#pragma mark Public Methods
#pragma mark 判断字符串内容是否为整形
- (BOOL)isPureInt {
    
    NSScanner * scan = [NSScanner scannerWithString:self];
    
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


#pragma mark 判断字符串内容是否为浮点形
- (BOOL)isPureFloat {
    
    NSScanner * scan = [NSScanner scannerWithString:self];
    
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end
