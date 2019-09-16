//
//  NSString+URL.m
//  TaiHeToolKit
//
//  Created by 陆佳峰 on 4/13/16.
//  Copyright © 2016 TaiHe. All rights reserved.
//

#import "NSString+URL.h"
#import "TRCStringUtil.h"

@implementation NSString (URL)

- (NSString *)URLEncodedString {
    
    /*
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
     */
    
    
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}


- (NSString *)URLDecodedString {
    
    if ([TRCStringUtil isEmpty:self]) {
        return @"";
    }
    
    NSString * decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    return decoded;
}


@end
