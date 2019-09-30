//
//  AssistantHttpSessionManager.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/30.
//  Copyright © 2019 zry. All rights reserved.
//域名管理

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssistantHttpSessionManager : NSObject

/**
 *  单例模式
 *
 *  单例对象
 */
+ (instancetype)defaultManager;



/**
 *  登录中心系统
 */
@property (nonatomic, strong)  AFHTTPSessionManager *loginCenterSessionManager;


/**
 *  预约核销系统
 */
@property (nonatomic, strong) AFHTTPSessionManager *HxPartSessionManager;


/**
 *  图书借阅系统
 */
@property (nonatomic, strong) AFHTTPSessionManager *BookBorringSessionManager;

/**
 *  登录中心
 */
@property (nonatomic, strong) NSString *accountCenterDomain;


/**
 *  预约核销地址
 */
@property (nonatomic, strong) NSString *hxBaseURLString;


/**
 *  图书借阅地址
 */
@property (nonatomic, strong) NSString *bookBaseURLString;
@end

NS_ASSUME_NONNULL_END
