//
//  AssistantRequest.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/16.
//  Copyright © 2019 zry. All rights reserved.
//请求数据处理

#import "TRCRequest.h"
/**
 *  用户未登录或token失效，退出登录状态
 */

typedef NS_ENUM(NSInteger, TRCAccountCenterStatusCodeType) {
    
    
    /**
     *  请求成功
     */
    TRCAccountCenterStatusCodeTypeRequsetSuccess = 0000,
    
    
    /**
     *  请求出错
     */
    TRCAccountCenterStatusCodeTypeRequsetFailure = 4000,
    
    
    /**
     *  Session超时
     */
    TRCAccountCenterStatusCodeTypeSessionTimeOut = 4001,
    
    
    /**
     *  服务器出错
     */
    TRCAccountCenterStatusCodeTypeServerError = 4002,
    
};
static NSString *const TRCAccountCenteTokenInvalidNotification = @"TRCAccountCenteTokenInvalidNotification";
NS_ASSUME_NONNULL_BEGIN

@interface AssistantRequest : TRCRequest

@end

NS_ASSUME_NONNULL_END
