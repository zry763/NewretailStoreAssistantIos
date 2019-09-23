//
//  StepModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StepModel : NSObject
@property (copy,nonatomic) NSString* firstSteptTitle;
@property (copy,nonatomic) NSString* secondSteptTitle;
@property (copy,nonatomic) NSString* thirdSteptTitle;
@property (assign,nonatomic) NSInteger currentStep;;

@end

NS_ASSUME_NONNULL_END
