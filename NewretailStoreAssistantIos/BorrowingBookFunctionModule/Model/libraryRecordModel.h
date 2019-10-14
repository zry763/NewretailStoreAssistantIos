//
//  libraryRecordModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/14.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class recordList;

@interface libraryRecordModel : NSObject

@property (nonatomic, assign) NSInteger storeId;

@property (nonatomic, copy) NSString *lendingOperator;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, assign) NSInteger userId;

@end
@interface recordList : NSObject

@property (nonatomic, copy) NSString *goodsSn;

@property (nonatomic, assign) NSInteger lendingCount;
@end

NS_ASSUME_NONNULL_END
