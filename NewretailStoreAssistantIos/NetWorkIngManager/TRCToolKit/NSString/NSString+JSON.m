//
//  NSString+JSON.m
//  TaiHeToolKit
//
//  Created by 朱封毅 on 23/09/15.
//  Copyright (c) 2015年 泰然财富. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)


- (NSDictionary *)dictionaryWithJsonString {
    if (self == nil) {
        return nil;
    }
    
    NSData * jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}


#pragma mark 把格式化的JSON格式的字符串转换成基本数据对象
- (id)JSONObjectWithString {
    
    if (self.length == 0) {
        return nil;
    }
    
    NSData * jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return JSONObject;
}

#pragma mark  把字典转化为json字符串
- (NSString *)getJsonStringWithDictionary:(NSDictionary *)dic{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}


@end
