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
static NSString *const TRCAccountCenteTokenInvalidNotification = @"TRCAccountCenteTokenInvalidNotification";
NS_ASSUME_NONNULL_BEGIN

@interface AssistantRequest : TRCRequest

@end

NS_ASSUME_NONNULL_END
