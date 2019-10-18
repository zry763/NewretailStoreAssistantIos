//
//  AssistantRequest.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/16.
//  Copyright © 2019 zry. All rights reserved.
//

#import "AssistantRequest.h"
#import "TRCResult+AssistantResult.h"
#import "TRCDeviceInfo.h"
#import "AFHTTPSessionManager.h"
@implementation AssistantRequest

#pragma mark 设置请求头信息(重写父类方法)
- (void)setupRequestHeaderInfoWithSessionManager:(AFHTTPSessionManager *)sessionManager {
    
    NSMutableDictionary * headerInfo = [[[TRCDeviceInfo defaultInfo] generateDictionary] mutableCopy];
    UserInfoModel *infomodel = [[UserInfoModel sharedInstance] accountInfoUnarchiver];
    [headerInfo setValue:infomodel.token forKey:@"token"];

//
//
//    // 添加本地缓存
//    NSString *localToken = [[TRCTokenManager sharedInstance] getToken];
//    if (localToken) {
//
//        [headerInfo setValue:localToken forKey:@"token"];
//        NSString *domain = [sessionManager.baseURL host];
//        [[TRCTokenManager defaultManager] setCookieWithDomain:domain path:@"/" key:@"token" value:localToken];
//
//
////    // 设置自定义User-Agent
//    [sessionManager.requestSerializer setValue:sessionManager.userAgent forHTTPHeaderField:@"user-agent"];
    
    // 遍历henderInfo信息
    [headerInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        
        [sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        
    }];
}

#pragma mark - Private Methods
#pragma mark 网络请求结束后请求结果的分析
- (void)requestFinishedWithResponse:(NSHTTPURLResponse *)response params:(NSDictionary *)params responseObject:(id)responseObject error:(NSError *)error successBlock:(TRCRequestFinishedBlock)successBlock failureBlock:(TRCRequestFinishedBlock)failureBlock {
    
    
    NSLog(@"\n====================== REQUEST ======================\n\n%@\n\n%@\n\n", response.URL.absoluteString, params);
    
    NSInteger responseCode  = error.code;
    NSInteger statusCode = response.statusCode;

    
    if (statusCode == 200) {
        
        NSLog(@"====================== RESPONSE SUCCESS ======================\n\n%@\n\n", responseObject);
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            TRCResult *result = [TRCResult resultFromResponseObject:responseObject];
            result.responseHeaderFields = response.allHeaderFields;
            
            
            if (result.success) {
                
                successBlock(result);
                
            } else if(result.responseCode == TRCAccountCenterStatusCodeTypeServerError || result.responseCode == TRCAccountCenterStatusCodeTypeServerError || result.responseCode == TRCAccountCenterStatusCodeTypeSessionTimeOut){
                failureBlock(result);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"STORELOGINERROR" object: nil];

            }else
                failureBlock(result);

        }
        
    }
}


#pragma mark 获取接口请求缓存数据成功后调用(子类根据自己的需要重写此方法)
- (void)loadCachedResponseObjectFinishedWithResponseObject:(id)responseObject params:(NSDictionary *)params successBlock:(TRCRequestFinishedBlock)successBlock {
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        TRCResult *result = [TRCResult resultFromResponseObject:responseObject];
        
        if (result.success) {
            
            successBlock(result);
        }
    }
}

#pragma mark - Private Methods
//  获取当前手机的时间
- (NSString *)getSystemCurrentTime {
    
    NSDate *dateTo = [NSDate date]; // 获得时间对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:dateTo];
    
    return currentDateStr;
}
@end
