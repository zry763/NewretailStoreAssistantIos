//
//  TRCURLParser.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 07/11/2016.
//  Copyright © 2016 泰然城. All rights reserved.
//

#import "TRCURLParser.h"


@interface TRCURLParser ()

@property (strong, nonatomic) NSArray *variables;

@end


@implementation TRCURLParser

- (instancetype)initWithURLString:(NSString *)string {
    self = [super init];
    if (self) {
        NSString *urlString = string;
        NSScanner *scanner = [NSScanner scannerWithString:urlString];
        [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"&?"]];
        
        NSString *tempString;
        NSMutableArray *vars = [[NSMutableArray alloc] init];
        // Ignore the beginning of the string and skip to the variables.
        [scanner scanUpToString:@"?" intoString:nil];
        while ([scanner scanUpToString:@"&" intoString:&tempString]) {
            [vars addObject:tempString];
        }
        _variables = vars;
    }
    
    return self;
}

- (NSString *)valueForVariable:(NSString *)varName {
    for (NSString *var in _variables) {
        if ([var length] > [varName length] + 1 && [[var substringWithRange:NSMakeRange(0, [varName length] + 1)] isEqualToString:[varName stringByAppendingString:@"="]]) {
            NSString *varValue = [var substringFromIndex:[varName length] + 1];
            return varValue;
        }
    }
    
    return nil;
}


@end
