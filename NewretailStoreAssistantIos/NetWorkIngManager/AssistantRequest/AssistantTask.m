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
#pragma mark 登出

+ (AssistantRequest *)loginoutsuccessBlock:(void(^) (TRCResult *loginResult))successBlock
failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
  
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    
    NSString *url = @"app/system/logout";
    NSDictionary *params = @{@"url":url};
    
    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypePOST params:params successBlock:^(TRCResult *result) {
        
            successBlock(result);
        
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
    
    
}
#pragma mark 获取登录人信息

+ (AssistantRequest *)getloginUserWithToken:(NSString *)token successBlock:(void(^) (UserInfoModel *userinfoModel))successBlock
failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
  
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    
    NSString *url = @"app/system/getLoginUser";
    NSDictionary *params = @{@"url":url,@"token":token};
    
    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypePOST params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            UserInfoModel *infoModel = [UserInfoModel mj_objectWithKeyValues:result.output];
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
    NSDictionary *params = @{@"url":url,@"storeId":storeId,@"startTime":startTime,@"endTime":endTime};
    
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
                                  pageInfo:(PageModel*)pageInfo
                              successBlock:(void(^) (NSArray *orderArray,NSString *uncompleteCount,NSString *completeCount,PageModel *pageInfo))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
      if ([TRCStringUtil isEmpty:typeId]) {
          
          return nil;
          
      }
      
      AssistantRequest *request = [[AssistantRequest alloc] init];
      NSString *url = @"app/reservation/reservationActivityList";
      NSDictionary *params = @{@"url":url,@"typeId":typeId,@"orderStatus":orderStatus,@"page":[NSNumber numberWithInteger:pageInfo.currPage],@"limit":[NSNumber numberWithInteger:pageInfo.pageSize]};
      
      request.contentType = TRCHTTPContentTypeURLEncoded;
      
      AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
      
      [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
          
          if ([result.output isKindOfClass:[NSDictionary class]]) {
              NSDictionary *datadic= [result.output objectForKey:@"page"];
              
              pageInfo.currPage = [[datadic objectForKey:@"currPage"] integerValue];
              pageInfo.totalPage = [[datadic objectForKey:@"totalPage"] integerValue];
              pageInfo.pageSize = [[datadic objectForKey:@"pageSize"] integerValue];

              NSArray *datalist = [datadic objectForKey:@"list"];
              NSString *incompleteNum = [NSString stringWithFormat:@"%@",[result.output objectForKey:@"incompleteNum"]];
              NSString *completedNum = [NSString stringWithFormat:@"%@",[result.output objectForKey:@"completedNum"]];

              NSArray *itemArray = [ProjectItemListModel mj_objectArrayWithKeyValuesArray:datalist];
              successBlock(itemArray,incompleteNum,completedNum,pageInfo);
              
          }else{
              successBlock(nil,nil,nil,nil);
              
          }
      } failureBlock:^(TRCResult *result) {
          
          
          failureBlock(result);
          
          
      }];
      
      
      return request;
      
}
#pragma mark 核销项目详情

