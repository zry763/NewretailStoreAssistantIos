//
//  OrderInfoTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookName;

@property (weak, nonatomic) IBOutlet UILabel *bookNumber;
@property (weak, nonatomic) IBOutlet UILabel *bookCount;
@end

NS_ASSUME_NONNULL_END
