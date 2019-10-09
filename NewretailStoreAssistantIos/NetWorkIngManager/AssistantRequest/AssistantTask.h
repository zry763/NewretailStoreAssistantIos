//
//  AssistantTask.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/30.
//  Copyright © 2019 zry. All rights reserved.
//接口获取

#import <Foundation/Foundation.h>
#import "AssistantRequest.h"
#import "UserInfoModel.h"
#import "StoreInfoModel.h"
#import "ProjectItemModel.h"
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
                      successBlock:(void(^) (UserInfoModel *infoModel))successBlock
                      failureBlock:(TRCRequestFinishedBlock)failureBlock;
/**
 *门店信息统计
 *storeId 门店id
 *
 *startTime 开始时间
 *endTime 结束时间
 *token      登录授权状态码
 *
 */
+ (AssistantRequest *)storeInfoWithStoreId:(NSString*)storeId
                                 startTime:(NSString*)startTime
                                   endTime:(NSString*)endTime
                                     token:(NSString*)token
                              successBlock:(void(^) (StoreInfoModel *storeinfoModel))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock;
/**
 *核销项目列表
 *storeId 门店id
 *
 */
+ (AssistantRequest *)hxListInfoWithToken:(NSString*)token
                              successBlock:(void(^) (NSArray *projectItemModelArray))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock;

/**
*预约活动列表
*
*
*/
+ (AssistantRequest *)hxListInfoWithTypeId:(NSString*)typeId
                               orderStatus:(NSString*)orderStatus
                                      page:(NSString*)page
                                     limit:(NSString*)limit
                              successBlock:(void(^) (NSArray *orderArray))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
