//
//  NSString+JSON.h
//  TaiHeToolKit
//
//  Created by 朱封毅 on 23/09/15.
//  Copyright (c) 2015年 泰然财富. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  解析结果字典
 */
- (NSDictionary *)dictionaryWithJsonString;


/**
 *  把格式化的JSON格式的字符串转换成基本数据对象
 *
 *  解析结果对象
 */
- (id)JSONObjectWithString;


/**
 *  把字典转化为json字符串
 *
 *  dic 目标字典
 *
 *  转换后的json字符串
 */
- (NSString *)getJsonStringWithDictionary:(NSDictionary *)dic;


@end
