//
//  GlobalHeader.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/16.
//  Copyright © 2019 zry. All rights reserved.
//

#ifndef GlobalHeader_h
#define GlobalHeader_h

// ------------------------ 输入框限制长度 -----------------------
/*
 账号             字母、数字，不允许包含特殊字符；唯一不可重复；3-15位字符；
 邮箱             邮箱格式必须输入正确；
 登录密码          密显；6-16位；字母、数字或符号；
 确认密码          密显；必须与“登录密码”一致；
 手机号码          11位数字；
 验证码            对应短信验证码，正确输入；
 */


/**
 *  账户密码最小输入长度
 */
#define INPUT_PASSWORD_MIN_LENGTH   6


/**
 *  账户密码最大输入长度
 */
#define INPUT_PASSWORD_MAX_LENGTH   20


/**
 *  手机号码输入长度
 */
#define INPUT_PHONE_NUMBER_LENGTH   11


/**
 *  短信验证码输入长度
 */
#define INPUT_VERIFICATION_CODE_LENGTH 4


#define TRC_BLOCK_WEAK_SELF    __weak __typeof(self) weakSelf = self;
#define TRC_BLOCK_STRONG_SELF  __strong __typeof(weakSelf) strongSelf = weakSelf;


#define LBXScan_Define_Native  //下载了native模块
#define LBXScan_Define_ZXing   //下载了ZXing模块
#define LBXScan_Define_ZBar   //下载了ZBar模块
#define LBXScan_Define_UI     //下载了界面模块
static NSString * const tableViewEndRefreshing = @"tableViewEndRefreshing";

extern BOOL  borringOrReturnFlag;

#endif /* GlobalHeader_h */
