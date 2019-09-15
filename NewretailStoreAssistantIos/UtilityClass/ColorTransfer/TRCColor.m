//
//  TRCColor.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 9/30/16.
//  Copyright © 2016 浙江小泰科技科技有限公司. All rights reserved.
//

#import "TRCColor.h"


UIColor * TRCColorFromRGB(long long int rgbValue) {
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

UIColor * TRCColorFromRGBA(long long int rgbValue, float alpha) {
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}


@implementation TRCColor

#pragma mark 将16进制色值代码转换为UIColor对象
+ (UIColor *)colorFromHexCode:(NSString *)hexString {
    
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    
    if ([cleanString length] == 3) {
        
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    
    
    if([cleanString length] == 6) {
        
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


#pragma mark 界面默认背景颜色
+ (UIColor *)viewBackgroundColor {
    
    return [self colorFromHexCode:@"#f8f8f8"];
}


#pragma mark 金额的默认颜色
+ (UIColor *)amountColor {
    
    return nil;
}


#pragma mark 利率的默认颜色
+ (UIColor *)rateColor {
    
    return nil;
}


#pragma mark 默认灰色字体颜色
+ (UIColor *)textGrayColor {
    
    return nil;
}


#pragma mark 深灰色字体颜色
+ (UIColor *)textDarkGrayColor {
    
    return nil;
}


#pragma mark 导航条默认背景颜色
+ (UIColor *)navigationBarBackgroundColor {
    
    return nil;
}


#pragma mark 确认按钮普通状态下的背景色
+ (UIColor *)confirmButtonNormalColor {
    
    return nil;
}


#pragma mark 确认按钮高亮状态下的背景色
+ (UIColor *)confirmButtonHighlightedColor {
    
    return nil;
}


#pragma mark 确认按钮失效状态下的背景色
+ (UIColor *)confirmButtonDisabledColor {
    
    return nil;
}


#pragma mark 发送验证码按钮普通状态下的背景色
+ (UIColor *)verificationCodeButtonNormalColor {
    
    return nil;
}


#pragma mark 发送验证码按钮高亮状态下的背景色
+ (UIColor *)verificationCodeButtonHighlightedColor {
    
    return nil;
}

@end
