//
//  YYhxItemTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYhxItemTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemTime;
@property (weak, nonatomic) IBOutlet UIImageView *itemState;

@end

NS_ASSUME_NONNULL_END
