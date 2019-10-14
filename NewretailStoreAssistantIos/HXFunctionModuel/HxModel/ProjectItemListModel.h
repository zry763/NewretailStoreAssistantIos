//
//  ProjectItemListModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/11.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectItemListModel : NSObject

@property (nonatomic, assign) NSInteger storeId;

@property (nonatomic, copy) NSString *confirmUserId;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger typeId;

@property (nonatomic, copy) NSString *activityTime;

@property (nonatomic, copy) NSString *reservationCode;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, strong) NSArray *goodsList;

@property (nonatomic, copy) NSString *activityName;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, copy) NSString *confirmUserName;

@property (nonatomic, assign) NSInteger orderStatus;

@property (nonatomic, copy) NSString *confirmTime;

@property (nonatomic, copy) NSString *orderStatusStr;

@property (nonatomic, copy) NSString *activityImg;
@end

NS_ASSUME_NONNULL_END
