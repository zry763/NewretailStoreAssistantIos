//
//  TRCThreeDES.h
//  TaiHeToolKit
//
//  Created by 陆佳峰 on 8/6/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  3DES加密工具
 */
@interface TRCThreeDES : NSObject


/**
 *  对字符串进行3DES加密
 *
 *  string 原文
 *
 *  密文
 */
+ (NSString *)encryptString:(NSString *)string;


/**
 *  对字符串进行3DES解密
 *
 *  string 密文
 *
 *  原文
 */
+ (NSString *)decryptString:(NSString *)string;



/**
 *  对字符串进行3DES加密
 *
 *  plainText 明文
 *
 *  密文
 */
+ (NSString *)AES128Encrypt:(NSString *)plainText;

/**
 *  对字符串进行3DES解密
 *
 *  encryptText 密文
 *
 *  明文
 */
+ (NSString *)AES128Decrypt:(NSString *)encryptText;


@end
