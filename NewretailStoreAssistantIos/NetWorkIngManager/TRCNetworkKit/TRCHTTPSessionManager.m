//
//  TRCHTTPSessionManager.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 06/12/2016.
//  Copyright © 2016 泰然城. All rights reserved.
//

#import "TRCHTTPSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "TRCStringUtil.h"

@implementation TRCHTTPSessionManager


#pragma mark - Getter
- (NSString *)userAgent {
    
    // [self.paySessionManager.requestSerializer setValue:_userAgent forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    // app版本(对外)
    NSString *appVersionName = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    // app版本(对内)
    NSString *appVersionCode = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    //手机序列号
    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
    //手机系统版本
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    
    //e.g. @"iPhone", @"iPod touch"
    NSString *phoneModel = [[UIDevice currentDevice] model];
    
    // 工程名
    if ([TRCStringUtil isEmpty:self.productName]) {
        
        self.productName = @"lawcert";
    }
    
    // 屏幕高度
    NSString *screenHeight = [NSString stringWithFormat:@"%.0f",[[UIScreen mainScreen] bounds].size.height];
    
    // 屏幕宽度
    NSString *screenWidth = [NSString stringWithFormat:@"%.0f",[[UIScreen mainScreen] bounds].size.width];
    
    
    // User-Agent
    NSString *userAgent = [NSString stringWithFormat:@"OS/iOS AppChannel/AppStore PhoneBrand/Apple OSVersion/%@ Product/%@ PhoneModel/%@ IMEI/%@ AppVersionName/%@ AppVersionCode/%@ ScreenHeight/%@ ScreenWidth/%@", osVersion, self.productName , phoneModel, uuid, appVersionName, appVersionCode, screenHeight, screenWidth];
    
    return userAgent;
}


@end
