//
//  TRCTimeUtil.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 10/10/2016.
//  Copyright © 2016 陆佳峰. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  时间日期格式化工具类
 */
@interface TRCTimeUtil : NSObject

/**
 *  获取当前时间戳
 *
 *  当前时间戳
 */
+ (NSTimeInterval)getCurrentTimeInterval;


/**
 *  将手机当天日期转换为"yyyy-MM-dd"格式的字符串
 *
 *  格式化后的字符串
 */
+ (NSString *)formatCurrentDate;


/**
 *  将手机当天日期转换为formatString指定格式的字符串
 *
 *  formatString 日期格式，如"yyyy-MM-dd"
 *
 *  格式化后的字符串
 */
+ (NSString *)formatCurrentDate:(NSString *)formatString;


/**
 *  将NSDate对象转换为"yyyy-MM-dd"格式的字符串
 *
 *  date NSDate对象
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterDate:(NSDate *)date;


/**
 *  将NSDate对象转换为formatString指定格式的字符串
 *
 *  date         NSDate对象
 *  formatString 日期格式，如"yyyy-MM-dd"
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterDate:(NSDate *)date formatString:(NSString *)formatString;


/**
 *  将格式为"yyyyMMdd"的日期字符串转换为NSDate对象
 *
 *  dateString  8位日期字符串，格式必须为"yyyyMMdd"
 *
 *  NSDate对象
 */
+ (NSDate *)getDateFromDateString:(NSString *)dateString;


/**
 *  将日期字符串根据formatString格式转换为NSDate对象
 *
 *  dateString   日期字符串
 *  formatString dateString的日期格式，如"yyyyMMdd"
 *
 *  NSDate对象
 */
+ (NSDate *)getDateFromDateString:(NSString *)dateString formatString:(NSString *)formatString;


/**
 *  将"yyyyMMddHHmmss"格式的字符串转换为"yyyy-MM-dd HH:mm:ss"格式的字符串
 *
 *  timeString 格式为"yyyyMMddHHmmss"的字符串
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterDateAndTime:(NSString *)timeString;


/**
 *  将"yyyyMMddHHmmss"格式的字符串转换为formatString指定格式的字符串
 *
 *  timeString         格式为"yyyyMMddHHmmss"的字符串
 *  formatString 日期格式，如"yyyy年MM月dd日 HH:mm:ss"
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterDateAndTime:(NSString *)timeString formatString:(NSString *)formatString;


/**
 *  将格式为"yyyyMMdd"的日期字符串转换为"yyyy-MM-dd"格式的字符串
 *
 *  dateString 格式为"yyyyMMdd"的日期字符串
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterDateString:(NSString *)dateString;


/**
 *  将格式为"HHmmss"的时间字符串转换为"HH:mm:ss"格式字符串
 *
 *  timeString 6位的时间字符串，格式必须为"HHmmss"
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterTimeString:(NSString *)timeString;


/**
 *  将从1970开始的时间数字转换为"yyyy-MM-dd HH:mm:ss"格式的字符串
 *
 *  timeInterval double类型的时间串
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterDateAndTimeToStringWithTimeIntervalFrom1970:(double)timeInterval;

/**
 *  将从1970开始的时间数字转换为"yyyy-MM-dd"格式的字符串
 *
 *  timeInterval double类型的时间串
 *
 *  格式化后的字符串
 */
+ (NSString *)formatterDateToStringWithTimeIntervalFrom1970:(double)timeInterval;

/**
 *  将从1970开始的时间数字转换为"yyyyMMdd"格式的字符串
 *
 *  timeInterval double类型的时间串
 *
 *  格式化后的字符串MM月dd日
 */
+ (NSString *)formatterDateMMString:(NSString *)dateString;
@end
