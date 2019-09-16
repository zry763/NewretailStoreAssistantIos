//
//  TRCAESUtil.h
//  TaiHeToolKit
//
//  Created by 陆佳峰 on 10/13/15.
//  Copyright © 2015 TaiHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCAESUtil : NSObject

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密

+ (NSString *)AES128Encrypt:(NSString *)plainText;

+ (NSString*)AES128Decrypt:(NSString *)encryptText;


@end
