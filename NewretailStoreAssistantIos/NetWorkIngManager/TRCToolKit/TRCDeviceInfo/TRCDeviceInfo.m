//
//  THDeviceInfo.m
//  TaiHeCommonKit
//
//  Created by 陆佳峰 on 8/24/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import "TRCDeviceInfo.h"
#import <UIKit/UIKit.h>
#import "sys/utsname.h"

@implementation TRCDeviceInfo


/**
 *  单例模式，用于保存设备的默认信息
 *
 *  实例化对象
 */
+ (instancetype)defaultInfo {
    
    static TRCDeviceInfo *_defaultInfo = nil;
    
    if (!_defaultInfo) {
       
        _defaultInfo = [TRCDeviceInfo new];
        
        int scale = [[UIScreen mainScreen] scale];
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        // 屏幕宽度
        _defaultInfo.screenWidth = screenSize.width * scale;
        
        // 屏幕高度
        _defaultInfo.screenHeight = screenSize.height * scale;
        
        // 操作系统类型
        _defaultInfo.osType = @"I";
        
        // 操作系统版本
        _defaultInfo.osVersion = [[UIDevice currentDevice] systemVersion];
        
        // 手机厂商
        _defaultInfo.mobileFac = @"Apple";
        
        // 手机机型
        _defaultInfo.mobileMod = [[UIDevice currentDevice] model];
        
        // 版本信息
        _defaultInfo.versionsInfo = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        
        // 手机唯一标识码（禁用）
        _defaultInfo.uniquecode = @"";
        
        _defaultInfo.versionState = @"0";
        
        // 设备唯一识别号，用于消息推送
        _defaultInfo.deviceToken = @"";
    }
    
    return _defaultInfo;
}


+ (NSString *)getAppInfo {
    
    NSString *appInfo = [NSString stringWithFormat:@"Name : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion];
    return appInfo;
}


- (NSDictionary *)generateDictionary {
    
    NSMutableDictionary * deviceInfo = [[NSMutableDictionary alloc] init];
    
    // 屏幕宽度
    [deviceInfo setValue:[NSString stringWithFormat:@"%d", (int)self.screenWidth] forKey:@"screenwidth"];
    
    // 屏幕高度
    [deviceInfo setValue:[NSString stringWithFormat:@"%d", (int)self.screenHeight] forKey:@"screenheight"];
    
    // 操作系统类型
    [deviceInfo setValue:self.osType forKey:@"ostype"];
    
    // 操作系统版本
    [deviceInfo setValue: self.osVersion forKey:@"osversion"];
   
    // 手机厂商
    [deviceInfo setValue:self.mobileFac forKey:@"mobilefac"];
    
    // 手机机型
    [deviceInfo setValue:self.mobileMod forKey:@"mobilemod"];
    
    // 版本信息
    [deviceInfo setValue:self.versionsInfo forKey:@"versions-info"];
    
    
    // 手机唯一标识码（禁用）
    if (self.uniquecode.length > 0) {
        
        [deviceInfo setValue:self.uniquecode forKey:@"uniquecode"];
    }
    
    
    [deviceInfo setValue:self.versionState forKey:@"version-state"];
    
    
    // 设备唯一识别号，用于消息推送
    if (self.deviceToken.length > 0) {
        
        [deviceInfo setValue:self.deviceToken forKey:@"deviceToken"];
    }

    return deviceInfo;
}


+ (NSString*)getDeviceVersion {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

@end
