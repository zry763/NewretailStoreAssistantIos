//
//  TRCStringUtil.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 22/10/2016.
//  Copyright © 2016 泰然城. All rights reserved.
//

#import "TRCStringUtil.h"

static NSInteger TRC_INPUT_AMOUNT_MIN_LENGTH = 8;


@implementation TRCStringUtil


#pragma mark -
#pragma mark Public Methods
+ (BOOL)isEmpty:(NSString *)string {
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        
        return YES;
    }
    
    if (string == nil || string.length == 0 || [string isEqual:[NSNull null]]) {
        
        return YES;
    }
    
    return NO;
}


#pragma mark 判断字符串是否是手机号码
+ (BOOL)checkMobileNumber:(NSString *)mobileNumber
{
    if ([TRCStringUtil isEmpty:mobileNumber]) {
        
        return NO;
    }
    return YES;
    //
    //    NSString * mobileFormat = @"^((13[0-9])|(17[0-9])|(15[^(4,\\D)])|(18[0-9]))\\d{8}$";
    //
    //    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    //
    //    if ([regexMobile evaluateWithObject:mobileNumber]) {
    //
    //        return YES;
    //
    //    } else {
    //
    //        return NO;
    //    }
}


#pragma mark 判断字符串是否是电话号码
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber
{
    if ([TRCStringUtil isEmpty:telephoneNumber]) {
        
        return NO;
    }
    
    NSString * mobileFormat = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    
    if ([regexMobile evaluateWithObject:telephoneNumber]) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

#pragma mark 检测是否是验证码

+ (BOOL)checkCode:(NSString *)astr
{
    NSScanner* scan = [NSScanner scannerWithString:astr];
    int val;
    if([scan scanInt:&val] && [scan isAtEnd] && astr.length == 6) {
        return YES;
    }else return NO;
}


#pragma mark 检测是否密码

+ (BOOL)checkPwd:(NSString *)aStr
{
    
    if (aStr.length >= 6 && aStr.length <= 16) {
        return YES;
    }else
        return NO;
}

#pragma mark 检测是否是身份证号码

+ (BOOL)isValidateIDCard:(NSString *)IDCard
{
    NSString *IDCardRegex15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSString *IDCardRegex18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[\\d|x|X]$";
    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex15];
    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex18];
    return [predicate15 evaluateWithObject:IDCard] || [predicate18 evaluateWithObject:IDCard];
}


#pragma mar 四舍五入

+ (NSString *)decimalwithFormat:(NSString *)format  floatV:(float)floatV {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:format];
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}


#pragma mark 投资金额
+ (NSString *)dealInvestAmount:(double)amount {
    
    NSString * remainingAmount;
    NSString * unit;
    if (amount < 10000) {
        
        remainingAmount = [NSString stringWithFormat:@"%0.2f", amount];
        unit = @"元";
        
    } else {
        
        remainingAmount = [NSString stringWithFormat:@"%0.2f", amount / 10000];
        unit = @"万";
    }
    
    return [NSString stringWithFormat:@"%@%@", remainingAmount, unit];
}

#pragma mark 处理投资份额
+ (NSString *)dealCreditorAmount:(NSInteger)amount {
    
    NSString * remainingAmount;
    NSString * unit;
    if (amount < 10000) {
        remainingAmount = [NSString stringWithFormat:@"%ld", (long)amount];
        unit = @"份";
        
    } else {
        
        remainingAmount = [NSString stringWithFormat:@"%.2f",amount / 10000.0];
        unit = @"万份";
    }
    return [NSString stringWithFormat:@"%@%@", remainingAmount, unit];
    
}


#pragma mark 格式化所有带标签的文本
+(NSString *)filterHTML:(NSString *)html
{
    
    //    html = [html stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
    //
    //    html = [html stringByReplacingOccurrencesOfString:@"<h5>" withString:@"\n\n"];
    html = [[[html stringByReplacingOccurrencesOfString:@"</p><h5>" withString:@"\n\n"] stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"] stringByReplacingOccurrencesOfString:@"</h5><p>" withString:@"\n"];
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
    
}


#pragma mark 去除手机号码中的特殊符号
+ (NSString *)formatPhoneNumber:(NSString *)phoneNumber {
    
    if ([phoneNumber hasPrefix:@"+"]) {
        phoneNumber = [phoneNumber substringFromIndex:3];
    }
    
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return phoneNumber;
}


+ (NSAttributedString *)attributedText:(NSArray*)stringArray attributeArray:(NSArray *)attributeArray {
    
    if ([stringArray count] != [attributeArray count]) {
        
        return nil;
    }
    
    // 定义要显示的文字内容
    NSString * string = [stringArray componentsJoinedByString:@""]; // 拼接传入的字符串数组
    
    // 通过要显示的文字内容来创建一个带属性样式的字符串对象
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSInteger location = 0;
    NSInteger length = 0;
    
    for(NSInteger i = 0; i < stringArray.count; i++) {
        
        NSString *string = stringArray[i];
        
        if (![string isKindOfClass:[NSString class]]) {
            
            return nil;
        }
        
        length = string.length;
        
        // 将某一范围内的字符串设置样式
        [result setAttributes:attributeArray[i] range:NSMakeRange(location, length)];
        
        location += length;
    }
    
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}


+ (BOOL)formatAmount:(NSString *)amount range:(NSRange)range textField:(UITextField * )textField {
    
    if (!amount || amount.length == 0) {
        
        return YES;
    }
    
    
    if (amount.length > TRC_INPUT_AMOUNT_MIN_LENGTH) {
        
        return NO;
    }
    
    
    NSString * text = textField.text;
    
    if (text.length > TRC_INPUT_AMOUNT_MIN_LENGTH) {
        
        return NO;
    }
    
    NSUInteger dotLocation = [text rangeOfString:@"."].location;
    
    if ([@"." isEqualToString:amount]) {
        
        // 如果输入的是小数点，判断是否是第一位以及是否已经有小数点，如果是的 ，不能输入
        if (0 == text.length || text.length == (TRC_INPUT_AMOUNT_MIN_LENGTH - 1)) {
            return NO;
        }
        
        if (NSNotFound != dotLocation) {
            return NO;
        }
    }
    
    if ([@"0" isEqualToString:amount]) {
        
        // 如果输入的是0
        if (0 == range.location) {
            
            // 如果是第一位输入，判断第二位是否小数点，如果不是，不能输入
            if (text.length > 0) {
                
                if (![@"." isEqualToString:[text substringToIndex:1]]) {
                    
                    return NO;
                }
            }
            
        } else if (1 == range.location) {
            
            // 如果是在第二位输入，判断第一位是否0
            if ([@"0" isEqualToString:[text substringToIndex:1]]) {
                
                return NO;
            }
        }
    }
    
    if (1 == range.location && ![@"." isEqualToString:amount]) {
        
        // 如果输入的是第二位，切不是小数点，判断第一位是不是0，如果是0，则不能输入
        if ([@"0" isEqualToString:[text substringToIndex:1]]) {
            
            return NO;
        }
    }
    
    if (NSNotFound != dotLocation) {
        
        // 如果字符串中已经存在小数点，限制不能超过两位小数
        if (range.location > dotLocation) {
            
            // 如果输入字符在小数点后面
            if (range.location - dotLocation > 2) {
                
                return NO;
            }
            
        } else {
            
            // 如果输入字符在小数点前面
            if (text.length == (TRC_INPUT_AMOUNT_MIN_LENGTH - 1)) {
                
                return NO;
            }
        }
    }
    
    return YES;
    
}


@end
