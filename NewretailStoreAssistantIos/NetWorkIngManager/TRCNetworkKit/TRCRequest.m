//
//  TRCRequest.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 08/10/2016.
//  Copyright © 2016 浙江小泰科技科技有限公司. All rights reserved.
//

#import "TRCRequest.h"
#import "AFHTTPSessionManager.h"
#import "TRCDeviceInfo.h"
#import "MD5.h"
#import "TRCRequestCacheManager.h"

@interface TRCRequest () {
    
    NSString *requestURL;
    
    NSString *baseURL;
    
    NSMutableDictionary *parameters;
    
    NSString *_cacheFileName;
}


@end



@implementation TRCRequest



#pragma mark - Lifecycle
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.responseDelayTimeInterval = 1;
    }
    
    return self;
}


#pragma mark - Public Methods
#pragma mark 设置请求头信息(子类根据自己的需要重写此方法)
- (void)setupRequestHeaderInfoWithSessionManager:(AFHTTPSessionManager *)sessionManager {
    
    // Example
    /*
    NSString *deviceToken = nil;
    
    NSMutableDictionary * headerInfo = [[[TRCDeviceInfo defaultInfo] generateDictionary] mutableCopy];
    
    NSString *localToken = [[TRCTokenManager sharedInstance] getLocalToken];
    
    if (localToken) {
        
        [headerInfo setValue:localToken forKey:@"token"];
        NSString* domain = [manager.baseURL host];
        [[TRCTokenManager defaultManager] setCookieWithDomain:domain path:@"/" key:@"token" value:localToken];
    }
    
    
    if (deviceToken.length > 0) {
        
        [headerInfo setValue:deviceToken forKey:@"deviceToken"];
    }
    
    [headerInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    
    [manager.headerInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
     */
}



