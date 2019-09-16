//
//  NSDictionary+JSON.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 13/10/2017.
//  Copyright © 2017 泰然城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)


/**
 *  把字典转化为json字符串
 *
 *  dic 目标字典
 *
 *  转换后的json字符串
 */
- (NSString *)jsonString;

@end
