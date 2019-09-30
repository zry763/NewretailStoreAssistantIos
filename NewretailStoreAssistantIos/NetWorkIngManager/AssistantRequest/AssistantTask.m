//
//  AssistantTask.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/30.
//  Copyright © 2019 zry. All rights reserved.
// 

#import "AssistantTask.h"
#import "AssistantHttpSessionManager.h"

@implementation AssistantTask
+ (AssistantRequest *)loginWithPhoneNumber:(NSString*)phoneNumber
                                  password:(NSString*)password
                                   storeID:(NSString*)storeID
                              successBlock:(void(^) (NSDictionary *outPut))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock;{
    
    if ([TRCStringUtil isEmpty:phoneNumber]) {
        
        return nil;
        
    }
    
    if ([TRCStringUtil isEmpty:password]) {
        
        return nil;
        
    }
    
     AssistantRequest *request = [[AssistantRequest alloc] init];

     NSString *url = @"app/system/login";
     NSDictionary *params = @{@"url":url,@"username":phoneNumber,@"password":password,@"storeNumber":storeID};
    
     request.contentType = TRCHTTPContentTypeURLEncoded;
     
     AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
     [request startWithSessionManager:manager requestType:TRCHTTPRequestTypePOST params:params successBlock:^(TRCResult *result) {

        
         
         successBlock(result.output);
         
         
     } failureBlock:^(TRCResult *result) {
         
         
         failureBlock(result);
         
         
     }];
     
     
     return request;
    
    
    
}
@end
