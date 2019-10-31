//
//  HXDetailsViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//核销详情

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HXDetailsViewController : BaseTableViewController
@property (assign ,nonatomic) BOOL isDisplay;
@property(nonatomic ,copy) NSString *typeId;//项目类型id
@property(nonatomic ,copy) NSString *reservationCode;//项目类型id
@property(nonatomic ,assign) BOOL confirmBtDisplay;//确认核销

@end

NS_ASSUME_NONNULL_END
