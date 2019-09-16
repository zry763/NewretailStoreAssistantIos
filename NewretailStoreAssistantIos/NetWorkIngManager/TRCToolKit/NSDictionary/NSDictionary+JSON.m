//
//  NSDictionary+JSON.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 13/10/2017.
//  Copyright © 2017 泰然城. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

#pragma mark  把字典转化为json字符串
- (NSString *)jsonString {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
