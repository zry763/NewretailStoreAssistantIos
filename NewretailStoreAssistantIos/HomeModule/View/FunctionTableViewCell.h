//
//  FunctionTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^FunctionModuel)(NSInteger index);
@interface FunctionTableViewCell : BaseTableViewCell
@property (copy,nonatomic) FunctionModuel functionIndex;
- (IBAction)selectFunctionModuel:(id)sender;

@end

NS_ASSUME_NONNULL_END
