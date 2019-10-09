//
//  StoreInfoModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/9.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreInfoModel : NSObject

@property(nonatomic,copy) NSString *incomeAmount;
@property(nonatomic,copy) NSString *refundAmount;
@property(nonatomic,copy) NSString *customerCount;
@property(nonatomic,copy) NSString *customerUnitPrice;
@property(nonatomic,copy) NSString *actualAmount;

@end

NS_ASSUME_NONNULL_END
