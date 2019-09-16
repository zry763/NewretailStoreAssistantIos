//
//  MD5.h
//  TaiHeToolKit
//
//  Created by 佳峰 陆 on 12-5-22.
//  Copyright (c) 2012年 bitflying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5_Extensions)

- (NSString *)MD5;

@end

@interface NSData (MD5_Extensions)

- (NSString *)MD5;

@end