+ (AssistantRequest *)hxItemDetailInfoWithreservationCode :(NSString*)reservationCode
                                              successBlock:(void(^) (hxStateDetailInfoModel *DetailInfoModel))successBlock
                                              failureBlock:(TRCRequestFinishedBlock)failureBlock{
    
    
    if ([TRCStringUtil isEmpty:reservationCode]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/reservation/reservationActivityDetail";
    NSDictionary *params = @{@"url":url,@"reservationCode":reservationCode};

    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDic= [result.output objectForKey:@"info"];
            hxStateDetailInfoModel *infoModel = [hxStateDetailInfoModel mj_objectWithKeyValues:dataDic];
            successBlock(infoModel);
            
        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}
#pragma mark 确认核销

+ (AssistantRequest *)hxConfirmItemWithTypeId:(NSString*)typeId
                             reservationCode :(NSString*)reservationCode
                                 successBlock:(void(^) (TRCResult *result))successBlock
                                 failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
    if ([TRCStringUtil isEmpty:reservationCode]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/reservation/confirmReservation";
    NSDictionary *params = @{@"url":url,@"typeId":typeId,@"reservationCode":reservationCode};

    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        if (result) {
            successBlock(result);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}
#pragma mark 核销项目搜索

+ (AssistantRequest *)hxSearchItemInfoWithTypeId:(NSString*)typeId
                                        content :(NSString*)content
                                        pageInfo:(PageModel*)pageInfo
                                    successBlock:(void(^) (NSArray *orderArray,PageModel *pageInfo))successBlock
                                    failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
    if ([TRCStringUtil isEmpty:content]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/reservation/reservationSearch";
    NSDictionary *params = @{@"url":url,@"typeId":typeId,@"page":[NSNumber numberWithInteger:pageInfo.currPage],@"limit":[NSNumber numberWithInteger:pageInfo.pageSize],@"content":content};
    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            NSDictionary *datadic= [result.output objectForKey:@"page"];
            
            pageInfo.currPage = [[datadic objectForKey:@"currPage"] integerValue];
            pageInfo.totalPage = [[datadic objectForKey:@"totalPage"] integerValue];
            pageInfo.pageSize = [[datadic objectForKey:@"pageSize"] integerValue];
            
            NSArray *datalist = [datadic objectForKey:@"list"];
            
            NSArray *itemArray = [ProjectItemListModel mj_objectArrayWithKeyValuesArray:datalist];
            successBlock(itemArray,pageInfo);
            
        }else{
            successBlock(nil,nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}
#pragma mark 核销码校验

+ (AssistantRequest *)hxCheckItemInfoWithTypeId:(NSString*)typeId
                               reservationCode :(NSString*)reservationCode
                                   successBlock:(void(^) (TRCResult *checkResult))successBlock
                                   failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
//    if ([TRCStringUtil isEmpty:reservationCode]) {
//        
//        return nil;
//        
//    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/reservation/reservationCheck";
    NSDictionary *params = @{@"url":url,@"typeId":typeId,@"reservationCode":reservationCode};

    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
 
        successBlock(result);
            
        
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}
#pragma mark 图书借阅查询会员借阅信息 还书
 
+ (AssistantRequest *)libraryManageReturnInfoWithUserId:(NSString*)userId
                                   successBlock:(void(^) (VipReturnInfoModel *returnInfoModel))successBlock
                                   failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
    if ([TRCStringUtil isEmpty:userId]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/librarymanage/queryByUserId";
    NSDictionary *params = @{@"url":url,@"userId":userId,@"type":@"return"};

    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            VipReturnInfoModel *returnInfoModel = [VipReturnInfoModel mj_objectWithKeyValues:result.output];
            successBlock(returnInfoModel);

        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}

#pragma mark 图书借阅查询会员借阅信息 借书

+ (AssistantRequest *)libraryManageLendInfoWithUserId:(NSString*)userId
                                   successBlock:(void(^) (VipLendInfoModel *lendInfoModel))successBlock
                                   failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
    if ([TRCStringUtil isEmpty:userId]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/librarymanage/queryByUserId";
    NSDictionary *params = @{@"url":url,@"userId":userId,@"type":@"lend"};

    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            
            VipLendInfoModel *lendInfo = [VipLendInfoModel mj_objectWithKeyValues:result.output];
     
            successBlock(lendInfo);
        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}




#pragma mark 图书借阅归还

+ (AssistantRequest *)libraryManageReturnBookWithBookId:(NSString*)jyId
                                     successBlock:(void(^) (TRCResult *resultInfo))successBlock
                                     failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
    if ([TRCStringUtil isEmpty:jyId]) {
        
        return nil;
        
    }
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/librarymanage/returned";
    NSDictionary *params = @{@"url":url,@"id":jyId};

    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        if (result) {
            successBlock(result);

        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}

#pragma mark 图书借阅新增

+ (AssistantRequest *)libraryManageSaveInfoWithRecord:(libraryRecordModel*)record
                                     successBlock:(void(^) (LendResultInfo *projectItemDetailModel))successBlock
                                     failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
  
    
    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/librarymanage/save";
    NSDictionary *params = @{@"url":url,@"storeId":record.storeId,@"userId":record.userId,@"list":[recordList mj_keyValuesArrayWithObjectArray:record.list]};

    request.contentType = TRCHTTPContentTypeJSON;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypePOST params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            LendResultInfo *lendinfo = [LendResultInfo mj_objectWithKeyValues:result.output];
            successBlock(lendinfo);

        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}

#pragma mark 图书借阅校验


+ (AssistantRequest *)libraryManagevlidateWithUserId:(NSString*)userId
                                             goodsSn:(NSString*)goodsSn
                                        successBlock:(void(^) (TRCResult *goodInfo))successBlock
                                        failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
    if ([TRCStringUtil isEmpty:goodsSn]) {
        
        return nil;
        
    }

    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/librarymanage/validate";
    NSDictionary *params = @{@"url":url,@"userId":userId,@"goodsSn":goodsSn};
    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
    
            successBlock(result);
            
        
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}


#pragma mark 根据会员二维码查询用户信息

+ (AssistantRequest *)vipInfoWithNumber:(NSString*)number
                                        successBlock:(void(^) ( NSString *vipInfoID))successBlock
                                        failureBlock:(TRCRequestFinishedBlock)failureBlock
{
    
    
    if ([TRCStringUtil isEmpty:number]) {
        
        return nil;
        
    }

    AssistantRequest *request = [[AssistantRequest alloc] init];
    NSString *url = @"app/user/getUserByNumber";
    NSDictionary *params = @{@"url":url,@"number":number};
    request.contentType = TRCHTTPContentTypeURLEncoded;
    
    AFHTTPSessionManager *manager = [AssistantHttpSessionManager defaultManager].loginCenterSessionManager;
    
    [request startWithSessionManager:manager requestType:TRCHTTPRequestTypeGET params:params successBlock:^(TRCResult *result) {
        
        if ([result.output isKindOfClass:[NSDictionary class]]) {
            NSString *vipid = [NSString stringWithFormat:@"%@",[result.output objectForKey:@"id"]];
            successBlock(vipid);
            
        }else{
            successBlock(nil);
            
        }
    } failureBlock:^(TRCResult *result) {
        
        
        failureBlock(result);
        
        
    }];
    
    
    return request;
    
}
@end
