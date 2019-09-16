//
//  NSArray+Extension.m
//  TaiHeToolKit
//
//  Created by 朱封毅 on 25/07/16.
//  Copyright © 2016年 TaiHe. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

-(NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *msr = [NSMutableString string];
    
    [msr appendString:@"["];
    
    for (id obj in self) {
    
        [msr appendFormat:@"\n\t%@,",obj];
    }
    //去掉最后一个逗号（,）
    
    if ([msr hasSuffix:@","]) {
        NSString *str = [msr substringToIndex:msr.length - 1];
        msr = [NSMutableString stringWithString:str];
    }
    
    [msr appendString:@"\n]"];
    return msr;
}

@end
