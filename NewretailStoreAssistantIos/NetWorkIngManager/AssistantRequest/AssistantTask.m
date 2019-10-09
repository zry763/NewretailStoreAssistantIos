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


#pragma mark 登录
+ (AssistantRequest *)loginWithPhoneNumber:(NSString*)phoneNumber
                                  password:(NSString*)password
                                   storeID:(NSString*)storeID
                              successBlock:(void(^) (UserInfoModel *infoModel))successBlock
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
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            UserInfoModel *infoModel = [UserInfoModel mj_objectWithKeyValues:result.output];
            [[NSUserDefaults standardUserDefaults] setObject:infoModel.storeNumber forKey:@"storeNumber"];
            [[UserInfoModel sharedInstance] archiveUserInfo:infoModel];
            successBlock(infoModel);
            
        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
    
    
}
#pragma mark 门店信息纵览
+ (AssistantRequest *)storeInfoWithStoreId:(NSString*)storeId
                                 startTime:(NSString*)startTime
                                   endTime:(NSString*)endTime
                                     token:(NSString*)token
                              successBlock:(void(^) (StoreInfoModel *storeinfoModel))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    if ([TRCStringUtil isEmpty:storeId]) {
        
        return nil;
        
    }
    
    if ([TRCStringUtil isEmpty:token]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/homePage/getHomePageStat";
    NSDictionary *params = @{@"url":url,@"storeId":storeId,@"startTime":startTime,@"endTime":endTime,@"token":token};
    
    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            StoreInfoModel *infoModel = [StoreInfoModel mj_objectWithKeyValues:result.output];
            successBlock(infoModel);
            
        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}
#pragma mark 预约项目列表(登录用户所属门店存在待核销的项目列表)

+ (AssistantRequest *)hxListInfoWithToken:(NSString*)token
                               successBlock:(void(^) (NSArray *projectItemModelArray))successBlock
                               failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    if ([TRCStringUtil isEmpty:token]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/reservation/reservationProjectList";
    NSDictionary *params = @{@"url":url,@"token":token};
    
    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            NSArray *datalist= [result.output objectForKey:@"list"];
            NSArray *itemArray = [ProjectItemModel mj_objectArrayWithKeyValuesArray:datalist];
            successBlock(itemArray);
            
        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}
#pragma mark 预约活动列表(核销 已核销)

+ (AssistantRequest *)hxListInfoWithTypeId:(NSString*)typeId
                               orderStatus:(NSString*)orderStatus
                                      page:(NSString*)page
                                     limit:(NSString*)limit
                              successBlock:(void(^) (NSArray *orderArray))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
      if ([TRCStringUtil isEmpty:typeId]) {
          
          return nil;
          
      }
      
      AssistantRequest *request = [[AssistantRequest alloc] init];
      NSString *url = @"app/reservation/reservationActivityList";
      NSDictionary *params = @{@"url":url,@"typeId":typeId,@"orderStatus":orderStatus,@"page":page,@"limit":limit};
      
      request.contentType = TRCHTTPContentTypeURLEncoded;
      
      AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
      
      [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
          
          if ([result.output isKindOfClass:[NSDictionary class]]) {
              NSArray *datalist= [result.output objectForKey:@"list"];
              NSArray *itemArray = [ProjectItemModel mj_objectArrayWithKeyValuesArray:datalist];
              successBlock(itemArray);
              
          }else{
              successBlock(nil);
              
          }
      } failureBlock:^(TRCResult *result) {
          
          
          failureBlock(result);
          
          
      }];
      
      
      return request;
      
}
@end
