//
//  AssistantTask.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/30.
//  Copyright © 2019 zry. All rights reserved.
//接口获取

#import <Foundation/Foundation.h>
#import "AssistantRequest.h"


#import "PageModel.h"
#import "UserInfoModel.h"
#import "StoreInfoModel.h"
#import "ProjectItemModel.h"
#import "ProjectItemListModel.h"
#import "ProjectItemDetailModel.h"
#import "hxStateDetailInfoModel.h"
#import "libraryRecordModel.h"

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
 *预约项目列表(登录用户所属门店存在待核销的项目列表)
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
                                      pageInfo:(PageModel*)pageInfo
                              successBlock:(void(^) (NSArray *orderArray,NSString *uncompleteCount,NSString *completeCount,PageModel *pageInfo))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock;

/**
*预约活动详情
*
*
*/
+ (AssistantRequest *)hxItemDetailInfoWithreservationCode :(NSString*)reservationCode
                              successBlock:(void(^) (hxStateDetailInfoModel *DetailInfoModel))successBlock
                              failureBlock:(TRCRequestFinishedBlock)failureBlock;


/**
*确认核销
*
*
*/
+ (AssistantRequest *)hxConfirmItemWithTypeId:(NSString*)typeId
                             reservationCode :(NSString*)reservationCode
                                 successBlock:(void(^) (ProjectItemDetailModel *projectItemDetailModel))successBlock
                                 failureBlock:(TRCRequestFinishedBlock)failureBlock;

/**
*预约搜索
*
*
*/
+ (AssistantRequest *)hxSearchItemInfoWithTypeId:(NSString*)typeId
                                        content :(NSString*)content
                                        pageInfo:(PageModel*)pageInfo
                                    successBlock:(void(^) (NSArray *orderArray,PageModel *pageInfo))successBlock
                                    failureBlock:(TRCRequestFinishedBlock)failureBlock;
/**
*预约码校验
*
*
 */
+ (AssistantRequest *)hxCheckItemInfoWithTypeId:(NSString*)typeId
                               reservationCode :(NSString*)reservationCode
                                   successBlock:(void(^) (ProjectItemDetailModel *projectItemDetailModel))successBlock
                                   failureBlock:(TRCRequestFinishedBlock)failureBlock;

/**
*图书借阅查询会员借阅信息

*
*
 */
+ (AssistantRequest *)libraryManageInfoWithUserId:(NSString*)userId
                               type :(NSString*)type
                                   successBlock:(void(^) (ProjectItemDetailModel *projectItemDetailModel))successBlock
                                   failureBlock:(TRCRequestFinishedBlock)failureBlock;
/**
*图书借阅归还

*
*
 */
+ (AssistantRequest *)libraryManageReturnInfoWithId:(NSString*)jyId
                                     successBlock:(void(^) (ProjectItemDetailModel *projectItemDetailModel))successBlock
                                     failureBlock:(TRCRequestFinishedBlock)failureBlock;
/**
*图书借阅新增

*
*
 */
+ (AssistantRequest *)libraryManageSaveInfoWithRecord:(libraryRecordModel*)record
                                     successBlock:(void(^) (ProjectItemDetailModel *projectItemDetailModel))successBlock
                                     failureBlock:(TRCRequestFinishedBlock)failureBlock;

/**
*图书借阅校验
*goodsSn 商品条码
*userId 会员id
 */
+ (AssistantRequest *)libraryManagevlidateWithUserId:(NSString*)userId
                                             goodsSn:(NSString*)goodsSn
                                        successBlock:(void(^) (ProjectItemDetailModel *projectItemDetailModel))successBlock
                                        failureBlock:(TRCRequestFinishedBlock)failureBlock;


/**
*
*根据会员二维码查询用户信息
 */
+ (AssistantRequest *)accountInfoWithNumber:(NSString*)number
                                        successBlock:(void(^) (ProjectItemDetailModel *projectItemDetailModel))successBlock
                                        failureBlock:(TRCRequestFinishedBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
