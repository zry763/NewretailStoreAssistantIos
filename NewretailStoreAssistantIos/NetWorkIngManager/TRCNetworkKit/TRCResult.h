//
//  TRCResult.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 08/10/2016.
//  Copyright © 2016 浙江小泰科技科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCResult : NSObject

/**
 *  Response Header
 */
@property (nonatomic, copy) NSDictionary *responseHeaderFields;


/**
 *  服务端返回的状态码
 */
@property (nonatomic, assign) NSInteger statusCode;


/**
 *  请求操作相应码
 */
@property (nonatomic, assign) NSInteger responseCode;


/**
 *  请求失败的内容
 */
@property (nonatomic, copy) NSString *responseContent;


/**
 *  服务端返回的数据
 */
@property (nonatomic, copy) NSDictionary *output;

@end
