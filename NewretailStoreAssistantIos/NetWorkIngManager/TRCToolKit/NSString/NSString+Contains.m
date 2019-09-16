//
//  NSString+Contains.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 27/07/2017.
//  Copyright © 2017 泰然城. All rights reserved.
//

#import "NSString+Contains.h"

@implementation NSString (Contains)

- (BOOL)hasContainsString:(NSString *)string {
    
    if ([self rangeOfString:string].location != NSNotFound) {
        
        return YES;
    }

    return NO;
}

@end
