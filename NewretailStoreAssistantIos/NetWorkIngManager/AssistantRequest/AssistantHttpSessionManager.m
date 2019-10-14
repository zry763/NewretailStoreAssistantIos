//
//  AssistantHttpSessionManager.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/30.
//  Copyright © 2019 zry. All rights reserved.
//

#import "AssistantHttpSessionManager.h"
static NSInteger TRC_ACCOUNT_CENTER_REQUSET_TIMEOUT_INTERVAL = 5;

static AssistantHttpSessionManager *assistantManager = nil;

@implementation AssistantHttpSessionManager
+ (instancetype)defaultManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!assistantManager) {
            assistantManager = [[AssistantHttpSessionManager alloc]init];
            [assistantManager initPreBaseUrl];
        }
    });
    return assistantManager;

    
}
-(void)initPreBaseUrl{
//    dev  http://10.200.167.42:8092/app/
//    test  http://10.200.167.44:8092/app/
//    online  https://nrstore.tairanmall.com/app/
    
    self.accountCenterDomain=@"http://10.200.167.42:8092";

    
    self.hxBaseURLString = @"";
    self.bookBaseURLString = @"";
    
    self.loginCenterSessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:self.accountCenterDomain]];
    self.loginCenterSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.loginCenterSessionManager.requestSerializer.timeoutInterval = TRC_ACCOUNT_CENTER_REQUSET_TIMEOUT_INTERVAL;
    self.loginCenterSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.HxPartSessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:self.accountCenterDomain]];
    self.HxPartSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.HxPartSessionManager.requestSerializer.timeoutInterval = TRC_ACCOUNT_CENTER_REQUSET_TIMEOUT_INTERVAL;
    self.HxPartSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.BookBorringSessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:self.accountCenterDomain]];
    self.BookBorringSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.BookBorringSessionManager.requestSerializer.timeoutInterval = TRC_ACCOUNT_CENTER_REQUSET_TIMEOUT_INTERVAL;
    self.BookBorringSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];

    
    
}
@end