#pragma mark 使用的请求方法
- (void)startWithSessionManager:(AFHTTPSessionManager *)sessionManager requestType:(TRCHTTPRequestType)requestType params:(id)params successBlock:(TRCRequestFinishedBlock)successBlock failureBlock:(TRCRequestFinishedBlock)failureBlock {
    
    if (self.task) {
        
        [self cancel];
    }
    
    self.requestType = requestType;
    
    
    AFHTTPSessionManager *manager = nil;
    
    if ([sessionManager isKindOfClass:[AFHTTPSessionManager class]]) {
        
        manager = sessionManager;
    }
    
    
    if (params[@"url"]) {
    
        requestURL = params[@"url"];
        
    } else {
        
        // 此处是为了处理金融老接口而特殊处理的
        requestURL = @"clientInterface.do";
    }
    
    
    if (!manager || !requestURL) {
        
        if (!manager) {
            
            NSLog(@"未配置服务系统");
        }
        
        if (!requestURL) {
            
            NSLog(@"未配置请求地址");
        }
        
        return;
    }
    
    
    // 设置请求序列化方式
    switch (self.contentType) {
            
        case TRCHTTPContentTypeURLEncoded: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.requestSerializer.timeoutInterval = 60;
            break;
        }
            
        case TRCHTTPContentTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.requestSerializer.timeoutInterval = 60;
            break;
        }
   
        default:
            break;
    }
    
    // 设置自定义User-Agent
    [manager.requestSerializer setValue:[TRCHTTPSessionManager sharedInstance].userAgent forHTTPHeaderField:@"User-Agent"];
    
    
    if (self.requestType == TRCHTTPRequestTypeNone) {
        
        self.requestType = TRCHTTPRequestTypeGET;
    }
    
    
    NSString *method = nil;
    
    switch (self.requestType) {
            
        case TRCHTTPRequestTypeNone: {
            
            break;
        }
            
        case TRCHTTPRequestTypeOPTIONS: {
            
            method = @"OPTIONS";
            break;
        }
            
        case TRCHTTPRequestTypeHEAD: {
            
            method = @"HEAD";
            break;
        }
            
            
        case TRCHTTPRequestTypeGET: {
            
            method = @"GET";
            
            break;
        }
            
            
        case TRCHTTPRequestTypePOST: {
            
            method = @"POST";
        }
            break;
            
        case TRCHTTPRequestTypePUT: {
            
            method = @"PUT";
        }
            break;
            
        case TRCHTTPRequestTypeDELETE: {
            
            method = @"DELETE";
        }
            break;
            
        case TRCHTTPRequestTypeTRACE: {
            
            method = @"TRACE";
            break;
        }
            
        case TRCHTTPRequestTypeCONNECT: {
            
            method = @"CONNECT";
            break;
        }
            
        default:
            break;
    }
   
    
    // 设置Header
    [self setupRequestHeaderInfoWithSessionManager:manager];
    
    
    if (method.length > 0) {
        
        NSError *serializationError = nil;
        
        baseURL = [manager.baseURL absoluteString];
        
        NSString *urlString = nil;
        
        if (baseURL.length == 0) {
            
            urlString = requestURL;
            
        } else {
            
            if ([baseURL hasSuffix:@"/"] || [requestURL hasSuffix:@"/"]) {
                
                urlString = [NSString stringWithFormat:@"%@%@", baseURL, requestURL];
                
            } else {
                
                urlString = [NSString stringWithFormat:@"%@/%@", baseURL, requestURL];
            }
        }
        
        // 移除url参数
        parameters = [NSMutableDictionary dictionary];
        
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
            
            if (![key isEqualToString:@"url"]) {
                
                [parameters setValue:obj forKey:key];
            }
        }];
        
        
        NSString *requestInfo = [NSString stringWithFormat:@"Method:%@ Host:%@ Url:%@ Params:%@", method, baseURL, requestURL, parameters];
        
        _cacheFileName = [requestInfo MD5];
        
        // 判断是否使用缓存，判断本地缓存是否存在
        if (self.useCache) {
            
            id cachedResponseObject = [[TRCRequestCacheManager defaultManager] cachedResponseObjectWithCacheFileName:_cacheFileName];
            
            if (cachedResponseObject) {
                
                [self loadCachedResponseObjectFinishedWithResponseObject:cachedResponseObject params:parameters successBlock:successBlock];
            }
            
        } else {
            
            [[TRCRequestCacheManager defaultManager] removeCachedFileWithCacheFileName:_cacheFileName];
        }
        
        
        NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:urlString parameters:parameters error:&serializationError];
        
        request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        
        self.task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (![response isKindOfClass:[NSHTTPURLResponse class]]) {
                
                if (error) {
                    
                    [self requestFinishedWithResponse:(NSHTTPURLResponse *)response params:parameters responseObject:responseObject error:error successBlock:successBlock failureBlock:failureBlock];
                }
                return;
            }
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            // 判断是否需要缓存数据
            if (self.useCache && responseObject && [response isKindOfClass:[NSHTTPURLResponse class]]) {

                NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                
                if (statusCode == 200) {
                    
                    [[TRCRequestCacheManager defaultManager] saveResponseObjectToCacheFile:responseObject cacheFileName:_cacheFileName];
                }
                
                
                dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.responseDelayTimeInterval * NSEC_PER_SEC));
                
                dispatch_after(time, dispatch_get_main_queue(), ^{
                    
                    [self requestFinishedWithResponse:(NSHTTPURLResponse *)response params:parameters responseObject:responseObject error:error successBlock:successBlock failureBlock:failureBlock];
                });
                
            } else {
            
                @try {
                
                    [self requestFinishedWithResponse:(NSHTTPURLResponse *)response params:parameters responseObject:responseObject error:error successBlock:successBlock failureBlock:failureBlock];
                    
                } @catch (NSException *e) {
                    
                    TRCResult *result = [TRCResult new];
                    result.responseCode = 500;
                    result.responseContent = [NSString stringWithFormat:@"数据异常，请稍后再试 %@", e.reason];
                    failureBlock(result);
                }
                
            }

        }];
        
        [self.task resume];
    }
}


#pragma mark 网络请求结束后请求结果的分析(子类根据自己的需要重写此方法)
- (void)requestFinishedWithResponse:(NSHTTPURLResponse *)response params:(NSDictionary *)params responseObject:(id)responseObject error:(NSError *)error successBlock:(TRCRequestFinishedBlock)successBlock failureBlock:(TRCRequestFinishedBlock)failureBlock {

    
}



