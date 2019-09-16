//
//  NSDictionary+TRCLog.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 13/10/2016.
//  Copyright © 2016 陆佳峰. All rights reserved.
//

#import "NSDictionary+TRCLog.h"

@implementation NSDictionary (TRCLog)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSArray *allKeys = [self allKeys];
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    
    for (NSString *key in allKeys) {
        
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    
    [str appendString:@"}"];
    
    return str;
}

@end
