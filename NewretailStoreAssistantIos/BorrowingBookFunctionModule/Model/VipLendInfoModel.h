//
//  VipLendInfoModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipLendInfoModel : NSObject

@property (nonatomic, copy) NSString *userMemType;

@property (nonatomic, assign) NSInteger outTimeCount;

@property (nonatomic, assign) NSInteger couldLendFlag;//0 不能再借 1 可以借书

@property (nonatomic, assign) NSInteger waitingReturnCount;

@property (nonatomic, assign) NSInteger remainCount;

@property (nonatomic, copy) NSString *userName;
@end

NS_ASSUME_NONNULL_END
