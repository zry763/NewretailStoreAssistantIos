//
//  UserInfoModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/9.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject <NSCoding>

+ (id)sharedInstance;

/**
 *  解档
 */
-(void)archiveUserInfo:(UserInfoModel *)userinfo;

-(UserInfoModel *)accountInfoUnarchiver;


/**
 *  用户退出登陆或token 超时
 *
 *
 */
- (void)logout;
/**
 * 用户id
 */
@property (nonatomic, copy) NSString *userId;
/**
 * 用户手机号码
 */
@property (nonatomic, copy) NSString *mobile;
/**
 * 用户名称
 */

@property (nonatomic, copy) NSString *username;

/**
 * 门店id
 */
@property (nonatomic, copy) NSString *storeId;

/**
 * 门店名称
 */
@property (nonatomic, copy) NSString *storeName;

/**
 * 邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 * 门店编号
 */

@property (nonatomic, copy) NSString *storeNumber;

/**
 * 用户登录token
 */
@property (nonatomic, copy) NSString *token;


@end

NS_ASSUME_NONNULL_END
