//
//  TRCStringUtil.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 22/10/2016.
//  Copyright © 2016 泰然城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRCStringUtil : NSObject


/**
 *  判断字符串是否为空
 *
 *  string 判断的字符串
 *
 *  判断结果
 */
+ (BOOL)isEmpty:(NSString *)string;


/**
 *  判断字符串是否是手机号码
 *
 *  mobileNumber 判断的字符串
 *
 *  判断结果
 */
+ (BOOL)checkMobileNumber:(NSString *)mobileNumber;


/**
 *  判断字符串是否是电话号码
 *
 *  telephoneNumber 判断的字符串
 *
 *  判断结果
 */
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber;




/**
 *  检测是否是验证码
 *
 *  astr 验证码字符串
 *
 *  是否校验成功
 */
+ (BOOL)checkCode:(NSString *)astr;



/**
 *  检测是秘密
 *
 *  aStr 密码字符串
 *
 *  检测结果
 */
+ (BOOL)checkPwd:(NSString *)aStr;


/**
 *  检测是否是身份证号
 *
 *  IDCard 身份证号字符串
 *
 *  检测结果
 */
+ (BOOL)isValidateIDCard:(NSString *)IDCard;

/**
 *  浮点型数据四舍五入
 *
 *  format 保留两位小数  传入@"0.00";
 *  floatV 字符数据
 *
 *  四舍五入保留两位后的字符串
 */
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;


/**
 *  处理投资金额
 *
 *  amount 投资金额
 *
 *  传出带单位的金额字符串(元，千，万)
 */
+ (NSString *)dealInvestAmount:(double)amount;


/**
 *  处理投资份额
 *
 *  amount 投资金额
 *
 *  传出带单位的金额字符串(元，千，万)
 */
+ (NSString *)dealCreditorAmount:(NSInteger)amount;



/**
 *  格式化所有带标签的文本
 *
 *  html 带标签的字符串
 *
 *  处理完成后不带标签的字符串
 */
+ (NSString *)filterHTML:(NSString *)html;



/**
 *  去除手机号码中的特殊符号
 *
 *  phoneNumber 需要进行处理的手机号码
 *
 *  格式化后的手机号码
 */
+ (NSString *)formatPhoneNumber:(NSString *)phoneNumber;


+ (NSAttributedString *)attributedText:(NSArray*)stringArray attributeArray:(NSArray *)attributeArray;


+ (BOOL)formatAmount:(NSString *)amount range:(NSRange)range textField:(UITextField * )textField;


@end
