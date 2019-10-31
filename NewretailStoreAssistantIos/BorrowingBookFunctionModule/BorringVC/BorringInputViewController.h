//
//  BorringInputViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^orderInfoCount)();

NS_ASSUME_NONNULL_BEGIN

@interface BorringInputViewController : BaseViewController
@property (nonatomic,copy) NSString *strScannedUserId;
@property (nonatomic ,copy) orderInfoCount orderDelegete;

@end

NS_ASSUME_NONNULL_END
