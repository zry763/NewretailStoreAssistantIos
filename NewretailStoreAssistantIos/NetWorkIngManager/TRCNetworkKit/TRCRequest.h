//
//  TRCRequest.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 08/10/2016.
//  Copyright © 2016 浙江小泰科技科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRCResult.h"
#import "NSDictionary+TRCLog.h"
#import "NSArray+TRCLog.h"
#import "TRCHTTPSessionManager.h"

@class AFHTTPSessionManager;


typedef NSInteger TRCSessionManagerType;

typedef void (^TRCRequestFinishedBlock)(TRCResult *result);


typedef NS_ENUM(NSUInteger, TRCHTTPContentType) {
    
    TRCHTTPContentTypeJSON,
    
    TRCHTTPContentTypeURLEncoded,
};


/**
 *  HTTP请求类型
 */
typedef NS_ENUM(NSUInteger, TRCHTTPRequestType){
    /**
     *  无类型
     */
    TRCHTTPRequestTypeNone,
    
    /**
     *  返回服务器针对特定资源所支持的HTTP请求方法。也可以利用向Web服务器发送'*'的请求来测试服务器的功能性。
     */
    TRCHTTPRequestTypeOPTIONS,
    
    /**
     *  向服务器索要与GET请求相一致的响应，只不过响应体将不会被返回。这一方法可以在不必传输整个响应内容的情况下，就可以获取包含在响应消息头中的元信息。
     */
    TRCHTTPRequestTypeHEAD,
    
    /**
     *  向特定的资源发出请求。
     */
    TRCHTTPRequestTypeGET,
    
    
    /**
     *  向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。POST请求可能会导致新的资源的创建和/或已有资源的修改。
     */
    TRCHTTPRequestTypePOST,
    
    
    /**
     *  向指定资源位置上传其最新内容。
     */
    TRCHTTPRequestTypePUT,
    
    
    /**
     *  请求服务器删除Request-URI所标识的资源。
     */
    TRCHTTPRequestTypeDELETE,
    
    
    /**
     *  回显服务器收到的请求，主要用于测试或诊断。
     */
    TRCHTTPRequestTypeTRACE,
    
    
    /**
     *  HTTP/1.1协议中预留给能够将连接改为管道方式的代理服务器。
     */
    TRCHTTPRequestTypeCONNECT,
};

@interface TRCRequest : NSObject


/**
 *  当前正在执行的操作
 */
@property (nonatomic, weak) NSURLSessionDataTask *task;


/**
 *   HTTP请求的类型
 */
@property (nonatomic, assign) TRCHTTPRequestType requestType;


/**
 *  请求的序列化类型
 */
@property (nonatomic, assign) TRCHTTPContentType contentType;


/**
 *  是否使用数据缓存
 */
@property (nonatomic, assign) BOOL useCache;


/**
 *  使用缓存数据后，网络数据的响应延时时间，单位：秒（默认1秒）
 */
@property (nonatomic, assign) NSInteger responseDelayTimeInterval;


/**
 *  设置请求头信息(子类根据自己的需要重写此方法)
 */
- (void)setupRequestHeaderInfoWithSessionManager:(AFHTTPSessionManager *)sessionManager;



/**
 *  使用的请求方法
 */
- (void)startWithSessionManager:(AFHTTPSessionManager *)sessionManager requestType:(TRCHTTPRequestType)requestType params:(id)params successBlock:(TRCRequestFinishedBlock)successBlock failureBlock:(TRCRequestFinishedBlock)failureBlock;


/**
 *  网络请求结束后请求结果的分析(子类根据自己的需要重写此方法)
 *
 *  response       服务端相应对象
 *  params         传给服务端的参数
 *  responseObject 服务端返回的数据
 *  error          网络请求失败的错误信息
 *  successBlock   接口获取数据成功的回调
 *  failureBlock   接口获取数据失败的回调
 */
- (void)requestFinishedWithResponse:(NSHTTPURLResponse *)response params:(NSDictionary *)params responseObject:(id)responseObject error:(NSError *)error successBlock:(TRCRequestFinishedBlock)successBlock failureBlock:(TRCRequestFinishedBlock)failureBlock;


/**
 *  获取接口请求缓存数据成功后调用(子类根据自己的需要重写此方法)
 *
 *  responseObject 服务端返回的数据
 *  params         传给服务端的参数
 *  successBlock   接口获取数据成功的回调
 */
- (void)loadCachedResponseObjectFinishedWithResponseObject:(id)responseObject params:(NSDictionary *)params successBlock:(TRCRequestFinishedBlock)successBlock;


/**
 *  根据网络请求信息获取缓存文件名
 */
- (NSString *)cacheFileNameWithSessionManager:(AFHTTPSessionManager *)sessionManager requestType:(TRCHTTPRequestType)requestType params:(id)params;



/**
 *  根据网络请求信息直接获取缓存数据
 */
- (id)getCachedResponseObjectWithCacheFileName:(NSString *)cacheFileName;

/**
 *  删除缓存文件
 */
- (void)removeCachedResponseObjectWithCacheFileName:(NSString *)cacheFileName;


/**
 *  取消当前正在执行的请求
 */
- (void)cancel;


@end
