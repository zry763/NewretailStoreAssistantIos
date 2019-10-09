//
//  ProjectItemModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/9.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectItemModel : NSObject
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *completedNum;
@property (nonatomic, copy) NSString *incompleteNum;

@end

NS_ASSUME_NONNULL_END
