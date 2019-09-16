//
//  THDeviceInfo.h
//  TaiHeCommonKit
//
//  Created by 陆佳峰 on 8/24/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRCDeviceInfo : NSObject

/**
 *  屏幕宽度
 */
@property (assign, nonatomic) CGFloat screenWidth;


/**
 *  屏幕高度
 */
@property (assign, nonatomic) CGFloat screenHeight;


/**
 *  操作系统类型
 */
@property (strong, nonatomic) NSString *osType;


/**
 *  操作系统版本
 */
@property (strong, nonatomic) NSString *osVersion;


/**
 *  手机厂商
 */
@property (strong, nonatomic) NSString *mobileFac;


/**
 *  手机机型
 */
@property (strong, nonatomic) NSString *mobileMod;


/**
 *  版本信息
 */
@property (strong, nonatomic) NSString *versionsInfo;


/**
 *  手机唯一标识码
 */
@property (strong, nonatomic) NSString *uniquecode;


@property (strong, nonatomic) NSString *versionState;


/**
 *  设备唯一识别号，用于消息推送
 */
@property(nonatomic,strong) NSString *deviceToken;



/**
 *  单例模式，用于保存设备的默认信息
 *
 *  实例化对象
 */
+ (instancetype)defaultInfo;

/**
 *  获取APP信息
 */
+ (NSString *)getAppInfo;

/**
 *  生成Dictionary格式的设备信息
 *
 *  生成的设备信息
 */
- (NSDictionary *)generateDictionary;


@end
