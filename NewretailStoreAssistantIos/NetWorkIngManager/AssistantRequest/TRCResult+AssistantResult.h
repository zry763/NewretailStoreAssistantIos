//
//  TRCResult+AssistantResult.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/16.
//  Copyright © 2019 zry. All rights reserved.
//数据分类

#import "TRCResult.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  请求成功
 */
#define TRCFinanceResponseCodeSuccess 000000


@interface TRCResult (AssistantResult)
+ (id)resultFromResponseObject:(NSDictionary *)responseObject;

- (BOOL)success;
@end

NS_ASSUME_NONNULL_END
