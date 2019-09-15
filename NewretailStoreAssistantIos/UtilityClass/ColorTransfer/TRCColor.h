//
//  TRCColor.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 9/30/16.
//  Copyright © 2016 浙江小泰科技科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


UIColor * TRCColorFromRGB(long long int rgbValue);

UIColor * TRCColorFromRGBA(long long int rgbValue, float alpha);


// 主标题
#define TRC353535 TRCColorFromRGB(0x353535)

// 副标题
#define TRC525252 TRCColorFromRGB(0x525252)

// 注释说明
#define TRC808080 TRCColorFromRGB(0x808080)

// 弱提示
#define TRCA8A8A8 TRCColorFromRGB(0xA8A8A8)

// text默认提示，按钮不可点击背景
#define TRCC9C9C9 TRCColorFromRGB(0xC9C9C9)

// 背景色
#define TRCEFEEF4 TRCColorFromRGB(0xEFEEF4)

#define TRCF4F4F4 TRCColorFromRGB(0xF4F4F4)

// 分隔线
#define TRCE5E5E5 TRCColorFromRGB(0xE5E5E5)

// 分隔线
#define TRCE4E4E4 TRCColorFromRGB(0xE4E4E4)


// 支付密码模块颜色列表

// 标题颜色
#define TRC808080 TRCColorFromRGB(0x808080)

// 内容文字颜色
#define TRC333333 TRCColorFromRGB(0x333333)


// 蓝色按钮normal和highlighted颜色
#define TRC00A0E9 TRCColorFromRGB(0x00A0E9)
#define TRC36B5F5 TRCColorFromRGB(0x36B5F5)
#define TRC36B8FD TRCColorFromRGB(0x36B8FD)

// 橙色按钮normal和highlighted颜色
#define TRCF75432 TRCColorFromRGB(0xF75432)
#define TRCFF8561 TRCColorFromRGB(0xFF8561)

#define TRCFA525B TRCColorFromRGB(0xFA525B)
#define TRC6DCE6F TRCColorFromRGB(0x6DCE6F)

#define TRC27A1E5 TRCColorFromRGB(0x27A1E5)

//红色
#define TRCFF5555 TRCColorFromRGB(0xFF5555)

@interface TRCColor : NSObject


/**
 *  将16进制色值代码转换为UIColor对象
 *
 *  hexString 16进制色值，如"#DCDCDC"
 *
 *  UIColor对象
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;


/**
 *  界面默认背景颜色
 *
 *  UIColor对象
 */
+ (UIColor *)viewBackgroundColor;


/**
 *  金额的默认颜色
 *
 *  UIColor对象
 */
+ (UIColor *)amountColor;


/**
 *  利率的默认颜色
 *
 *  UIColor对象
 */
+ (UIColor *)rateColor;


/**
 *  默认灰色字体颜色
 *
 *  UIColor对象
 */
+ (UIColor *)textGrayColor;


/**
 *  深灰色字体颜色
 *
 *  UIColor对象
 */
+ (UIColor *)textDarkGrayColor;


/**
 *  导航条默认背景颜色
 *
 *  UIColor对象
 */
+ (UIColor *)navigationBarBackgroundColor;

/**
 *  确认按钮普通状态下的背景色
 *
 *  UIColor对象
 */
+ (UIColor *)confirmButtonNormalColor;


/**
 *  确认按钮高亮状态下的背景色
 *
 *  UIColor对象
 */
+ (UIColor *)confirmButtonHighlightedColor;


/**
 *  确认按钮失效状态下的背景色
 *
 *  UIColor对象
 */
+ (UIColor *)confirmButtonDisabledColor;


/**
 *  发送验证码按钮普通状态下的背景色
 *
 *  UIColor对象
 */
+ (UIColor *)verificationCodeButtonNormalColor;


/**
 *  发送验证码按钮高亮状态下的背景色
 *
 *  UIColor对象
 */
+ (UIColor *)verificationCodeButtonHighlightedColor;


@end
