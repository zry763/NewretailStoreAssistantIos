//
//  AssistantTask.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/30.
//  Copyright © 2019 zry. All rights reserved.
//接口获取

#import <Foundation/Foundation.h>
#import "AssistantRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface AssistantTask : NSObject

/**
 *  登录
 *
 *  phoneNumber  认证为 11 位的以前手机号码
 *  password     6 到 20 位以内的字符或数字
 *
 *
 */
+ (AssistantRequest *)loginWithPhoneNumber:(NSString*)phoneNumber
                          password:(NSString*)password
                             storeID:(NSString*)storeID
                      successBlock:(void(^) (NSDictionary *outPut))successBlock
                      failureBlock:(TRCRequestFinishedBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
