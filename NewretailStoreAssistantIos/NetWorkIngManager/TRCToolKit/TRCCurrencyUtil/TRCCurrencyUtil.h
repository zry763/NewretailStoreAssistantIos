//
//  TRCCurrencyUtil.h
//  PocketWallet
//
//  Created by 陆佳峰 on 26/12/2016.
//  Copyright © 2016 蜂e贷. All rights reserved.
// 金额格式化工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  金额的最大长度
 */
static const NSInteger kTRCAmountMaxLength = 10;


@interface TRCCurrencyUtil : NSObject

/**
 *  将单位分的字符串转换为单位元
 *
 *  amount 单位为分的数字字符串，字符串中只能包含数字
 *
 *  单位元的字符串
 */
+ (NSString *)fenToYuan:(NSString *)amount;


/**
 *  将单位元的字符串转换为单位分
 *
 *  amount 单位为元的数字字符串，字符串中可以包含数字和小数点
 *
 *  单位分的字符串
 */
+ (NSString *)yuanToFen:(NSString *)amount;


/**
 *  UITextField输入金额限制，如果是合法的金额，则允许输入
 *  合法规则：
 *  1、首位不能输入小数点；
 *  2、只能输入一个小数点；
 *  3、如果第二位是小数点，则第一位可以是0，否则不允许第一位为0；
 *  4、前两位不能都是0；
 *  5、小数点后只能输入两位；
 *  6、最后一位不能是小数点；
 *  7、输入长度不能超过kAmountMaxLength
 *
 *  string    输入的字符串
 *  range     输入字符串在原字符串中的位置
 *  textField UITextField实例
 *
 *  输入合法则返回YES，否则返回NO
 */
+ (BOOL)formatCurrency:(NSString *)string range:(NSRange)range textField:(UITextField *)textField;


/**
 *  将数字转换为每三位用','分隔的字符串，精确到小数点后2位
 *
 *  number 输入的数字
 *
 *  格式化后的字符串
 */
+ (NSString *)formatNumber:(double)number;


/**
 *  根据formatterStyle格式化字符串
 *
 *  number         输入的数字
 *  formatterStyle 格式化类型
 *
 *  格式化后的字符串
 */
+ (NSString *)formatNumber:(double)number formatterStyle:(NSNumberFormatterStyle)formatterStyle;



/**
 *  将数字转换为每三位用','分隔的字符串，精确到小数点后2位
 *
 *  numberObject 输入的数字字符串或者数字对象
 *
 *  格式化后的字符串
 */
+ (NSString *)formatNumberObject:(id)numberObject;


/**
 *  根据formatterStyle格式化字符串
 *
 *  numberObject   输入的数字
 *  formatterStyle 格式化类型
 *
 *  格式化后的字符串
 */
+ (NSString *)formatNumberObject:(id)numberObject formatterStyle:(NSNumberFormatterStyle)formatterStyle;



/**
 *  金额转成中文大写
 *
 *  number 输入的数字字符串
 *
 *  中文大写金额字符串
 */
+ (NSString *)convertToChineseNumber:(NSString *)number;


@end