#pragma mark 获取接口请求缓存数据成功后调用(子类根据自己的需要重写此方法)
- (void)loadCachedResponseObjectFinishedWithResponseObject:(id)responseObject params:(NSDictionary *)params successBlock:(TRCRequestFinishedBlock)successBlock {
    
    NSLog(@"cachedResponseObject : %@", responseObject);
}



#pragma mark 根据网络请求信息获取缓存文件名
- (NSString *)cacheFileNameWithSessionManager:(AFHTTPSessionManager *)sessionManager requestType:(TRCHTTPRequestType)requestType params:(id)params {
    
    
    AFHTTPSessionManager *manager = nil;
    
    if ([sessionManager isKindOfClass:[AFHTTPSessionManager class]]) {
        
        manager = sessionManager;
    }
    
    
    if (params[@"url"]) {
        
        requestURL = params[@"url"];
        
    } else {
        
        // 此处是为了处理金融老接口而特殊处理的
        requestURL = @"clientInterface.do";
    }
    
    
    if (!manager || !requestURL) {
        
        if (!manager) {
            
            NSLog(@"未配置服务系统");
        }
        
        if (!requestURL) {
            
            NSLog(@"未配置请求地址");
        }
        
        return nil;
    }
    
    
    
    if (requestType == TRCHTTPRequestTypeNone) {
        
        requestType = TRCHTTPRequestTypeGET;
    }
    
    
    NSString *method = nil;
    
    switch (requestType) {
            
        case TRCHTTPRequestTypeNone: {
            
            break;
        }
            
        case TRCHTTPRequestTypeOPTIONS: {
            
            method = @"OPTIONS";
            break;
        }
            
        case TRCHTTPRequestTypeHEAD: {
            
            method = @"HEAD";
            break;
        }
            
            
        case TRCHTTPRequestTypeGET: {
            
            method = @"GET";
            
            break;
        }
            
            
        case TRCHTTPRequestTypePOST: {
            
            method = @"POST";
        }
            break;
            
        case TRCHTTPRequestTypePUT: {
            
            method = @"PUT";
        }
            break;
            
        case TRCHTTPRequestTypeDELETE: {
            
            method = @"DELETE";
        }
            break;
            
        case TRCHTTPRequestTypeTRACE: {
            
            method = @"TRACE";
            break;
        }
            
        case TRCHTTPRequestTypeCONNECT: {
            
            method = @"CONNECT";
            break;
        }
            
        default:
            break;
    }
    
    
    if (method.length > 0) {
        
        baseURL = [manager.baseURL absoluteString];
        
        // 移除url参数
        parameters = [NSMutableDictionary dictionary];
        
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
            
            if (![key isEqualToString:@"url"]) {
                
                [parameters setValue:obj forKey:key];
            }
        }];
        
        
        NSString *requestInfo = [NSString stringWithFormat:@"Method:%@ Host:%@ Url:%@ Params:%@", method, baseURL, requestURL, parameters];
        
        
        return [requestInfo MD5];
    }
    
    return nil;
}


#pragma mark 获取接口缓存的方法
- (id)getCachedResponseObjectWithCacheFileName:(NSString *)cacheFileName {
    
    if (![TRCStringUtil isEmpty:cacheFileName]) {
        
        id cachedResponseObject = [[TRCRequestCacheManager defaultManager] cachedResponseObjectWithCacheFileName:cacheFileName];
        
        if (cachedResponseObject) {
            
            return cachedResponseObject;
        }
    }
    
    return nil;
}



#pragma mark 删除缓存文件
- (void)removeCachedResponseObjectWithCacheFileName:(NSString *)cacheFileName {

    if (![TRCStringUtil isEmpty:cacheFileName]) {
        
        [[TRCRequestCacheManager defaultManager] removeCachedFileWithCacheFileName:cacheFileName];
    }
}



#pragma mark 取消当前正在执行的请求
- (void)cancel {
    
    if (self.task) {
        
        [self.task cancel];
    }
    
    self.task = nil;
}

@end
