//
//  NSArray+TRCLog.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 13/10/2016.
//  Copyright © 2016 陆佳峰. All rights reserved.
//

#import "NSArray+TRCLog.h"

@implementation NSArray (TRCLog)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}

@end
