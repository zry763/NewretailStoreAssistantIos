//
//  OrderInfoViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^orderInfoCount)();
@interface OrderInfoViewController : BaseTableViewController
@property (nonatomic ,copy) orderInfoCount orderDelegete;



@end

NS_ASSUME_NONNULL_END
