//
//  PersonalViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/25.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *loginUserName;
@property (weak, nonatomic) IBOutlet UILabel *currentVersion;
/**
 * 退出登录保留当前门店编号
 */
- (IBAction)loginOut:(id)sender;
/**
 * 退出当前门店所有信息不保留
 */
- (IBAction)loginOutCurrentStore:(id)sender;

@end

NS_ASSUME_NONNULL_END
